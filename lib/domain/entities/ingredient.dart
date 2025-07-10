import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.g.dart';
part 'ingredient.freezed.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    // 名称
    required String name,
    // 数量
    required double amount,
    // 单位
    required String unit,
    // 是否可选
    @Default(false) bool isOptional,
  }) = _Ingredient;

  const Ingredient._();

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  /// 返回用户友好的食材显示格式
  @override
  String toString() {
    // 格式化数量，如果是整数则不显示小数点
    final formattedAmount = amount == amount.toInt()
        ? amount.toInt().toString()
        : amount.toString();

    return '$name $formattedAmount$unit';
  }
}