import 'package:dio/dio.dart';
import 'package:recipe_generator/data/services/network/network_error_handler.dart';
import 'package:recipe_generator/data/services/recipe_util/recipe_data_parser.dart';
import 'package:recipe_generator/data/services/recipe_util/recipe_prompt_builder.dart';
import 'package:recipe_generator/domain/entities/recipe.dart';

class RecipeApiService {
  final Dio _dio;
  RecipeApiService(this._dio);

  Future<List<Recipe>> generateRecipes(
    String ingredients,
    String apiKey, {
    bool forceCulturalStory = false,
    required String model,
    required String baseUrl,
  }) async {
    try {
      final requestData = _buildRequestBody(ingredients, forceCulturalStory, model);
      final requestOptions = _buildRequestOptions(apiKey);

      final response = await _dio.post(
        baseUrl,
        data: requestData,
        options: requestOptions,
      );

      if (response.statusCode != 200) {
        throw Exception('API请求失败，状态码: ${response.statusCode}');
      }

      final responseData = response.data;
      if (responseData == null || responseData['choices'] == null) {
        throw Exception('API响应格式错误：缺少choices字段');
      }

      // 提取AI返回的内容字符串
      final choices = responseData['choices'] as List;
      if (choices.isEmpty) {
        throw Exception('API响应格式错误：choices列表为空');
      }

      final firstChoice = choices[0] as Map<String, dynamic>;
      final message = firstChoice['message'] as Map<String, dynamic>;
      final content = message['content'] as String;

      final recipes = RecipeDataParser.parseRecipes(content);
      return recipes;
    } on DioException catch (dioException) {
      final error = NetworkErrorHandler.handleDioError(dioException);
      throw Exception(error.toString());
    } catch (e) {
      throw Exception('生成菜谱失败: ${e.toString()}');
    }
  }

  Map<String, dynamic> _buildRequestBody(
    String ingredients,
    bool forceCulturalStory,
    String model,
  ) {
    final systemContent = RecipePromptBuilder.buildSystemPrompt(
      forceCulturalStory: forceCulturalStory,
    );
    return {
      'model': model,
      'messages': [
        {
          'role': 'system',
          'content': systemContent,
        },
        {
          'role': 'user',
          'content': '我有这些食材：$ingredients，请为我推荐3个菜谱'
        }
      ],
      'temperature': 0.7,
      'max_tokens': 50000,
      'response_format': RecipePromptBuilder.getResponseFormat(forceCulturalStory: forceCulturalStory),
    };
  }

  Options _buildRequestOptions(String apiKey) {
    return Options(
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );
  }


}