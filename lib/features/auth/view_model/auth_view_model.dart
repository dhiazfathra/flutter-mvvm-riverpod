// ignore: prefer-match-file-name
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/secure_storage.dart';
import '../model/auth_response.dart';

class AuthState {
  const AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.error,
    this.userId,
    this.email,
  });
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final String? userId;
  final String? email;

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
    String? userId,
    String? email,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: userId ?? this.userId,
      email: email ?? this.email,
    );
  }
}

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(AuthViewModel.new);

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() {
    _checkAuthStatus();

    return const AuthState();
  }

  SecureStorage get _secureStorage => ref.read(secureStorageProvider);

  Future<void> _checkAuthStatus() async {
    final bool isLoggedIn = await _secureStorage.isLoggedIn();
    final String? userId = await _secureStorage.getUserId();
    final String? email = await _secureStorage.getUserEmail();

    state = state.copyWith(isLoggedIn: isLoggedIn, userId: userId, email: email);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      // email and password would be used in real implementation
      // ignore: avoid_unused_parameters

      const response = AuthResponse(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
        userId: 'user_123',
        email: 'test@example.com',
      );

      await _secureStorage.setAccessToken(response.accessToken);
      await _secureStorage.setRefreshToken(response.refreshToken);
      await _secureStorage.setUserId(response.userId);
      await _secureStorage.setUserEmail(response.email);

      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        userId: response.userId,
        email: response.email,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());

      return false;
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAuth();
    state = const AuthState();
  }

  Future<String?> getAccessToken() {
    // ignore: avoid_redundant_async
    return _secureStorage.getAccessToken();
  }
}

final authStateProvider = Provider<AuthState>((ref) {
  return ref.watch(authViewModelProvider);
});
