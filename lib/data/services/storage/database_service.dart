import 'package:hive/hive.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';

class DatabaseService {
  static Box<RecipeModel>? _recipeBox;

  static Future<Box<RecipeModel>> get instance async{
    if(_recipeBox != null) {
      return _recipeBox!;
    }
    Hive.registerAdapter(RecipeModelAdapter());
    _recipeBox = await Hive.openBox<RecipeModel>('recipes');
    return _recipeBox!;
  }

  Future<void> saveRecipe(RecipeModel recipe) async {
    final box = await instance;
    await box.add(recipe);
  }

  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final box = await instance;
    final favourites = box.values.where((recipe) => recipe.isFavorite).toList();
    return favourites;
  }

  Future<void> toggleFavorite(String recipeId) async {
    final box = await instance;
    try {
      final recipe = box.values.firstWhere((recipe) => recipe.recipeId == recipeId);
      recipe.isFavorite = !recipe.isFavorite;
      await recipe.save();
    } catch (e) {
      throw Exception('菜谱未找到，无法切换收藏状态: $recipeId');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    final box = await instance;
    try {
      final recipe = box.values.firstWhere((recipe) => recipe.recipeId == recipeId);
      await recipe.delete();
    } catch (e) {
      throw Exception('菜谱未找到，无法删除: $recipeId');
    }
  }

  Future<void> clearAllFavorites() async {
    final box = await instance;
    await box.clear();
  }

  Future<bool> isRecipeFavorite(String recipeId) async {
    final box = await instance;
    try {
      final recipe = box.values.firstWhere(
        (recipe) => recipe.recipeId == recipeId,
      );
      return recipe.isFavorite;
    } catch (e) {
      // 如果找不到菜谱，返回false（未收藏）
      return false;
    }
  }

  Future<RecipeModel?> getRecipeById(String recipeId) async {
    final box = await instance;
    try {
      final recipe = box.values.firstWhere(
        (recipe) => recipe.recipeId == recipeId,
      );
      return recipe;
    } catch (e) {
      // 如果找不到菜谱，返回null
      return null;
    }
  }
}