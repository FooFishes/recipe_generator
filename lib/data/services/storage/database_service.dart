import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';
import 'package:recipe_generator/data/models/recipe_history_model.dart';

class DatabaseService {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) {
      return _isar!;
    }

    if (kIsWeb) {
      // Web平台使用默认配置
      _isar = await Isar.open(
        [RecipeModelSchema, RecipeHistoryModelSchema],
        directory: '', // Web平台使用空字符串
      );
    } else {
      // 移动平台需要指定目录
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [RecipeModelSchema, RecipeHistoryModelSchema],
        directory: dir.path,
      );
    }
    return _isar!;
  }

  Future<void> saveRecipe(RecipeModel recipe) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.recipeModels.put(recipe);
    });
  }

  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final isar = await instance;
    return await isar.recipeModels.filter().isFavoriteEqualTo(true).findAll();
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    final isar = await instance;
    return await isar.recipeModels.where().findAll();
  }

  Future<void> toggleFavorite(String recipeId) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      final recipe = await isar.recipeModels.filter().recipeIdEqualTo(recipeId).findFirst();
      if (recipe != null) {
        recipe.isFavorite = !recipe.isFavorite;
        await isar.recipeModels.put(recipe);
      } else {
        throw Exception('菜谱未找到，无法切换收藏状态: $recipeId');
      }
    });
  }

  Future<void> deleteRecipe(String recipeId) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      final recipe = await isar.recipeModels.filter().recipeIdEqualTo(recipeId).findFirst();
      if (recipe != null) {
        await isar.recipeModels.delete(recipe.id);
      } else {
        throw Exception('菜谱未找到，无法删除: $recipeId');
      }
    });
  }

  Future<void> clearAllFavorites() async {
    final isar = await instance;
    await isar.writeTxn(() async {
      final favoriteRecipes = await isar.recipeModels.filter().isFavoriteEqualTo(true).findAll();
      for (final recipe in favoriteRecipes) {
        recipe.isFavorite = false;
        await isar.recipeModels.put(recipe);
      }
    });
  }

  Future<bool> isRecipeFavorite(String recipeId) async {
    final isar = await instance;
    final recipe = await isar.recipeModels.filter().recipeIdEqualTo(recipeId).findFirst();
    return recipe?.isFavorite ?? false;
  }

  Future<RecipeModel?> getRecipeById(String recipeId) async {
    final isar = await instance;
    return await isar.recipeModels.filter().recipeIdEqualTo(recipeId).findFirst();
  }

  Future<void> saveRecipeHistory(RecipeHistoryModel history) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.recipeHistoryModels.put(history);
    });
  }

  Future<List<RecipeHistoryModel>> getRecipeHistory() async {
    final isar = await instance;
    return await isar.recipeHistoryModels.where().sortByCreatedAtDesc().findAll();
  }

  Future<void> deleteRecipeHistory(String historyId) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      final history = await isar.recipeHistoryModels.filter().idEqualTo(historyId).findFirst();
      if (history != null) {
        await isar.recipeHistoryModels.delete(history.isarId);
      } else {
        throw Exception('历史记录未找到，无法删除: $historyId');
      }
    });
  }

  Future<void> clearAllHistory() async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.recipeHistoryModels.clear();
    });
  }
}