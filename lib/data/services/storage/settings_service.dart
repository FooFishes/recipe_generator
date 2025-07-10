import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _culturalStoryKey = '_cultural_story';
  static const String _model = '_model_name';
  static const String _baseUrl = '_base_url';


  
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

  Future<void> setModel(String model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_model, model);
    } catch (e) {
      throw Exception('Failed to set model name setting: $e');
    }
  }

  Future<String?> getModel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_model); // 返回null如果未设置
    } catch (e) {
      return null; // 出错时返回null
    }
  }

  Future<bool> hasModel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? model = prefs.getString(_model);
      return model != null && model.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to determine has model settings: $e');
    }
  }

  Future<void> deleteModel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(_model);
    } catch (e) {
      throw Exception('Failed to delete model settings: $e');
    }
  }

  // BaseUrl 相关方法
  Future<void> setBaseUrl(String baseUrl) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_baseUrl, baseUrl);
    } catch (e) {
      throw Exception('Failed to set base URL setting: $e');
    }
  }

  Future<String?> getBaseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_baseUrl); // 返回null如果未设置
    } catch (e) {
      return null; // 出错时返回null
    }
  }

  Future<bool> hasBaseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? baseUrl = prefs.getString(_baseUrl);
      return baseUrl != null && baseUrl.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteBaseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(_baseUrl);
    } catch (e) {
      throw Exception('Failed to delete base URL settings: $e');
    }
  }
}