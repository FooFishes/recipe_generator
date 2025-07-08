import 'package:recipe_generator/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getFavoriteRecipes();
  Future<void> saveFavoriteRecipe(Recipe recipe);
  Future<void> removeFavoriteRecipe(Recipe recipe);
  Future<void> toggleFavoriteRecipe(Recipe recipe);
  Future<bool> isRecipeFavorite(Recipe recipe);
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