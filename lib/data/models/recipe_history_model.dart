import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:recipe_generator/domain/entities/recipe_history.dart';

part 'recipe_history_model.g.dart';

@collection
class RecipeHistoryModel {
  // 数据库ID (Isar自动生成)
  Id isarId = Isar.autoIncrement;

  // 历史记录ID - 添加唯一索引
  @Index(unique: true)
  late String id;

  // 食材输入 - 添加索引以支持搜索
  @Index()
  late String ingredients;

  // 创建时间 - 添加索引以支持排序
  @Index()
  late DateTime createdAt;

  // 菜谱ID列表(JSON格式)
  late String recipeIdsJson;

  RecipeHistoryModel();

  RecipeHistoryModel.fromDomain(RecipeHistory history) {
    id = history.id;
    ingredients = history.ingredients;
    createdAt = history.createdAt;
    recipeIdsJson = jsonEncode(history.recipeIds);
  }

  RecipeHistory toDomain() {
    return RecipeHistory(
      id: id,
      ingredients: ingredients,
      createdAt: createdAt,
      recipeIds: _decodeRecipeIds(recipeIdsJson),
    );
  }

  List<String> _decodeRecipeIds(String json) {
    if (json.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }
}