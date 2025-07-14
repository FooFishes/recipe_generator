import 'package:hive/hive.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';
import 'package:recipe_generator/data/models/recipe_history_model.dart';

class DatabaseService {
  static Box<RecipeModel>? _recipeBox;
  static Box<RecipeHistoryModel>? _historyBox;

  static Future<Box<RecipeModel>> get instance async{
    if(_recipeBox != null) {
      return _recipeBox!;
    }
    Hive.registerAdapter(RecipeModelAdapter());
    _recipeBox = await Hive.openBox<RecipeModel>('recipes');
    return _recipeBox!;
  }

  static Future<Box<RecipeHistoryModel>> get historyInstance async{
    if(_historyBox != null) {
      return _historyBox!;
    }
    Hive.registerAdapter(RecipeHistoryModelAdapter());
    _historyBox = await Hive.openBox<RecipeHistoryModel>('recipe_history');
    return _historyBox!;
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

  Future<List<RecipeModel>> getAllRecipes() async {
    final box = await instance;
    return box.values.toList();
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
    final recipes = box.values.toList();
    for (final recipe in recipes) {
      if (recipe.isFavorite) {
        recipe.isFavorite = false;
        await recipe.save();
      }
    }
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

  Future<void> saveRecipeHistory(RecipeHistoryModel history) async {
    final box = await historyInstance;
    await box.add(history);
  }

  Future<List<RecipeHistoryModel>> getRecipeHistory() async {
    final box = await historyInstance;
    final historyList = box.values.toList();
    historyList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return historyList;
  }

  Future<void> deleteRecipeHistory(String historyId) async {
    final box = await historyInstance;
    try {
      final history = box.values.firstWhere((history) => history.id == historyId);
      await history.delete();
    } catch (e) {
      throw Exception('历史记录未找到，无法删除: $historyId');
    }
  }

  Future<void> clearAllHistory() async {
    final box = await historyInstance;
    await box.clear();
  }
}