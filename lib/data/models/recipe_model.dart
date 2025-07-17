import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:recipe_generator/domain/entities/cultural_story.dart';
import 'package:recipe_generator/domain/entities/ingredient.dart';
import 'package:recipe_generator/domain/entities/nutrition_analysis.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@collection
class RecipeModel {
  // 数据库ID (Isar自动生成)
  Id id = Isar.autoIncrement;

  // 食谱ID(JSON中的唯一标识符) - 添加唯一索引
  @Index(unique: true)
  late String recipeId;

  // 名称 - 添加索引以支持搜索
  @Index()
  late String name;

  // 描述
  late String description;

  // 食材(JSON格式)
  late String ingredientsJson;

  // 烹饪步骤(JSON格式)
  late String instructionsJson;

  // 准备时间
  late int prepTime;

  // 烹饪时间
  late int cookTime;

  // 几人份
  late int servings;

  // 烹饪难度 - 添加索引以支持过滤
  @Index()
  late String difficulty;

  // 菜系 - 添加索引以支持过滤
  @Index()
  late String cuisine;

  // 标签(JSON格式)
  late String tagsJson;

  // 营养信息(JSON格式)
  late String nutritionJson;

  // 创建时间 - 添加索引以支持排序
  @Index()
  late DateTime createdAt;

  // 收藏状态 - 添加索引以支持快速查询收藏
  @Index()
  late bool isFavorite;

  // 文化故事(JSON格式)
  String? culturalStoryJson;

  RecipeModel();

  RecipeModel.fromDomain(Recipe recipe) {
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