import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pushNotificationViewModelProvider =
    StateNotifierProvider<PushNotificationViewModel, PushNotificationState>((ref) {
  return PushNotificationViewModel();
});

class PushNotificationState {
  final String? token;
  final bool isInitialized;
  final String? error;

  const PushNotificationState({
    this.token,
    this.isInitialized = false,
    this.error,
  });

  PushNotificationState copyWith({
    String? token,
    bool? isInitialized,
    String? error,
  }) {
    return PushNotificationState(
      token: token ?? this.token,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
    );
  }
}

class PushNotificationViewModel extends StateNotifier<PushNotificationState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  PushNotificationViewModel() : super(const PushNotificationState());

  Future<void> initialize() async {
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        final token = await _firebaseMessaging.getToken();
        state = state.copyWith(
          token: token,
          isInitialized: true,
        );

        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isInitialized: false,
      );
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Handle foreground message
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle background message
  }

  Future<String?> getToken() async {
    if (state.token == null) {
      final token = await _firebaseMessaging.getToken();
      state = state.copyWith(token: token);
    }
    return state.token;
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
