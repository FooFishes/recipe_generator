import 'dart:convert';
import 'dart:math';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/ingredient.dart';
import '../../../domain/entities/nutrition_analysis.dart';
import '../../../domain/entities/cultural_story.dart';
/// 菜谱数据解析器
/// 
/// 负责将AI返回的JSON数据解析为Recipe对象列表。
/// 将复杂的解析逻辑从主服务类中分离，提高代码可读性和可维护性。
class RecipeDataParser {
  /// 解析菜谱的主要方法
  /// 
  /// 参数：
  /// - [content] AI返回的原始字符串内容
  /// 
  /// 返回：解析后的菜谱对象列表
  static List<Recipe> parseRecipes(String content) {
    
    try {
      // 检查内容是否为空
      if (content.trim().isEmpty) {
        throw Exception('API返回的内容为空');
      }
      
      final jsonData = _cleanAndParseJson(content);
      final recipesData = _validateJsonStructure(jsonData);
      final recipes = _parseRecipeList(recipesData);
      
      return recipes;
    } catch (e) {
      
      // 提供更详细的错误信息
      if (e.toString().contains('FormatException')) {
        throw Exception('API返回的数据格式不正确，无法解析JSON');
      } else if (e.toString().contains('Unexpected end of input')) {
        throw Exception('API返回的数据被截断，可能是网络问题');
      } else {
        throw Exception('解析菜谱数据失败: ${e.toString()}');
      }
    }
  }
  
  /// 清理并解析JSON字符串
  static Map<String, dynamic> _cleanAndParseJson(String content) {
    // 清理可能的markdown代码块标记，确保纯JSON格式
    final cleanContent = content
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();
    
    try {
      return json.decode(cleanContent);
    } catch (e) {
      // 提供更详细的错误信息
      throw Exception('JSON解析失败: $e\n内容长度: ${cleanContent.length}');
    }
  }
  
  /// 验证JSON结构的完整性
  static List<dynamic> _validateJsonStructure(Map<String, dynamic> jsonData) {
    if (jsonData['recipes'] == null || jsonData['recipes'] is! List) {
      throw Exception('返回的数据格式不正确：缺少recipes字段或格式错误');
    }
    
    final recipesData = jsonData['recipes'] as List;
    if (recipesData.isEmpty) {
      throw Exception('返回的菜谱列表为空');
    }
    
    return recipesData;
  }
  
  /// 解析菜谱列表
  static List<Recipe> _parseRecipeList(List<dynamic> recipesData) {
    return recipesData.map((recipeData) {
      try {
        return _parseSingleRecipe(recipeData);
      } catch (e) {
        return null;
      }
    }).where((recipe) => recipe != null).cast<Recipe>().toList();
  }
  
  /// 解析单个菜谱
  static Recipe _parseSingleRecipe(dynamic recipeData) {
    final ingredients = _parseIngredients(recipeData['ingredients']);
    final instructions = _parseInstructions(recipeData['instructions']);
    final tags = _parseTags(recipeData['tags']);
    final nutrition = _parseNutrition(recipeData['nutrition']);
    final culturalStory = _parseCulturalStory(recipeData['cultural_story']);
    
    final recipe = Recipe(
      id: _generateUniqueRecipeId(recipeData['id']?.toString()),
      name: recipeData['name']?.toString() ?? '未知菜谱',
      description: recipeData['description']?.toString() ?? '',
      ingredients: ingredients,
      instructions: instructions,
      prepTime: _parseIntValue(recipeData['prepTime']),
      cookTime: _parseIntValue(recipeData['cookTime']),
      servings: _parseIntValue(recipeData['servings'], defaultValue: 1),
      difficulty: recipeData['difficulty']?.toString() ?? '简单',
      cuisine: recipeData['cuisine']?.toString() ?? '未知',
      tags: tags,
      nutrition: nutrition,
      culturalStory: culturalStory,
      createdAt: DateTime.now(),
    );
    
    return recipe;
  }
  
  /// 解析食材列表
  static List<Ingredient> _parseIngredients(dynamic ingredientsData) {
    if (ingredientsData is! List) return [];
    
    return ingredientsData.map((ing) {
      if (ing is! Map) return null;
      
      return Ingredient(
        name: ing['name']?.toString() ?? '',
        amount: _parseDoubleValue(ing['amount']),
        unit: ing['unit']?.toString() ?? '',
        isOptional: ing['isOptional'] == true,
      );
    }).where((ingredient) => ingredient != null).cast<Ingredient>().toList();
  }
  
  /// 解析烹饪步骤
  static List<String> _parseInstructions(dynamic instructionsData) {
    if (instructionsData is! List) return [];
    
    return instructionsData
        .map((inst) => inst?.toString() ?? '')
        .where((step) => step.isNotEmpty)
        .toList();
  }
  
  /// 解析菜谱标签
  static List<String> _parseTags(dynamic tagsData) {
    if (tagsData is! List) return [];
    
    return tagsData
        .map((tag) => tag?.toString() ?? '')
        .where((tag) => tag.isNotEmpty)
        .toList();
  }
  
  /// 解析营养分析数据
  static NutritionAnalysis _parseNutrition(dynamic nutritionData) {
    if (nutritionData is! Map) {
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
    
    return NutritionAnalysis(
      calories: _parseDoubleValue(nutritionData['calories']),
      protein: _parseDoubleValue(nutritionData['protein']),
      carbs: _parseDoubleValue(nutritionData['carbs']),
      fat: _parseDoubleValue(nutritionData['fat']),
      fiber: _parseDoubleValue(nutritionData['fiber']),
      sugar: _parseDoubleValue(nutritionData['sugar']),
      sodium: _parseDoubleValue(nutritionData['sodium']),
      summary: nutritionData['summary']?.toString() ?? '',
      guidance: nutritionData['guidance']?.toString() ?? '',
    );
  }
  
  /// 解析文化故事
  static CulturalStory? _parseCulturalStory(dynamic culturalStoryData) {
    
    if (culturalStoryData is! Map) {
      return null;
    }
    
    final triggerIngredient = culturalStoryData['trigger_ingredient']?.toString() ?? '';
    final title = culturalStoryData['title']?.toString() ?? '';
    final content = culturalStoryData['content']?.toString() ?? '';
    
    // 如果所有字段都为空，则不创建文化故事对象
    if (triggerIngredient.isEmpty && title.isEmpty && content.isEmpty) {
      return null;
    }
    
    return CulturalStory(
      triggerIngredient: triggerIngredient,
      title: title,
      content: content,
    );
  }
  
  /// 解析整数值
  static int _parseIntValue(dynamic value, {int defaultValue = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
    }
    return defaultValue;
  }
  
  /// 解析双精度值
  static double _parseDoubleValue(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    return 0.0;
  }

  static String _generateUniqueRecipeId(String? originalId) {
    final random = Random();
    final randomSuffix = random.nextInt(999999).toString().padLeft(6, '0');
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    if (originalId != null && originalId.isNotEmpty) {
      return '${originalId}_${randomSuffix}_$timeStamp';
    } else {
      return 'recipe_${randomSuffix}_$timeStamp';
    }
  }
}
