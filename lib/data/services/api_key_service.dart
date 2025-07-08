import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiKeyService {
  static const String _apiKeyKey = 'api_key';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getApiKey() async {
    try {
      return await _storage.read(key: _apiKeyKey);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: _apiKeyKey, value: apiKey);
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: _apiKeyKey);
  } 

  Future<bool> hasApiKey() async {
    String? apikey = await _storage.read(key: _apiKeyKey);
    return apikey != null && apikey.isNotEmpty;
  }

}