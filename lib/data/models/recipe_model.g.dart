// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecipeModelCollection on Isar {
  IsarCollection<RecipeModel> get recipeModels => this.collection();
}

const RecipeModelSchema = CollectionSchema(
  name: r'RecipeModel',
  id: 1871555323955702891,
  properties: {
    r'cookTime': PropertySchema(
      id: 0,
      name: r'cookTime',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'cuisine': PropertySchema(
      id: 2,
      name: r'cuisine',
      type: IsarType.string,
    ),
    r'culturalStoryJson': PropertySchema(
      id: 3,
      name: r'culturalStoryJson',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 4,
      name: r'description',
      type: IsarType.string,
    ),
    r'difficulty': PropertySchema(
      id: 5,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'ingredientsJson': PropertySchema(
      id: 6,
      name: r'ingredientsJson',
      type: IsarType.string,
    ),
    r'instructionsJson': PropertySchema(
      id: 7,
      name: r'instructionsJson',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 8,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'nutritionJson': PropertySchema(
      id: 10,
      name: r'nutritionJson',
      type: IsarType.string,
    ),
    r'prepTime': PropertySchema(
      id: 11,
      name: r'prepTime',
      type: IsarType.long,
    ),
    r'recipeId': PropertySchema(
      id: 12,
      name: r'recipeId',
      type: IsarType.string,
    ),
    r'servings': PropertySchema(
      id: 13,
      name: r'servings',
      type: IsarType.long,
    ),
    r'tagsJson': PropertySchema(
      id: 14,
      name: r'tagsJson',
      type: IsarType.string,
    )
  },
  estimateSize: _recipeModelEstimateSize,
  serialize: _recipeModelSerialize,
  deserialize: _recipeModelDeserialize,
  deserializeProp: _recipeModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'recipeId': IndexSchema(
      id: 7223263824597846537,
      name: r'recipeId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'recipeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'difficulty': IndexSchema(
      id: 3042583923453520767,
      name: r'difficulty',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'difficulty',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'cuisine': IndexSchema(
      id: -3173894729494932683,
      name: r'cuisine',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'cuisine',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isFavorite': IndexSchema(
      id: 5742774614603939776,
      name: r'isFavorite',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isFavorite',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _recipeModelGetId,
  getLinks: _recipeModelGetLinks,
  attach: _recipeModelAttach,
  version: '3.1.0+1',
);

int _recipeModelEstimateSize(
  RecipeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cuisine.length * 3;
  {
    final value = object.culturalStoryJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.difficulty.length * 3;
  bytesCount += 3 + object.ingredientsJson.length * 3;
  bytesCount += 3 + object.instructionsJson.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nutritionJson.length * 3;
  bytesCount += 3 + object.recipeId.length * 3;
  bytesCount += 3 + object.tagsJson.length * 3;
  return bytesCount;
}

void _recipeModelSerialize(
  RecipeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cookTime);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.cuisine);
  writer.writeString(offsets[3], object.culturalStoryJson);
  writer.writeString(offsets[4], object.description);
  writer.writeString(offsets[5], object.difficulty);
  writer.writeString(offsets[6], object.ingredientsJson);
  writer.writeString(offsets[7], object.instructionsJson);
  writer.writeBool(offsets[8], object.isFavorite);
  writer.writeString(offsets[9], object.name);
  writer.writeString(offsets[10], object.nutritionJson);
  writer.writeLong(offsets[11], object.prepTime);
  writer.writeString(offsets[12], object.recipeId);
  writer.writeLong(offsets[13], object.servings);
  writer.writeString(offsets[14], object.tagsJson);
}

RecipeModel _recipeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecipeModel();
  object.cookTime = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.cuisine = reader.readString(offsets[2]);
  object.culturalStoryJson = reader.readStringOrNull(offsets[3]);
  object.description = reader.readString(offsets[4]);
  object.difficulty = reader.readString(offsets[5]);
  object.id = id;
  object.ingredientsJson = reader.readString(offsets[6]);
  object.instructionsJson = reader.readString(offsets[7]);
  object.isFavorite = reader.readBool(offsets[8]);
  object.name = reader.readString(offsets[9]);
  object.nutritionJson = reader.readString(offsets[10]);
  object.prepTime = reader.readLong(offsets[11]);
  object.recipeId = reader.readString(offsets[12]);
  object.servings = reader.readLong(offsets[13]);
  object.tagsJson = reader.readString(offsets[14]);
  return object;
}

P _recipeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recipeModelGetId(RecipeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recipeModelGetLinks(RecipeModel object) {
  return [];
}

void _recipeModelAttach(
    IsarCollection<dynamic> col, Id id, RecipeModel object) {
  object.id = id;
}

extension RecipeModelByIndex on IsarCollection<RecipeModel> {
  Future<RecipeModel?> getByRecipeId(String recipeId) {
    return getByIndex(r'recipeId', [recipeId]);
  }

  RecipeModel? getByRecipeIdSync(String recipeId) {
    return getByIndexSync(r'recipeId', [recipeId]);
  }

  Future<bool> deleteByRecipeId(String recipeId) {
    return deleteByIndex(r'recipeId', [recipeId]);
  }

  bool deleteByRecipeIdSync(String recipeId) {
    return deleteByIndexSync(r'recipeId', [recipeId]);
  }

  Future<List<RecipeModel?>> getAllByRecipeId(List<String> recipeIdValues) {
    final values = recipeIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'recipeId', values);
  }

  List<RecipeModel?> getAllByRecipeIdSync(List<String> recipeIdValues) {
    final values = recipeIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'recipeId', values);
  }

  Future<int> deleteAllByRecipeId(List<String> recipeIdValues) {
    final values = recipeIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'recipeId', values);
  }

  int deleteAllByRecipeIdSync(List<String> recipeIdValues) {
    final values = recipeIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'recipeId', values);
  }

  Future<Id> putByRecipeId(RecipeModel object) {
    return putByIndex(r'recipeId', object);
  }

  Id putByRecipeIdSync(RecipeModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'recipeId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRecipeId(List<RecipeModel> objects) {
    return putAllByIndex(r'recipeId', objects);
  }

  List<Id> putAllByRecipeIdSync(List<RecipeModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'recipeId', objects, saveLinks: saveLinks);
  }
}

