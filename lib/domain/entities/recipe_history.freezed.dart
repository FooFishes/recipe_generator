// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeHistory _$RecipeHistoryFromJson(Map<String, dynamic> json) {
  return _RecipeHistory.fromJson(json);
}

/// @nodoc
mixin _$RecipeHistory {
  String get id => throw _privateConstructorUsedError;
  String get ingredients => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get recipeIds => throw _privateConstructorUsedError;

  /// Serializes this RecipeHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeHistoryCopyWith<RecipeHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeHistoryCopyWith<$Res> {
  factory $RecipeHistoryCopyWith(
          RecipeHistory value, $Res Function(RecipeHistory) then) =
      _$RecipeHistoryCopyWithImpl<$Res, RecipeHistory>;
  @useResult
  $Res call(
      {String id,
      String ingredients,
      DateTime createdAt,
      List<String> recipeIds});
}

/// @nodoc
class _$RecipeHistoryCopyWithImpl<$Res, $Val extends RecipeHistory>
    implements $RecipeHistoryCopyWith<$Res> {
  _$RecipeHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ingredients = null,
    Object? createdAt = null,
    Object? recipeIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeIds: null == recipeIds
          ? _value.recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeHistoryImplCopyWith<$Res>
    implements $RecipeHistoryCopyWith<$Res> {
  factory _$$RecipeHistoryImplCopyWith(
          _$RecipeHistoryImpl value, $Res Function(_$RecipeHistoryImpl) then) =
      __$$RecipeHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ingredients,
      DateTime createdAt,
      List<String> recipeIds});
}

/// @nodoc
class __$$RecipeHistoryImplCopyWithImpl<$Res>
    extends _$RecipeHistoryCopyWithImpl<$Res, _$RecipeHistoryImpl>
    implements _$$RecipeHistoryImplCopyWith<$Res> {
  __$$RecipeHistoryImplCopyWithImpl(
      _$RecipeHistoryImpl _value, $Res Function(_$RecipeHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ingredients = null,
    Object? createdAt = null,
    Object? recipeIds = null,
  }) {
    return _then(_$RecipeHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recipeIds: null == recipeIds
          ? _value._recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeHistoryImpl implements _RecipeHistory {
  const _$RecipeHistoryImpl(
      {required this.id,
      required this.ingredients,
      required this.createdAt,
      required final List<String> recipeIds})
      : _recipeIds = recipeIds;

  factory _$RecipeHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String ingredients;
  @override
  final DateTime createdAt;
  final List<String> _recipeIds;
  @override
  List<String> get recipeIds {
    if (_recipeIds is EqualUnmodifiableListView) return _recipeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeIds);
  }

  @override
  String toString() {
    return 'RecipeHistory(id: $id, ingredients: $ingredients, createdAt: $createdAt, recipeIds: $recipeIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ingredients, ingredients) ||
                other.ingredients == ingredients) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._recipeIds, _recipeIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, ingredients, createdAt,
      const DeepCollectionEquality().hash(_recipeIds));

  /// Create a copy of RecipeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeHistoryImplCopyWith<_$RecipeHistoryImpl> get copyWith =>
      __$$RecipeHistoryImplCopyWithImpl<_$RecipeHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeHistoryImplToJson(
      this,
    );
  }
}

abstract class _RecipeHistory implements RecipeHistory {
  const factory _RecipeHistory(
      {required final String id,
      required final String ingredients,
      required final DateTime createdAt,
      required final List<String> recipeIds}) = _$RecipeHistoryImpl;

  factory _RecipeHistory.fromJson(Map<String, dynamic> json) =
      _$RecipeHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get ingredients;
  @override
  DateTime get createdAt;
  @override
  List<String> get recipeIds;

  /// Create a copy of RecipeHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeHistoryImplCopyWith<_$RecipeHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
