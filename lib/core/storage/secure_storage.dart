import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  // Token operations
  Future<void> setAccessToken(String token) async {
    await _storage.write(key: AppConstants.accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  // User data operations
  Future<void> setUserId(String userId) async {
    await _storage.write(key: AppConstants.userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: AppConstants.userIdKey);
  }

  Future<void> setUserEmail(String email) async {
    await _storage.write(key: AppConstants.userEmailKey, value: email);
  }

  Future<String?> getUserEmail() async {
    return _storage.read(key: AppConstants.userEmailKey);
  }

  // Feature flags
  Future<void> setFeatureFlags(String flagsJson) async {
    await _storage.write(key: AppConstants.featureFlagsKey, value: flagsJson);
  }

  Future<String?> getFeatureFlags() async {
    return _storage.read(key: AppConstants.featureFlagsKey);
  }

  // Clear all auth data
  Future<void> clearAuth() async {
    await _storage.delete(key: AppConstants.accessTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
    await _storage.delete(key: AppConstants.userIdKey);
    await _storage.delete(key: AppConstants.userEmailKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
