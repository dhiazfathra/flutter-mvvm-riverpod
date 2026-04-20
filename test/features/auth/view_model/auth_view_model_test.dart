import 'package:flutter_mvvm_riverpod/core/storage/secure_storage.dart';
import 'package:flutter_mvvm_riverpod/features/auth/view_model/auth_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

void main() {
  group('AuthViewModel', () {
    late AuthViewModel authViewModel;
    late SecureStorage secureStorage;
    late MockFlutterSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      secureStorage = SecureStorage(storage: mockStorage);
      authViewModel = AuthViewModel(secureStorage);
    });

    test('initial state should not be logged in', () {
      expect(authViewModel.state.isLoggedIn, false);
    });

    test('login should set isLoggedIn to true', () async {
      final bool result = await authViewModel.login('test@example.com', 'password');
      expect(result, true);
      expect(authViewModel.state.isLoggedIn, true);
    });

    test('logout should set isLoggedIn to false', () async {
      await authViewModel.login('test@example.com', 'password');
      await authViewModel.logout();
      expect(authViewModel.state.isLoggedIn, false);
    });
  });
}
