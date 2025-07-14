// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeHistoryModelAdapter extends TypeAdapter<RecipeHistoryModel> {
  @override
  final int typeId = 1;

  @override
  RecipeHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeHistoryModel()
      ..id = fields[0] as String
      ..ingredients = fields[1] as String
      ..createdAt = fields[2] as DateTime
      ..recipeIdsJson = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, RecipeHistoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ingredients)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.recipeIdsJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
