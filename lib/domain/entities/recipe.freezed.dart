// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
// 食谱ID(JSON中的唯一标识符)
  String get id => throw _privateConstructorUsedError; // 名称
  String get name => throw _privateConstructorUsedError; // 描述
  String get description => throw _privateConstructorUsedError; // 食材列表
  List<Ingredient> get ingredients =>
      throw _privateConstructorUsedError; // 烹饪步骤
  List<String> get instructions => throw _privateConstructorUsedError; // 准备时间
  int get prepTime => throw _privateConstructorUsedError; // 烹饪时间
  int get cookTime => throw _privateConstructorUsedError; // 几人份
  int get serving => throw _privateConstructorUsedError; // 烹饪难度
  String get difficulty => throw _privateConstructorUsedError; // 菜系
  String get cuisine => throw _privateConstructorUsedError; // 标签
  List<String> get tags => throw _privateConstructorUsedError; // 营养信息
  NutritionAnalysis get nutrition => throw _privateConstructorUsedError; // 文化故事
  CulturalStory? get culturalStory =>
      throw _privateConstructorUsedError; // 创建时间
  DateTime? get createdAt => throw _privateConstructorUsedError; // 是否收藏
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<Ingredient> ingredients,
      List<String> instructions,
      int prepTime,
      int cookTime,
      int serving,
      String difficulty,
      String cuisine,
      List<String> tags,
      NutritionAnalysis nutrition,
      CulturalStory? culturalStory,
      DateTime? createdAt,
      bool isFavorite});

  $NutritionAnalysisCopyWith<$Res> get nutrition;
  $CulturalStoryCopyWith<$Res>? get culturalStory;
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? prepTime = null,
    Object? cookTime = null,
    Object? serving = null,
    Object? difficulty = null,
    Object? cuisine = null,
    Object? tags = null,
    Object? nutrition = null,
    Object? culturalStory = freezed,
    Object? createdAt = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prepTime: null == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as int,
      cookTime: null == cookTime
          ? _value.cookTime
          : cookTime // ignore: cast_nullable_to_non_nullable
              as int,
      serving: null == serving
          ? _value.serving
          : serving // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      cuisine: null == cuisine
          ? _value.cuisine
          : cuisine // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionAnalysis,
      culturalStory: freezed == culturalStory
          ? _value.culturalStory
          : culturalStory // ignore: cast_nullable_to_non_nullable
              as CulturalStory?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionAnalysisCopyWith<$Res> get nutrition {
    return $NutritionAnalysisCopyWith<$Res>(_value.nutrition, (value) {
      return _then(_value.copyWith(nutrition: value) as $Val);
    });
  }

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CulturalStoryCopyWith<$Res>? get culturalStory {
    if (_value.culturalStory == null) {
      return null;
    }

    return $CulturalStoryCopyWith<$Res>(_value.culturalStory!, (value) {
      return _then(_value.copyWith(culturalStory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeImplCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$RecipeImplCopyWith(
          _$RecipeImpl value, $Res Function(_$RecipeImpl) then) =
      __$$RecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<Ingredient> ingredients,
      List<String> instructions,
      int prepTime,
      int cookTime,
      int serving,
      String difficulty,
      String cuisine,
      List<String> tags,
      NutritionAnalysis nutrition,
      CulturalStory? culturalStory,
      DateTime? createdAt,
      bool isFavorite});

  @override
  $NutritionAnalysisCopyWith<$Res> get nutrition;
  @override
  $CulturalStoryCopyWith<$Res>? get culturalStory;
}

/// @nodoc
class __$$RecipeImplCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$RecipeImpl>
    implements _$$RecipeImplCopyWith<$Res> {
  __$$RecipeImplCopyWithImpl(
      _$RecipeImpl _value, $Res Function(_$RecipeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? prepTime = null,
    Object? cookTime = null,
    Object? serving = null,
    Object? difficulty = null,
    Object? cuisine = null,
    Object? tags = null,
    Object? nutrition = null,
    Object? culturalStory = freezed,
    Object? createdAt = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_$RecipeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prepTime: null == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as int,
      cookTime: null == cookTime
          ? _value.cookTime
          : cookTime // ignore: cast_nullable_to_non_nullable
              as int,
      serving: null == serving
          ? _value.serving
          : serving // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      cuisine: null == cuisine
          ? _value.cuisine
          : cuisine // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutrition: null == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as NutritionAnalysis,
      culturalStory: freezed == culturalStory
          ? _value.culturalStory
          : culturalStory // ignore: cast_nullable_to_non_nullable
              as CulturalStory?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeImpl implements _Recipe {
  const _$RecipeImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<Ingredient> ingredients,
      required final List<String> instructions,
      required this.prepTime,
      required this.cookTime,
      required this.serving,
      required this.difficulty,
      required this.cuisine,
      required final List<String> tags,
      required this.nutrition,
      this.culturalStory,
      this.createdAt,
      this.isFavorite = false})
      : _ingredients = ingredients,
        _instructions = instructions,
        _tags = tags;

  factory _$RecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImplFromJson(json);

// 食谱ID(JSON中的唯一标识符)
  @override
  final String id;
// 名称
  @override
  final String name;
// 描述
  @override
  final String description;
// 食材列表
  final List<Ingredient> _ingredients;
// 食材列表
  @override
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

// 烹饪步骤
  final List<String> _instructions;
// 烹饪步骤
  @override
  List<String> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

// 准备时间
  @override
  final int prepTime;
// 烹饪时间
  @override
  final int cookTime;
// 几人份
  @override
  final int serving;
// 烹饪难度
  @override
  final String difficulty;
// 菜系
  @override
  final String cuisine;
// 标签
  final List<String> _tags;
// 标签
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

// 营养信息
  @override
  final NutritionAnalysis nutrition;
// 文化故事
  @override
  final CulturalStory? culturalStory;
// 创建时间
  @override
  final DateTime? createdAt;
// 是否收藏
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, description: $description, ingredients: $ingredients, instructions: $instructions, prepTime: $prepTime, cookTime: $cookTime, serving: $serving, difficulty: $difficulty, cuisine: $cuisine, tags: $tags, nutrition: $nutrition, culturalStory: $culturalStory, createdAt: $createdAt, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.prepTime, prepTime) ||
                other.prepTime == prepTime) &&
            (identical(other.cookTime, cookTime) ||
                other.cookTime == cookTime) &&
            (identical(other.serving, serving) || other.serving == serving) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.cuisine, cuisine) || other.cuisine == cuisine) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition) &&
            (identical(other.culturalStory, culturalStory) ||
                other.culturalStory == culturalStory) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_instructions),
      prepTime,
      cookTime,
      serving,
      difficulty,
      cuisine,
      const DeepCollectionEquality().hash(_tags),
      nutrition,
      culturalStory,
      createdAt,
      isFavorite);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      __$$RecipeImplCopyWithImpl<_$RecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImplToJson(
      this,
    );
  }
}

