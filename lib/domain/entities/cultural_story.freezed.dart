// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cultural_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CulturalStory _$CulturalStoryFromJson(Map<String, dynamic> json) {
  return _CulturalStory.fromJson(json);
}

/// @nodoc
mixin _$CulturalStory {
  String get triggerIngredient => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this CulturalStory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CulturalStoryCopyWith<CulturalStory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CulturalStoryCopyWith<$Res> {
  factory $CulturalStoryCopyWith(
          CulturalStory value, $Res Function(CulturalStory) then) =
      _$CulturalStoryCopyWithImpl<$Res, CulturalStory>;
  @useResult
  $Res call({String triggerIngredient, String title, String content});
}

/// @nodoc
class _$CulturalStoryCopyWithImpl<$Res, $Val extends CulturalStory>
    implements $CulturalStoryCopyWith<$Res> {
  _$CulturalStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? triggerIngredient = null,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      triggerIngredient: null == triggerIngredient
          ? _value.triggerIngredient
          : triggerIngredient // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CulturalStoryImplCopyWith<$Res>
    implements $CulturalStoryCopyWith<$Res> {
  factory _$$CulturalStoryImplCopyWith(
          _$CulturalStoryImpl value, $Res Function(_$CulturalStoryImpl) then) =
      __$$CulturalStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String triggerIngredient, String title, String content});
}

/// @nodoc
class __$$CulturalStoryImplCopyWithImpl<$Res>
    extends _$CulturalStoryCopyWithImpl<$Res, _$CulturalStoryImpl>
    implements _$$CulturalStoryImplCopyWith<$Res> {
  __$$CulturalStoryImplCopyWithImpl(
      _$CulturalStoryImpl _value, $Res Function(_$CulturalStoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? triggerIngredient = null,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$CulturalStoryImpl(
      triggerIngredient: null == triggerIngredient
          ? _value.triggerIngredient
          : triggerIngredient // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CulturalStoryImpl implements _CulturalStory {
  const _$CulturalStoryImpl(
      {required this.triggerIngredient,
      required this.title,
      required this.content});

  factory _$CulturalStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CulturalStoryImplFromJson(json);

  @override
  final String triggerIngredient;
  @override
  final String title;
  @override
  final String content;

  @override
  String toString() {
    return 'CulturalStory(triggerIngredient: $triggerIngredient, title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CulturalStoryImpl &&
            (identical(other.triggerIngredient, triggerIngredient) ||
                other.triggerIngredient == triggerIngredient) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, triggerIngredient, title, content);

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CulturalStoryImplCopyWith<_$CulturalStoryImpl> get copyWith =>
      __$$CulturalStoryImplCopyWithImpl<_$CulturalStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CulturalStoryImplToJson(
      this,
    );
  }
}

abstract class _CulturalStory implements CulturalStory {
  const factory _CulturalStory(
      {required final String triggerIngredient,
      required final String title,
      required final String content}) = _$CulturalStoryImpl;

  factory _CulturalStory.fromJson(Map<String, dynamic> json) =
      _$CulturalStoryImpl.fromJson;

  @override
  String get triggerIngredient;
  @override
  String get title;
  @override
  String get content;

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CulturalStoryImplCopyWith<_$CulturalStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
