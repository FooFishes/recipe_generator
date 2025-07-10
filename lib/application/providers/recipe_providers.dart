import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_generator/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_generator/data/services/api/recipe_api_service.dart';
import 'package:recipe_generator/data/services/storage/api_key_service.dart';
import 'package:recipe_generator/data/services/storage/database_service.dart';
import 'package:recipe_generator/data/services/storage/settings_service.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';
import 'package:recipe_generator/domain/repositories/recipe_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 120);
  dio.options.sendTimeout = const Duration(seconds: 30);
  return dio;
});

final apiKeyServiceProvider = Provider<ApiKeyService>((ref) {
  return ApiKeyService();
});

final recipeApiServiceProvider = Provider<RecipeApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return RecipeApiService(dio);
});

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final recipeApiService = ref.watch(recipeApiServiceProvider);
  final apiKeyService = ref.watch(apiKeyServiceProvider);
  final databaseService = ref.watch(databaseServiceProvider);
  final settingsService = ref.watch(settingsServiceProvider);
  return RecipeRepositoryImpl(recipeApiService, apiKeyService, databaseService, settingsService);
});

final recipesProvider = StateNotifierProvider<RecipesNotifier, RecipesState>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  return RecipesNotifier(repository);
});

class RecipesState {
  final List<Recipe> recipes;
  final bool isLoading;
  final String? error;

  const RecipesState({
    this.recipes = const [],
    this.isLoading = false,
    this.error,
  });

  RecipesState copyWith({
    List<Recipe>? recipes,
    bool? isLoading,
    String? error,
  }) {
    return RecipesState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class RecipesNotifier extends StateNotifier<RecipesState> {
  final RecipeRepository _repository;

  RecipesNotifier(this._repository) : super(const RecipesState());

  Future<void> generateRecipes(String ingredients, {bool forceCulturalStory = false}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final recipes = await _repository.generateRecipes(ingredients, forceCulturalStory: forceCulturalStory);
      state = state.copyWith(recipes: recipes, isLoading: false);
    } catch (e) {
      String errorMessage = e.toString();
     
      if (errorMessage.contains('FormatException')) {
        errorMessage = '解析菜谱数据失败：API返回的数据格式不正确';
      } else if (errorMessage.contains('JSON解析失败')) {
        errorMessage = '解析菜谱数据失败：API返回的JSON格式错误';
      } else if (errorMessage.contains('API请求失败')) {
        errorMessage = '网络请求失败，请检查网络连接';
      } else if (errorMessage.contains('API密钥')) {
        errorMessage = 'API密钥错误，请检查密钥设置';
      } else if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11); // 移除 "Exception: " 前缀
      }
      
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearRecipes() {
    state = state.copyWith(recipes: []);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Recipe>>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  return FavoritesNotifier(repository);
});

// Provider for getting a single recipe by ID (from current session or favorites)
final recipeByIdProvider = FutureProvider.family<Recipe?, String>((ref, recipeId) async {
  final repository = ref.watch(recipeRepositoryProvider);
  final recipesState = ref.watch(recipesProvider);

  // 首先从当前会话的recipes中查找
  try {
    final recipe = recipesState.recipes.firstWhere(
      (r) => r.id == recipeId,
    );
    return recipe;
  } catch (e) {
    // 在当前会话中找不到，尝试从数据库中获取
    try {
      return await repository.getRecipeById(recipeId);
    } catch (e) {
      return null;
    }
  }
});

class FavoritesNotifier extends StateNotifier<List<Recipe>> {
  final RecipeRepository _repository;

  FavoritesNotifier(this._repository) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final favorites = await _repository.getFavoriteRecipes();
      final validFavorties = favorites.where((recipe) {
        return recipe.ingredients.isNotEmpty || recipe.name.isNotEmpty;
      }).toList();
      state = validFavorties;
    } catch (e) {
      state = [];
    }
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    try {
      final isFav = await _repository.isRecipeFavorite(recipe.id);

      if (isFav){
        await _repository.removeFavoriteRecipe(recipe.id);
        state = state.where((r) => r.id != recipe.id).toList();
      } else {
        await _repository.saveFavoriteRecipe(recipe);
        state = [...state, recipe.copyWith(isFavorite: true)];
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<bool> isFavorite(String recipeId) async { 
    try {
      return await _repository.isRecipeFavorite(recipeId);
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      for (final recipe in state){
        await _repository.removeFavoriteRecipe(recipe.id);
      }
      state = [];
    } catch (e) {
      // Handle error
    }
  }
}

final apiKeyProvider = StateNotifierProvider<ApiKeyNotifier, String?>((ref) {
  final service = ref.watch(apiKeyServiceProvider);
  return ApiKeyNotifier(service);
});

final culturalStoryProvider = StateNotifierProvider<CulturalStoryNotifier, bool>((ref) {
  final service = ref.watch(settingsServiceProvider);
  return CulturalStoryNotifier(service);
});

class ApiKeyNotifier extends StateNotifier<String?> {
  final ApiKeyService _service;

  ApiKeyNotifier(this._service) : super(null) {
    loadApiKey();
  }

  Future<void> loadApiKey() async {
    final apiKey = await _service.getApiKey();
    state = apiKey;
  }

  Future<void> saveApiKey(String apiKey) async {
    await _service.saveApiKey(apiKey);
    state = apiKey;
  }

  Future<void> deleteApiKey() async {
    await _service.deleteApiKey();
    state = null;
  }

  Future<bool> hasApiKey() async {
    return await _service.hasApiKey();
  }
}

class CulturalStoryNotifier extends StateNotifier<bool> {
  final SettingsService _service;

  CulturalStoryNotifier(this._service) : super(false) {
    loadCulturalStory();
  }

  Future<void> loadCulturalStory() async {
    final enabled = await _service.getCulturalStoryEnabled();
    state = enabled;
  }

  Future<void> toggle() async {
    final newValue = !state;
    await _service.setCulturalStoryEnabled(newValue);
    state = newValue;
  }

  Future<void> setEnabled(bool enabled) async {
    await _service.setCulturalStoryEnabled(enabled);
    state = enabled;
  }
}

final modelProvider = StateNotifierProvider<ModelNotifier, String?>((ref){
  final service = ref.watch(settingsServiceProvider);
  return ModelNotifier(service);
});

final baseUrlProvider = StateNotifierProvider<BaseUrlNotifier, String?>((ref){
  final service = ref.watch(settingsServiceProvider);
  return BaseUrlNotifier(service);
});

class ModelNotifier extends StateNotifier<String?> {
  final SettingsService _service;

  ModelNotifier(this._service) : super(null) {
    loadModel();
  }

  Future<void> loadModel() async {
    final model = await _service.getModel();
    state = model;
  }

  Future<void> setModel(String model) async {
    await _service.setModel(model);
    state = model;
  }
}

class BaseUrlNotifier extends StateNotifier<String?> {
  final SettingsService _service;

  BaseUrlNotifier(this._service) : super(null) {
    loadBaseUrl();
  }

  Future<void> loadBaseUrl() async {
    final baseUrl = await _service.getBaseUrl();
    state = baseUrl;
  }

  Future<void> setBaseUrl(String baseUrl) async {
    await _service.setBaseUrl(baseUrl);
    state = baseUrl;
  }
}
