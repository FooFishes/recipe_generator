/// 菜谱提示词构建器
/// 
/// 负责构建发送给AI的系统提示词，支持不同的模式和配置。
/// 将复杂的提示词构建逻辑从主服务类中分离出来，提高代码可读性。
class RecipePromptBuilder {
  /// 构建系统提示词
  /// 
  /// 参数：
  /// - [forceCulturalStory] 是否强制生成文化故事
  /// 
  /// 返回：完整的系统提示词字符串
  static String buildSystemPrompt({bool forceCulturalStory = false}) {
    final basePrompt = _getBasePrompt();
    final culturalStoryInstruction = _getCulturalStoryInstruction(forceCulturalStory);
    
    return '$basePrompt$culturalStoryInstruction\n\n请严格按照JSON格式返回，不要添加任何其他内容，不可以使用"适量"。';
  }
  
  /// 获取JSON响应格式规范
  static Map<String, dynamic> getResponseFormat({bool forceCulturalStory = false}) {
    return {
      "type": "json_schema",
      "json_schema": {
        "name": "recipe_generation",
        "description": "Generate recipes based on provided ingredients",
        "schema": _getRecipeSchema(forceCulturalStory: forceCulturalStory),
        "strict": true
      }
    };
  }
  
  /// 获取基础提示词
  static String _getBasePrompt() {
    return '''你是一位专业的营养师和烹饪专家。根据用户提供的食材，生成3个健康美味的菜谱。''';
  }
  
  /// 获取文化故事相关指令
  static String _getCulturalStoryInstruction(bool forceCulturalStory) {
    if (forceCulturalStory) {
      return '''
    
**重要：你必须为每个菜谱都提供相关的文化背景故事。请深入挖掘食材的历史渊源、地域特色、传统用法或文化意义，提供有趣且富有教育意义的文化故事。**

**文化故事要求：**
- 每个菜谱都必须包含 cultural_story 字段
- trigger_ingredient 应该是菜谱中最具文化代表性的食材
- title 应该简洁明了地概括故事主题
- content 应该包含详细的历史背景、文化意义或有趣的传说故事（至少100字）

**示例文化故事格式：**
```json
"cultural_story": {
  "trigger_ingredient": "胡萝卜",
  "title": "胡萝卜的丝绸之路传说",
  "content": "胡萝卜原产于中亚地区，通过古代丝绸之路传入中国。最初的胡萝卜是紫色的，经过长期的栽培和选育，才有了我们今天常见的橙色胡萝卜。在中国古代，胡萝卜被称为'胡菜'，寓意着来自西域的珍贵食材。"
}
```''';
    } else {
      return '''
    
你可以根据食材的特殊性和文化价值，选择性地为合适的菜谱提供文化背景故事。如果食材有深厚的历史文化背景，可以添加相关故事。''';
    }
  }
  
  /// 获取菜谱JSON Schema
  static Map<String, dynamic> _getRecipeSchema({bool forceCulturalStory = false}) {
    final baseRequired = ["id", "name", "ingredients", "instructions"];
    final requiredFields = forceCulturalStory 
        ? [...baseRequired, "cultural_story"]
        : baseRequired;
    
    return {
      "type": "object",
      "properties": {
        "recipes": {
          "type": "array",
          "description": "菜谱列表",
          "items": {
            "type": "object",
            "properties": {
              "id": {
                "type": "string",
                "description": "每个菜谱的唯一标识符"
              },
              "name": {
                "type": "string",
                "description": "菜谱的名称"
              },
              "description": {
                "type": "string",
                "description": "对菜谱的简短描述"
              },
              "ingredients": {
                "type": "array",
                "description": "所需食材列表",
                "items": {
                  "type": "object",
                  "properties": {
                    "name": {
                      "type": "string",
                      "description": "食材的名称"
                    },
                    "amount": {
                      "type": "number",
                      "description": "食材所需的数量"
                    },
                    "unit": {
                      "type": "string",
                      "description": "数量的单位（如：克、个、毫升）"
                    },
                    "isOptional": {
                      "type": "boolean",
                      "description": "该食材是否为可选",
                      "default": false
                    }
                  },
                  "required": ["name", "amount", "unit"],
                  "additionalProperties": false
                }
              },
              "instructions": {
                "type": "array",
                "description": "烹饪步骤列表",
                "items": {
                  "type": "string",
                  "description": "单个烹饪步骤的描述"
                }
              },
              "prepTime": {
                "type": "integer",
                "description": "准备时间的分钟数"
              },
              "cookTime": {
                "type": "integer",
                "description": "烹饪时间的分钟数"
              },
              "servings": {
                "type": "integer",
                "description": "菜谱的份量（供几人食用）"
              },
              "difficulty": {
                "type": "string",
                "description": "烹饪难度",
                "enum": ["简单", "中等", "困难"]
              },
              "cuisine": {
                "type": "string",
                "description": "所属菜系（如：川菜、粤菜）"
              },
              "tags": {
                "type": "array",
                "description": "用于分类和搜索的标签列表",
                "items": {
                  "type": "string"
                }
              },
              "nutrition": {
                "type": "object",
                "description": "营养成分信息",
                "properties": {
                  "calories": {"type": "number", "description": "总卡路里"},
                  "protein": {"type": "number", "description": "蛋白质克数"},
                  "carbs": {"type": "number", "description": "碳水化合物克数"},
                  "fat": {"type": "number", "description": "脂肪克数"},
                  "fiber": {"type": "number", "description": "纤维克数"},
                  "sugar": {"type": "number", "description": "糖分克数"},
                  "sodium": {"type": "number", "description": "钠毫克数"},
                  "summary": {"type": "string", "description": "营养成分的总体概述"},
                  "guidance": {"type": "string", "description": "相关的健康饮食建议"}
                },
                "additionalProperties": false
              },
              "cultural_story": {
                "type": "object",
                "description": "关于菜谱的文化背景或故事",
                "properties": {
                  "trigger_ingredient": {"type": "string", "description": "触发故事的食材"},
                  "title": {"type": "string", "description": "故事标题"},
                  "content": {"type": "string", "description": "故事内容"}
                },
                "additionalProperties": false
              }
            },
            "required": requiredFields,
            "additionalProperties": false
          }
        }
      },
      "required": ["recipes"],
      "additionalProperties": false
    };
  }
}
