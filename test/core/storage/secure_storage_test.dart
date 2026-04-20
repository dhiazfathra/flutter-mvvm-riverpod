import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_riverpod/core/storage/secure_storage.dart';

class MockFlutterSecureStorage extends FlutterSecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<void> write({
    String? key,
    String? value,
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    _storage[key!] = value!;
  }

  @override
  Future<String?> read({
    String? key,
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    return _storage[key];
  }

  @override
  Future<void> delete({
    String? key,
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    _storage.remove(key);
  }

  @override
  Future<void> deleteAll({
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    _storage.clear();
  }

  @override
  Future<Map<String, String>> readAll({
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    return Map.from(_storage);
  }

  @override
  Future<bool> containsKey({
    String? key,
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
    LinuxOptions? lOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    return _storage.containsKey(key);
  }

  @override
  void registerListener(
      {required String key, required void Function(String?) listener}) {}

  @override
  void unregisterAllListenersForKey({required String key}) {}

  @override
  void unregisterListener(
      {required String key, required void Function(String?) listener}) {}

  @override
  AndroidOptions get aOptions => const AndroidOptions();

  @override
  IOSOptions get iOptions => const IOSOptions();

  @override
  LinuxOptions get lOptions => const LinuxOptions();

  @override
  MacOsOptions get mOptions => const MacOsOptions();

  @override
  WindowsOptions get wOptions => const WindowsOptions();

  @override
  WebOptions get webOptions => const WebOptions();

  @override
  Future<bool> isCupertinoProtectedDataAvailable() async {
    return true;
  }
}

void main() {
  late SecureStorage secureStorage;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage(storage: mockStorage);
  });

  group('SecureStorage', () {
    test('setAccessToken and getAccessToken should work', () async {
      await secureStorage.setAccessToken('test_token');
      final token = await secureStorage.getAccessToken();
      expect(token, 'test_token');
    });

    test('clearAuth should remove auth data', () async {
      await secureStorage.setAccessToken('token');
      await secureStorage.setRefreshToken('refresh');
      await secureStorage.setUserId('user123');
      await secureStorage.setUserEmail('test@example.com');

      await secureStorage.clearAuth();

      expect(await secureStorage.getAccessToken(), isNull);
      expect(await secureStorage.getRefreshToken(), isNull);
      expect(await secureStorage.getUserId(), isNull);
      expect(await secureStorage.getUserEmail(), isNull);
    });

    test('isLoggedIn should return true when token exists', () async {
      await secureStorage.setAccessToken('valid_token');
      final isLoggedIn = await secureStorage.isLoggedIn();
      expect(isLoggedIn, true);
    });

    test('isLoggedIn should return false when token is empty', () async {
      await secureStorage.setAccessToken('');
      final isLoggedIn = await secureStorage.isLoggedIn();
      expect(isLoggedIn, false);
    });
  });
}
