import 'package:dio/dio.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';
import 'package:recipe_generator/data/services/api/recipe_api_service.dart';
import 'package:recipe_generator/data/services/storage/api_key_service.dart';
import 'package:recipe_generator/data/services/storage/database_service.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';
import 'package:recipe_generator/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeApiService _recipeApiService;
  final ApiKeyService _apiKeyService;
  final DatabaseService _databaseService;

  RecipeRepositoryImpl(
    this._recipeApiService,
    this._apiKeyService,
    this._databaseService,
  );

  @override
  Future<List<Recipe>> generateRecipes(String ingredients, {bool forceCulturalStory = false}) async {
    final apiKey = await _apiKeyService.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API密钥未设置，请先设置API密钥');
    }

    try {
      final recipes = await _recipeApiService.generateRecipes(
        ingredients,
        apiKey, 
        forceCulturalStory: forceCulturalStory
      );

      if (recipes.isEmpty) {
        throw Exception('API返回了空的菜谱列表');
      }

      return recipes;
    } on DioException catch (e) {
      throw Exception('API请求失败: ${e.message}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
  
  @override
  Future<void> clearAllFavorites() async{
    try {
      await _databaseService.clearAllFavorites();
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
    try {
      return await _databaseService.deleteRecipe(recipeId);
    } catch (e) {
      throw Exception('删除收藏菜谱失败: ${e.toString()}');
    }
  }
  
  @override
  Future<void> saveFavoriteRecipe(Recipe recipe) async {
    try {
      final recipeModel = RecipeModel.fromDomain(recipe.copyWith(
        isFavorite: true,
      ));
      return await _databaseService.saveRecipe(recipeModel);
    } catch (e) {
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
}