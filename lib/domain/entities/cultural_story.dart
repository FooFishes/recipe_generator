import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultural_story.freezed.dart';
part 'cultural_story.g.dart';

@freezed
class CulturalStory with _$CulturalStory {
  const factory CulturalStory({
    required String title,
    required String content,
    required String origin,
    List<String>? traditions,
  }) = _CulturalStory;

  factory CulturalStory.fromJson(Map<String, dynamic> json) => _$CulturalStoryFromJson(json);
}