extension RecipeModelQueryWhereSort
    on QueryBuilder<RecipeModel, RecipeModel, QWhere> {
  QueryBuilder<RecipeModel, RecipeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhere> anyIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFavorite'),
      );
    });
  }
}

extension RecipeModelQueryWhere
    on QueryBuilder<RecipeModel, RecipeModel, QWhereClause> {
  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> recipeIdEqualTo(
      String recipeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recipeId',
        value: [recipeId],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> recipeIdNotEqualTo(
      String recipeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recipeId',
              lower: [],
              upper: [recipeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recipeId',
              lower: [recipeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recipeId',
              lower: [recipeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recipeId',
              lower: [],
              upper: [recipeId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> difficultyEqualTo(
      String difficulty) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'difficulty',
        value: [difficulty],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause>
      difficultyNotEqualTo(String difficulty) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'difficulty',
              lower: [],
              upper: [difficulty],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'difficulty',
              lower: [difficulty],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'difficulty',
              lower: [difficulty],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'difficulty',
              lower: [],
              upper: [difficulty],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> cuisineEqualTo(
      String cuisine) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cuisine',
        value: [cuisine],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> cuisineNotEqualTo(
      String cuisine) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cuisine',
              lower: [],
              upper: [cuisine],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cuisine',
              lower: [cuisine],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cuisine',
              lower: [cuisine],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cuisine',
              lower: [],
              upper: [cuisine],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause> isFavoriteEqualTo(
      bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [isFavorite],
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterWhereClause>
      isFavoriteNotEqualTo(bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RecipeModelQueryFilter
    on QueryBuilder<RecipeModel, RecipeModel, QFilterCondition> {
  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cookTimeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cookTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cookTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cookTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cookTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cookTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cookTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cookTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cuisineGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuisine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cuisineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuisine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> cuisineMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuisine',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cuisineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisine',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      cuisineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuisine',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'culturalStoryJson',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'culturalStoryJson',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'culturalStoryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'culturalStoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'culturalStoryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'culturalStoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      culturalStoryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'culturalStoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficulty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'difficulty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingredientsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredientsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredientsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredientsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      ingredientsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredientsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instructionsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instructionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instructionsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructionsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      instructionsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instructionsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nutritionJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nutritionJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nutritionJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutritionJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      nutritionJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nutritionJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> prepTimeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      prepTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      prepTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> prepTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prepTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> recipeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> recipeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recipeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> recipeIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recipeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      recipeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recipeId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> servingsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      servingsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      servingsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> servingsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> tagsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> tagsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition> tagsJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterFilterCondition>
      tagsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagsJson',
        value: '',
      ));
    });
  }
}

extension RecipeModelQueryObject
    on QueryBuilder<RecipeModel, RecipeModel, QFilterCondition> {}

extension RecipeModelQueryLinks
    on QueryBuilder<RecipeModel, RecipeModel, QFilterCondition> {}

extension RecipeModelQuerySortBy
    on QueryBuilder<RecipeModel, RecipeModel, QSortBy> {
  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCookTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookTime', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCookTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookTime', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCuisine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisine', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByCuisineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisine', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByCulturalStoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'culturalStoryJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByCulturalStoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'culturalStoryJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByIngredientsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredientsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByIngredientsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredientsJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByInstructionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByInstructionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByNutritionJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutritionJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      sortByNutritionJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutritionJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByPrepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepTime', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByPrepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepTime', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByServingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByTagsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> sortByTagsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.desc);
    });
  }
}

