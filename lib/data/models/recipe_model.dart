import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_generator/domain/entities/cultural_story.dart';
import 'package:recipe_generator/domain/entities/ingredient.dart';
import 'package:recipe_generator/domain/entities/nutrition_analysis.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel extends HiveObject{
  // 数据库ID
  @HiveField(0)
  int? id;

  // 食谱ID(JSON中的唯一标识符)
  @HiveField(1)
  late String recipeId;

  // 名称
  @HiveField(2)
  late String name;

  // 描述
  @HiveField(3)
  late String description;

  // 食材(JSON格式)
  @HiveField(4)
  late String ingredientsJson;

  // 烹饪步骤(JSON格式)
  @HiveField(5)
  late String instructionsJson;

  // 准备时间
  @HiveField(6)
  late int prepTime;

  // 烹饪时间
  @HiveField(7)
  late int cookTime;

  // 几人份
  @HiveField(8)
  late int servings;

  // 烹饪难度
  @HiveField(9)
  late String difficulty;

  // 菜系
  @HiveField(10)
  late String cuisine;

  // 标签(JSON格式)
  @HiveField(11)
  late String tagsJson;

  // 营养信息(JSON格式)
  @HiveField(12)
  late String nutritionJson;

  // 创建时间
  @HiveField(13)
  late DateTime createdAt;

  // 收藏状态
  @HiveField(14)
  late bool isFavorite;

  // 文化故事(JSON格式)
  @HiveField(15)
  String? culturalStoryJson;

  RecipeModel();
  
  RecipeModel.formDomain(Recipe recipe) {
    recipeId = recipe.id;
    name = recipe.name;
    description = recipe.description;
    ingredientsJson = _encodeIngredients(recipe.ingredients);
    instructionsJson = _encodeInstructions(recipe.instructions);
    prepTime = recipe.prepTime;
    cookTime = recipe.cookTime;
    servings = recipe.servings;
    difficulty = recipe.difficulty;
    cuisine = recipe.cuisine;
    tagsJson = _encodeTags(recipe.tags);
    nutritionJson = _encodeNutrition(recipe.nutrition);
    culturalStoryJson = _encodeCulturalStory(recipe.culturalStory);
    createdAt = recipe.createdAt;
    isFavorite = recipe.isFavorite;
  }

  Recipe toDomain() {
    return Recipe(
      id: recipeId,
      name: name,
      description: description,
      ingredients: _decodeIngredients(ingredientsJson),
      instructions: _decodeInstructions(instructionsJson),
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      difficulty: difficulty,
      cuisine: cuisine,
      tags: _decodeTags(tagsJson),
      nutrition: _decodeNutrition(nutritionJson),
      culturalStory: _decodeCulturalStory(culturalStoryJson),
      createdAt: createdAt,
      isFavorite: isFavorite,
    );
  }

  String _encodeIngredients(List<Ingredient> ingredients) {
    return jsonEncode(ingredients.map((e) => e.toJson()).toList());
  }

  List<Ingredient> _decodeIngredients(String json) {
    if (json.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => Ingredient.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  String _encodeInstructions(List<String> instructions) {
    return jsonEncode(instructions);
  }

  List<String> _decodeInstructions(String json) {
    if (json.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  String _encodeTags(List<String> tags) {
    return jsonEncode(tags);
  }

  List<String> _decodeTags(String json) {
    if (json.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  String _encodeNutrition(NutritionAnalysis nutrition) {
    return jsonEncode(nutrition.toJson());
  }

  NutritionAnalysis _decodeNutrition(String json) {
    if (json.isEmpty) {
      return const NutritionAnalysis(
        calories: 0,
        protein: 0,
        carbs: 0,
        fat: 0,
        fiber: 0,
        sugar: 0,
        sodium: 0,
        summary: '',
        guidance: '',
      );
    }
    try {
      final Map<String, dynamic> decoded = jsonDecode(json);
      return NutritionAnalysis.fromJson(decoded);
    } catch (e) {
      return const NutritionAnalysis(
        calories: 0,
        protein: 0,
        carbs: 0,
        fat: 0,
        fiber: 0,
        sugar: 0,
        sodium: 0,
        summary: '',
        guidance: '',
      );
    }
  }

  String? _encodeCulturalStory(CulturalStory? story) {
    if (story == null) return null;
    return jsonEncode(story.toJson());
  }

  CulturalStory? _decodeCulturalStory(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      final Map<String, dynamic> data = jsonDecode(json);
      return CulturalStory.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}