// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel()
      ..id = fields[0] as int?
      ..recipeId = fields[1] as String
      ..name = fields[2] as String
      ..description = fields[3] as String
      ..ingredientsJson = fields[4] as String
      ..instructionsJson = fields[5] as String
      ..prepTime = fields[6] as int
      ..cookTime = fields[7] as int
      ..servings = fields[8] as int
      ..difficulty = fields[9] as String
      ..cuisine = fields[10] as String
      ..tagsJson = fields[11] as String
      ..nutritionJson = fields[12] as String
      ..createdAt = fields[13] as DateTime
      ..isFavorite = fields[14] as bool
      ..culturalStoryJson = fields[15] as String?;
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recipeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.ingredientsJson)
      ..writeByte(5)
      ..write(obj.instructionsJson)
      ..writeByte(6)
      ..write(obj.prepTime)
      ..writeByte(7)
      ..write(obj.cookTime)
      ..writeByte(8)
      ..write(obj.servings)
      ..writeByte(9)
      ..write(obj.difficulty)
      ..writeByte(10)
      ..write(obj.cuisine)
      ..writeByte(11)
      ..write(obj.tagsJson)
      ..writeByte(12)
      ..write(obj.nutritionJson)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.isFavorite)
      ..writeByte(15)
      ..write(obj.culturalStoryJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
