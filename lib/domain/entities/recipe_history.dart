import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_history.g.dart';
part 'recipe_history.freezed.dart';

@freezed
class RecipeHistory with _$RecipeHistory {
  const factory RecipeHistory({
    required String id,
    required String ingredients,
    required DateTime createdAt,
    required List<String> recipeIds,
  }) = _RecipeHistory;

  factory RecipeHistory.fromJson(Map<String, dynamic> json) => _$RecipeHistoryFromJson(json);
}