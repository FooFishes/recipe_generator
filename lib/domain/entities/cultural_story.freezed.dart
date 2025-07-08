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
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  List<String>? get traditions => throw _privateConstructorUsedError;

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
  $Res call(
      {String title, String content, String origin, List<String>? traditions});
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
    Object? title = null,
    Object? content = null,
    Object? origin = null,
    Object? traditions = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      traditions: freezed == traditions
          ? _value.traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
  $Res call(
      {String title, String content, String origin, List<String>? traditions});
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
    Object? title = null,
    Object? content = null,
    Object? origin = null,
    Object? traditions = freezed,
  }) {
    return _then(_$CulturalStoryImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      traditions: freezed == traditions
          ? _value._traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CulturalStoryImpl implements _CulturalStory {
  const _$CulturalStoryImpl(
      {required this.title,
      required this.content,
      required this.origin,
      final List<String>? traditions})
      : _traditions = traditions;

  factory _$CulturalStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CulturalStoryImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final String origin;
  final List<String>? _traditions;
  @override
  List<String>? get traditions {
    final value = _traditions;
    if (value == null) return null;
    if (_traditions is EqualUnmodifiableListView) return _traditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CulturalStory(title: $title, content: $content, origin: $origin, traditions: $traditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CulturalStoryImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._traditions, _traditions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content, origin,
      const DeepCollectionEquality().hash(_traditions));

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
      {required final String title,
      required final String content,
      required final String origin,
      final List<String>? traditions}) = _$CulturalStoryImpl;

  factory _CulturalStory.fromJson(Map<String, dynamic> json) =
      _$CulturalStoryImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  String get origin;
  @override
  List<String>? get traditions;

  /// Create a copy of CulturalStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CulturalStoryImplCopyWith<_$CulturalStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
