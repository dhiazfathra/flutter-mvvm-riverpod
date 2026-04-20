class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://api.example.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String featureFlagsKey = 'feature_flags';

  // Feature Flags Defaults
  static const Map<String, bool> defaultFeatureFlags = {
    'is_home_enabled': true,
    'is_payment_enabled': false,
    'is_chat_enabled': false,
  };

  // Routes
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
}
