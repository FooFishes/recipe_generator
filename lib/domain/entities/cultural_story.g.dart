// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CulturalStoryImpl _$$CulturalStoryImplFromJson(Map<String, dynamic> json) =>
    _$CulturalStoryImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      origin: json['origin'] as String,
      traditions: (json['traditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CulturalStoryImplToJson(_$CulturalStoryImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'origin': instance.origin,
      'traditions': instance.traditions,
    };
