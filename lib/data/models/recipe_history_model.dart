import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_generator/domain/entities/recipe_history.dart';

part 'recipe_history_model.g.dart';

@HiveType(typeId: 1)
class RecipeHistoryModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String ingredients;

  @HiveField(2)
  late DateTime createdAt;

  @HiveField(3)
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