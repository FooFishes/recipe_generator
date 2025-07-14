import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyService {
  static const String _apiKeyKey = 'api_key';
  static const String _saltKey = 'api_key_salt';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// 生成随机盐值（用于Web平台加密）
  String _generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Encode(saltBytes);
  }

  /// 简单的XOR加密（用于Web平台）
  String _encryptForWeb(String data, String salt) {
    final saltBytes = base64Decode(salt);
    final dataBytes = utf8.encode(data);
    final encryptedBytes = <int>[];
    
    for (int i = 0; i < dataBytes.length; i++) {
      encryptedBytes.add(dataBytes[i] ^ saltBytes[i % saltBytes.length]);
    }
    
    return base64Encode(encryptedBytes);
  }

  /// 简单的XOR解密（用于Web平台）
  String _decryptForWeb(String encryptedData, String salt) {
    final saltBytes = base64Decode(salt);
    final encryptedBytes = base64Decode(encryptedData);
    final decryptedBytes = <int>[];
    
    for (int i = 0; i < encryptedBytes.length; i++) {
      decryptedBytes.add(encryptedBytes[i] ^ saltBytes[i % saltBytes.length]);
    }
    
    return utf8.decode(decryptedBytes);
  }

  Future<String?> getApiKey() async {
    try {
      if (kIsWeb) {
        // Web平台使用SharedPreferences + 简单加密
        final prefs = await SharedPreferences.getInstance();
        final encryptedKey = prefs.getString(_apiKeyKey);
        final salt = prefs.getString(_saltKey);
        
        if (encryptedKey != null && salt != null) {
          return _decryptForWeb(encryptedKey, salt);
        }
        return null;
      } else {
        // 移动端使用flutter_secure_storage
        return await _secureStorage.read(key: _apiKeyKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting API key: $e');
      }
      return null;
    }
  }

  Future<void> saveApiKey(String apiKey) async {
    try {
      if (kIsWeb) {
        // Web平台使用SharedPreferences + 简单加密
        final prefs = await SharedPreferences.getInstance();
        final salt = _generateSalt();
        final encryptedKey = _encryptForWeb(apiKey, salt);
        
        await prefs.setString(_apiKeyKey, encryptedKey);
        await prefs.setString(_saltKey, salt);
      } else {
        // 移动端使用flutter_secure_storage
        await _secureStorage.write(key: _apiKeyKey, value: apiKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving API key: $e');
      }
      rethrow;
    }
  }

  Future<void> deleteApiKey() async {
    try {
      if (kIsWeb) {
        // Web平台清除SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_apiKeyKey);
        await prefs.remove(_saltKey);
      } else {
        // 移动端清除flutter_secure_storage
        await _secureStorage.delete(key: _apiKeyKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting API key: $e');
      }
      rethrow;
    }
  }

  Future<bool> hasApiKey() async {
    String? apikey = await getApiKey();
    return apikey != null && apikey.isNotEmpty;
  }

  /// 获取存储平台信息（用于调试）
  String getStoragePlatform() {
    return kIsWeb ? 'SharedPreferences (Web)' : 'FlutterSecureStorage (Native)';
  }
}