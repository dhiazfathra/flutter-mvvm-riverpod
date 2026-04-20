import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

class SecureStorage {
  SecureStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
          );

  final FlutterSecureStorage _storage;

  Future<void> setAccessToken(String token) {
    return _storage.write(key: AppConstants.accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  Future<void> setRefreshToken(String token) {
    return _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  Future<void> setUserId(String userId) {
    return _storage.write(key: AppConstants.userIdKey, value: userId);
  }

  Future<String?> getUserId() {
    return _storage.read(key: AppConstants.userIdKey);
  }

  Future<void> setUserEmail(String email) {
    return _storage.write(key: AppConstants.userEmailKey, value: email);
  }

  Future<String?> getUserEmail() {
    return _storage.read(key: AppConstants.userEmailKey);
  }

  Future<void> setFeatureFlags(String flagsJson) {
    return _storage.write(key: AppConstants.featureFlagsKey, value: flagsJson);
  }

  Future<String?> getFeatureFlags() {
    return _storage.read(key: AppConstants.featureFlagsKey);
  }

  Future<void> clearAuth() {
    return _storage
        .delete(key: AppConstants.accessTokenKey)
        .then((_) {
          return _storage.delete(key: AppConstants.refreshTokenKey);
        })
        .then((_) {
          return _storage.delete(key: AppConstants.userIdKey);
        })
        .then((_) {
          return _storage.delete(key: AppConstants.userEmailKey);
        });
  }

  Future<void> clearAll() {
    return _storage.deleteAll();
  }

  Future<bool> isLoggedIn() async {
    final String? token = await getAccessToken();

    return token != null && token.isNotEmpty;
  }
}
