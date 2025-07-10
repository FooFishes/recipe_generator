import 'package:recipe_generator/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> generateRecipes(String ingredients, {bool forceCulturalStory = false});
  Future<List<Recipe>> getFavoriteRecipes();
  Future<Recipe?> getRecipeById(String recipeId);
  Future<void> saveFavoriteRecipe(Recipe recipe);
  Future<void> removeFavoriteRecipe(String recipeId);
  Future<void> toggleFavoriteRecipe(String recipeId);
  Future<bool> isRecipeFavorite(String recipeId);
  Future<void> clearAllFavorites();

  //TODO: 缓存,搜索和过滤功能
  // // 缓存相关操作
  // Future<void> cacheRecipes(List<Recipe> recipes);
  // Future<List<Recipe>> getCachedRecipes();
  // Future<void> clearCache();
  
  // // 搜索和过滤
  // Future<List<Recipe>> searchRecipes(String query);
  // Future<List<Recipe>> getRecipesByTag(String tag);
}