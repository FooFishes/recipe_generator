import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _culturalStoryKey = '_cultural_story';
  
  Future<bool> getCulturalStoryEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_culturalStoryKey) ?? false; // 默认值为 false
    } catch (e) {
      return false; // 默认返回 false
    }
  }

  Future<void> setCulturalStoryEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_culturalStoryKey, enabled);
    } catch (e) {
      throw Exception('Failed to set cultural story setting: $e');
    }
  }
}