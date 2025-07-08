import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultural_story.freezed.dart';
part 'cultural_story.g.dart';

@freezed
class CulturalStory with _$CulturalStory {
  const factory CulturalStory({
    // 标题
    required String title,
    // 内容
    required String content,
    // 起源
    required String origin,
    // 传统
    List<String>? traditions,
  }) = _CulturalStory;

  factory CulturalStory.fromJson(Map<String, dynamic> json) => _$CulturalStoryFromJson(json);
}