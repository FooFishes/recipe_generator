import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';
import 'package:recipe_generator/data/models/recipe_history_model.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';
import 'package:recipe_generator/domain/entities/recipe_history.dart';
import 'package:recipe_generator/domain/entities/ingredient.dart';
import 'package:recipe_generator/domain/entities/nutrition_analysis.dart';

void main() {
  group('Database Migration Tests', () {
    test('RecipeModel should convert to/from domain correctly', () {
      // 创建测试数据
      final recipe = Recipe(
        id: 'test-recipe-1',
        name: '测试菜谱',
        description: '这是一个测试菜谱',
        ingredients: [
          const Ingredient(
            name: '鸡蛋',
            amount: 2,
            unit: '个',
            isOptional: false,
          ),
        ],
        instructions: ['步骤1', '步骤2'],
        prepTime: 10,
        cookTime: 20,
        servings: 2,
        difficulty: '简单',
        cuisine: '中式',
        tags: ['快手菜', '家常菜'],
        nutrition: const NutritionAnalysis(
          calories: 200,
          protein: 15,
          carbs: 10,
          fat: 8,
          fiber: 2,
          sugar: 5,
          sodium: 300,
          summary: '营养丰富',
          guidance: '适合早餐',
        ),
        createdAt: DateTime.now(),
        isFavorite: true,
      );

      // 转换为模型
      final model = RecipeModel.fromDomain(recipe);
      
      // 验证基本字段
      expect(model.recipeId, equals(recipe.id));
      expect(model.name, equals(recipe.name));
      expect(model.description, equals(recipe.description));
      expect(model.prepTime, equals(recipe.prepTime));
      expect(model.cookTime, equals(recipe.cookTime));
      expect(model.servings, equals(recipe.servings));
      expect(model.difficulty, equals(recipe.difficulty));
      expect(model.cuisine, equals(recipe.cuisine));
      expect(model.isFavorite, equals(recipe.isFavorite));

      // 转换回领域对象
      final convertedRecipe = model.toDomain();
      
      // 验证转换后的数据
      expect(convertedRecipe.id, equals(recipe.id));
      expect(convertedRecipe.name, equals(recipe.name));
      expect(convertedRecipe.description, equals(recipe.description));
      expect(convertedRecipe.ingredients.length, equals(recipe.ingredients.length));
      expect(convertedRecipe.instructions.length, equals(recipe.instructions.length));
      expect(convertedRecipe.tags.length, equals(recipe.tags.length));
      expect(convertedRecipe.isFavorite, equals(recipe.isFavorite));
    });

    test('RecipeHistoryModel should convert to/from domain correctly', () {
      // 创建测试历史记录
      final history = RecipeHistory(
        id: 'test-history-1',
        ingredients: '鸡蛋, 番茄',
        createdAt: DateTime.now(),
        recipeIds: ['recipe-1', 'recipe-2'],
      );

      // 转换为模型
      final model = RecipeHistoryModel.fromDomain(history);
      
      // 验证基本字段
      expect(model.id, equals(history.id));
      expect(model.ingredients, equals(history.ingredients));
      expect(model.createdAt, equals(history.createdAt));

      // 转换回领域对象
      final convertedHistory = model.toDomain();
      
      // 验证转换后的数据
      expect(convertedHistory.id, equals(history.id));
      expect(convertedHistory.ingredients, equals(history.ingredients));
      expect(convertedHistory.recipeIds.length, equals(history.recipeIds.length));
      expect(convertedHistory.recipeIds, equals(history.recipeIds));
    });

    test('Recipe entity should have all required properties', () {
      final recipe = Recipe(
        id: 'test-id',
        name: 'Test Recipe',
        description: 'Test Description',
        ingredients: [],
        instructions: [],
        prepTime: 10,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        cuisine: 'Test',
        tags: [],
        nutrition: const NutritionAnalysis(
          calories: 0,
          protein: 0,
          carbs: 0,
          fat: 0,
          fiber: 0,
          sugar: 0,
          sodium: 0,
          summary: '',
          guidance: '',
        ),
        createdAt: DateTime.now(),
      );

      // 验证所有属性都可以访问
      expect(recipe.id, isNotNull);
      expect(recipe.name, isNotNull);
      expect(recipe.description, isNotNull);
      expect(recipe.ingredients, isNotNull);
      expect(recipe.instructions, isNotNull);
      expect(recipe.prepTime, isNotNull);
      expect(recipe.cookTime, isNotNull);
      expect(recipe.servings, isNotNull);
      expect(recipe.difficulty, isNotNull);
      expect(recipe.cuisine, isNotNull);
      expect(recipe.tags, isNotNull);
      expect(recipe.nutrition, isNotNull);
      expect(recipe.createdAt, isNotNull);
      expect(recipe.isFavorite, isFalse); // 默认值

      // 测试copyWith方法
      final updatedRecipe = recipe.copyWith(isFavorite: true);
      expect(updatedRecipe.isFavorite, isTrue);
      expect(updatedRecipe.id, equals(recipe.id)); // 其他字段保持不变
    });
  });
}
