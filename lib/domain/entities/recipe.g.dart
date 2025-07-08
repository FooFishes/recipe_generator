// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      prepTime: (json['prepTime'] as num).toInt(),
      cookTime: (json['cookTime'] as num).toInt(),
      serving: (json['serving'] as num).toInt(),
      difficulty: json['difficulty'] as String,
      cuisine: json['cuisine'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      nutrition:
          NutritionAnalysis.fromJson(json['nutrition'] as Map<String, dynamic>),
      culturalStory: json['culturalStory'] == null
          ? null
          : CulturalStory.fromJson(
              json['culturalStory'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'prepTime': instance.prepTime,
      'cookTime': instance.cookTime,
      'serving': instance.serving,
      'difficulty': instance.difficulty,
      'cuisine': instance.cuisine,
      'tags': instance.tags,
      'nutrition': instance.nutrition,
      'culturalStory': instance.culturalStory,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isFavorite': instance.isFavorite,
    };
