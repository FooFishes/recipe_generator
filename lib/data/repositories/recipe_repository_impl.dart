import 'package:dio/dio.dart';
import 'package:recipe_generator/core/logging/app_logger.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';
import 'package:recipe_generator/data/services/api/recipe_api_service.dart';
import 'package:recipe_generator/data/services/storage/api_key_service.dart';
import 'package:recipe_generator/data/services/storage/database_service.dart';
import 'package:recipe_generator/data/services/storage/settings_service.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';
import 'package:recipe_generator/domain/entities/recipe_history.dart';
import 'package:recipe_generator/domain/repositories/recipe_repository.dart';
import 'package:recipe_generator/data/models/recipe_history_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeApiService _recipeApiService;
  final ApiKeyService _apiKeyService;
  final DatabaseService _databaseService;
  final SettingsService _settingsService;

  RecipeRepositoryImpl(
    this._recipeApiService,
    this._apiKeyService,
    this._databaseService,
    this._settingsService,
  );

  @override
  Future<List<Recipe>> generateRecipes(String ingredients, {bool forceCulturalStory = false}) async {
    AppLogger.logMethodEntry('RecipeRepositoryImpl', 'generateRecipes', {
      'ingredients': ingredients,
      'forceCulturalStory': forceCulturalStory,
    });
    
    final apiKey = await _apiKeyService.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      AppLogger.error('API密钥未设置');
      throw Exception('API密钥未设置，请先设置API密钥');
    }

    // 获取配置的模型和baseUrl，必须由用户配置
    final model = await _settingsService.getModel();
    if (model == null || model.isEmpty) {
      AppLogger.error('模型名称未设置');
      throw Exception('模型名称未设置，请先在设置中配置模型名称');
    }

    final baseUrl = await _settingsService.getBaseUrl();
    if (baseUrl == null || baseUrl.isEmpty) {
      AppLogger.error('基础URL未设置');
      throw Exception('基础URL未设置，请先在设置中配置基础URL');
    }

    AppLogger.info('开始生成菜谱，配置: model=$model, baseUrl=$baseUrl');
    
    try {
      final recipes = await _recipeApiService.generateRecipes(
        ingredients,
        apiKey,
        forceCulturalStory: forceCulturalStory,
        model: model,
        baseUrl: baseUrl,
      );

      if (recipes.isEmpty) {
        AppLogger.warning('API返回了空的菜谱列表');
        throw Exception('API返回了空的菜谱列表');
      }

      // 保存所有生成的菜谱到数据库（不管是否收藏）
      for (final recipe in recipes) {
        final existingRecipe = await _databaseService.getRecipeById(recipe.id);
        if (existingRecipe == null) {
          final recipeModel = RecipeModel.fromDomain(recipe);
          await _databaseService.saveRecipe(recipeModel);
        }
      }

      AppLogger.logMethodExit('RecipeRepositoryImpl', 'generateRecipes', 
          '成功生成${recipes.length}个菜谱');
      return recipes;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('API请求失败', e, stackTrace);
      throw Exception('API请求失败: ${e.message}');
    } catch (e, stackTrace) {
      AppLogger.error('生成菜谱时发生未知错误', e, stackTrace);
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
  
  @override
  Future<void> clearAllFavorites() async{
    try {
      final favorites = await _databaseService.getFavoriteRecipes();
      for (final recipe in favorites) {
        recipe.isFavorite = false;
        await recipe.save();
      }
    } catch (e) {
      throw Exception('清除收藏菜谱失败: ${e.toString()}');
    }
  }
  
  @override
  Future<List<Recipe>> getFavoriteRecipes() async {
    try {
      final recipeModels = await _databaseService.getFavoriteRecipes();
      return recipeModels.map((model) => model.toDomain()).toList();
    } catch (e) {
      throw Exception('获取收藏菜谱失败: ${e.toString()}');
    }
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final recipeModels = await _databaseService.getAllRecipes();
      return recipeModels.map((model) => model.toDomain()).toList();
    } catch (e) {
      throw Exception('获取所有菜谱失败: ${e.toString()}');
    }
  }

  @override
  Future<Recipe?> getRecipeById(String recipeId) async {
    try {
      final recipeModel = await _databaseService.getRecipeById(recipeId);
      return recipeModel?.toDomain();
    } catch (e) {
      throw Exception('获取菜谱失败: ${e.toString()}');
    }
  }
  
  @override
  Future<bool> isRecipeFavorite(String recipeId) async{
    try {
      bool isFavorite = await _databaseService.isRecipeFavorite(recipeId);
      return isFavorite;
    } catch (e) {
      throw Exception('检查菜谱是否收藏失败: ${e.toString()}');
    }
  }
  
  @override
  Future<void> removeFavoriteRecipe(String recipeId) async {
    AppLogger.logUserAction('取消收藏菜谱', {'recipeId': recipeId});
    try {
      final existingRecipe = await _databaseService.getRecipeById(recipeId);
      if (existingRecipe != null && existingRecipe.isFavorite) {
        existingRecipe.isFavorite = false;
        await existingRecipe.save();
      }
      AppLogger.info('成功取消收藏菜谱: $recipeId');
    } catch (e, stackTrace) {
      AppLogger.error('取消收藏菜谱失败', e, stackTrace);
      throw Exception('取消收藏菜谱失败: ${e.toString()}');
    }
  }
  
  @override
  Future<void> saveFavoriteRecipe(Recipe recipe) async {
    AppLogger.logUserAction('保存收藏菜谱', {'recipeId': recipe.id, 'recipeName': recipe.name});
    try {
      // 检查菜谱是否已存在
      final existingRecipe = await _databaseService.getRecipeById(recipe.id);
      if (existingRecipe != null) {
        // 如果已存在且未收藏，则设为收藏
        if (!existingRecipe.isFavorite) {
          existingRecipe.isFavorite = true;
          await existingRecipe.save();
        }
      } else {
        // 如果不存在，保存新的菜谱并设为收藏
        final recipeModel = RecipeModel.fromDomain(recipe.copyWith(
          isFavorite: true,
        ));
        await _databaseService.saveRecipe(recipeModel);
      }
      AppLogger.info('成功保存收藏菜谱: ${recipe.name}');
    } catch (e, stackTrace) {
      AppLogger.error('保存收藏菜谱失败', e, stackTrace);
      throw Exception('保存收藏菜谱失败: ${e.toString()}');
    }
  }
  
  @override
  Future<void> toggleFavoriteRecipe(String recipeId) async{
    try {
      await _databaseService.toggleFavorite(recipeId);
    } catch (e) {
      throw Exception('切换收藏菜谱失败: ${e.toString()}');
    }
  }

  @override
  Future<void> saveRecipeHistory(RecipeHistory history) async {
    AppLogger.logUserAction('保存菜谱历史记录', {'historyId': history.id, 'ingredients': history.ingredients});
    try {
      final historyModel = RecipeHistoryModel.fromDomain(history);
      await _databaseService.saveRecipeHistory(historyModel);
      AppLogger.info('成功保存菜谱历史记录: ${history.ingredients}');
    } catch (e, stackTrace) {
      AppLogger.error('保存菜谱历史记录失败', e, stackTrace);
      throw Exception('保存菜谱历史记录失败: ${e.toString()}');
    }
  }

  @override
  Future<List<RecipeHistory>> getRecipeHistory() async {
    try {
      final historyModels = await _databaseService.getRecipeHistory();
      return historyModels.map((model) => model.toDomain()).toList();
    } catch (e) {
      throw Exception('获取菜谱历史记录失败: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteRecipeHistory(String historyId) async {
    AppLogger.logUserAction('删除菜谱历史记录', {'historyId': historyId});
    try {
      await _databaseService.deleteRecipeHistory(historyId);
      AppLogger.info('成功删除菜谱历史记录: $historyId');
    } catch (e, stackTrace) {
      AppLogger.error('删除菜谱历史记录失败', e, stackTrace);
      throw Exception('删除菜谱历史记录失败: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllHistory() async {
    AppLogger.logUserAction('清空所有菜谱历史记录', {});
    try {
      await _databaseService.clearAllHistory();
      AppLogger.info('成功清空所有菜谱历史记录');
    } catch (e, stackTrace) {
      AppLogger.error('清空菜谱历史记录失败', e, stackTrace);
      throw Exception('清空菜谱历史记录失败: ${e.toString()}');
    }
  }
}