abstract class _Recipe implements Recipe {
  const factory _Recipe(
      {required final String id,
      required final String name,
      required final String description,
      required final List<Ingredient> ingredients,
      required final List<String> instructions,
      required final int prepTime,
      required final int cookTime,
      required final int serving,
      required final String difficulty,
      required final String cuisine,
      required final List<String> tags,
      required final NutritionAnalysis nutrition,
      final CulturalStory? culturalStory,
      final DateTime? createdAt,
      final bool isFavorite}) = _$RecipeImpl;

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$RecipeImpl.fromJson;

// 食谱ID(JSON中的唯一标识符)
  @override
  String get id; // 名称
  @override
  String get name; // 描述
  @override
  String get description; // 食材列表
  @override
  List<Ingredient> get ingredients; // 烹饪步骤
  @override
  List<String> get instructions; // 准备时间
  @override
  int get prepTime; // 烹饪时间
  @override
  int get cookTime; // 几人份
  @override
  int get serving; // 烹饪难度
  @override
  String get difficulty; // 菜系
  @override
  String get cuisine; // 标签
  @override
  List<String> get tags; // 营养信息
  @override
  NutritionAnalysis get nutrition; // 文化故事
  @override
  CulturalStory? get culturalStory; // 创建时间
  @override
  DateTime? get createdAt; // 是否收藏
  @override
  bool get isFavorite;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