extension RecipeModelQuerySortThenBy
    on QueryBuilder<RecipeModel, RecipeModel, QSortThenBy> {
  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCookTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookTime', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCookTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookTime', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCuisine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisine', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByCuisineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisine', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByCulturalStoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'culturalStoryJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByCulturalStoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'culturalStoryJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByIngredientsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredientsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByIngredientsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredientsJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByInstructionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByInstructionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByNutritionJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutritionJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy>
      thenByNutritionJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutritionJson', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByPrepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepTime', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByPrepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepTime', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByServingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.desc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByTagsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.asc);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QAfterSortBy> thenByTagsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.desc);
    });
  }
}

extension RecipeModelQueryWhereDistinct
    on QueryBuilder<RecipeModel, RecipeModel, QDistinct> {
  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByCookTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cookTime');
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByCuisine(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuisine', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByCulturalStoryJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'culturalStoryJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByDifficulty(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByIngredientsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingredientsJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByInstructionsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructionsJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByNutritionJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nutritionJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByPrepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prepTime');
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByRecipeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recipeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servings');
    });
  }

  QueryBuilder<RecipeModel, RecipeModel, QDistinct> distinctByTagsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagsJson', caseSensitive: caseSensitive);
    });
  }
}

extension RecipeModelQueryProperty
    on QueryBuilder<RecipeModel, RecipeModel, QQueryProperty> {
  QueryBuilder<RecipeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecipeModel, int, QQueryOperations> cookTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cookTime');
    });
  }

  QueryBuilder<RecipeModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> cuisineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuisine');
    });
  }

  QueryBuilder<RecipeModel, String?, QQueryOperations>
      culturalStoryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'culturalStoryJson');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations>
      ingredientsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingredientsJson');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations>
      instructionsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructionsJson');
    });
  }

  QueryBuilder<RecipeModel, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> nutritionJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutritionJson');
    });
  }

  QueryBuilder<RecipeModel, int, QQueryOperations> prepTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prepTime');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> recipeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipeId');
    });
  }

  QueryBuilder<RecipeModel, int, QQueryOperations> servingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servings');
    });
  }

  QueryBuilder<RecipeModel, String, QQueryOperations> tagsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagsJson');
    });
  }
}
