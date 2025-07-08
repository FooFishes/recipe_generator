import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.g.dart';
part 'ingredient.freezed.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    // 名称
    required String name,
    // 数量
    required String amount,
    // 单位
    required String unit,
    // 备注
    String? notes,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
}