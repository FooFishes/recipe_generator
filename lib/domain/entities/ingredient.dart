import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.g.dart';
part 'ingredient.freezed.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    required String amount,
    required String unit,
    String? notes,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
}