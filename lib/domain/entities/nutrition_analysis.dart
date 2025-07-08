import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_analysis.freezed.dart';
part 'nutrition_analysis.g.dart';

@freezed
class NutritionAnalysis with _$NutritionAnalysis {
  const factory NutritionAnalysis({
        required double calories,
        required double protein,
        required double carbs,
        required double fat,
        required double fiber,
        required double sugar,
        required double sodium,
        required String summary,
        required String guidance,
    }) = _NutritionAnalysis;
    
    factory NutritionAnalysis.fromJson(Map<String, dynamic> json) => _$NutritionAnalysisFromJson(json);

}