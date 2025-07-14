// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeHistoryImpl _$$RecipeHistoryImplFromJson(Map<String, dynamic> json) =>
    _$RecipeHistoryImpl(
      id: json['id'] as String,
      ingredients: json['ingredients'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      recipeIds:
          (json['recipeIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RecipeHistoryImplToJson(_$RecipeHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredients': instance.ingredients,
      'createdAt': instance.createdAt.toIso8601String(),
      'recipeIds': instance.recipeIds,
    };
