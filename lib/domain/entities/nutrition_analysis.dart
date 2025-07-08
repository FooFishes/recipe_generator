import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_analysis.freezed.dart';
part 'nutrition_analysis.g.dart';

@freezed
class NutritionAnalysis with _$NutritionAnalysis {
  const factory NutritionAnalysis({
        // 热量
        required double calories,
        // 蛋白质
        required double protein,
        // 碳水化合物
        required double carbs,
        // 脂肪
        required double fat,
        // 纤维
        required double fiber,
        // 糖
        required double sugar,
        // 钠
        required double sodium,
        // 总结
        required String summary,
        // 指南
        required String guidance,
    }) = _NutritionAnalysis;
    
    factory NutritionAnalysis.fromJson(Map<String, dynamic> json) => _$NutritionAnalysisFromJson(json);

}