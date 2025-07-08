// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NutritionAnalysisImpl _$$NutritionAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$NutritionAnalysisImpl(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      sodium: (json['sodium'] as num).toDouble(),
      summary: json['summary'] as String,
      guidance: json['guidance'] as String,
    );

Map<String, dynamic> _$$NutritionAnalysisImplToJson(
        _$NutritionAnalysisImpl instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sugar': instance.sugar,
      'sodium': instance.sodium,
      'summary': instance.summary,
      'guidance': instance.guidance,
    };
