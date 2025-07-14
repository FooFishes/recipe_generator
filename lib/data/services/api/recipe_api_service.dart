import 'package:dio/dio.dart';
import 'package:recipe_generator/core/logging/app_logger.dart';
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
    AppLogger.logMethodEntry('RecipeApiService', 'generateRecipes', {
      'ingredients': ingredients,
      'forceCulturalStory': forceCulturalStory,
      'model': model,
      'baseUrl': baseUrl,
    });
    
    final stopwatch = Stopwatch()..start();
    
    try {
      final requestData = _buildRequestBody(ingredients, forceCulturalStory, model);
      final requestOptions = _buildRequestOptions(apiKey);

      AppLogger.logApiCall('POST', baseUrl, requestData);
      
      final response = await _dio.post(
        baseUrl,
        data: requestData,
        options: requestOptions,
      );

      AppLogger.logApiResponse('POST', baseUrl, response.statusCode ?? 0, 
          'Response size: ${response.data?.toString().length ?? 0} chars');

      if (response.statusCode != 200) {
        AppLogger.error('API请求失败，状态码: ${response.statusCode}');
        throw Exception('API请求失败，状态码: ${response.statusCode}');
      }

      final responseData = response.data;
      if (responseData == null || responseData['choices'] == null) {
        AppLogger.error('API响应格式错误：缺少choices字段', responseData);
        throw Exception('API响应格式错误：缺少choices字段');
      }

      // 提取AI返回的内容字符串
      final choices = responseData['choices'] as List;
      if (choices.isEmpty) {
        AppLogger.error('API响应格式错误：choices列表为空');
        throw Exception('API响应格式错误：choices列表为空');
      }

      final firstChoice = choices[0] as Map<String, dynamic>;
      final message = firstChoice['message'] as Map<String, dynamic>;
      final content = message['content'] as String;

      AppLogger.debug('开始解析菜谱数据，内容长度: ${content.length}');
      final recipes = RecipeDataParser.parseRecipes(content);
      
      stopwatch.stop();
      AppLogger.logPerformance('generateRecipes', stopwatch.elapsed, {
        'recipeCount': recipes.length,
        'ingredients': ingredients,
      });
      
      AppLogger.logMethodExit('RecipeApiService', 'generateRecipes', 
          '成功生成${recipes.length}个菜谱');
      
      return recipes;
    } on DioException catch (dioException) {
      stopwatch.stop();
      AppLogger.error('网络请求异常', dioException, StackTrace.current);
      final error = NetworkErrorHandler.handleDioError(dioException);
      throw Exception(error.toString());
    } catch (e, stackTrace) {
      stopwatch.stop();
      AppLogger.error('生成菜谱失败', e, stackTrace);
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