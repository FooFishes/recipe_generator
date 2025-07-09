import 'package:recipe_generator/domain/entities/cultural_story.dart';
import 'package:recipe_generator/domain/entities/ingredient.dart';
import 'package:recipe_generator/domain/entities/nutrition_analysis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.g.dart';
part 'recipe.freezed.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    // 食谱ID(JSON中的唯一标识符)
    required String id,
    // 名称
    required String name,
    // 描述
    required String description,
    // 食材列表
    required List<Ingredient> ingredients,
    // 烹饪步骤
    required List<String> instructions,
    // 准备时间
    required int prepTime,
    // 烹饪时间
    required int cookTime,
    // 几人份
    required int servings,
    // 烹饪难度
    required String difficulty,
    // 菜系
    required String cuisine,
    // 标签
    required List<String> tags,
    // 营养信息
    required NutritionAnalysis nutrition,
    // 文化故事
    CulturalStory? culturalStory,
    // 创建时间
    required DateTime createdAt,
    // 是否收藏
    @Default(false) bool isFavorite,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}

extension RecipeExtension on Recipe {
  // 计算总时间
  int get totalTime => prepTime + cookTime;
}