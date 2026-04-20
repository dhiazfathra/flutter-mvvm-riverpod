import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pushNotificationViewModelProvider =
    NotifierProvider<PushNotificationViewModel, PushNotificationState>(
      PushNotificationViewModel.new,
    );

class PushNotificationState {
  const PushNotificationState({this.token, this.isInitialized = false, this.error});

  final String? token;
  final bool isInitialized;
  final String? error;

  PushNotificationState copyWith({String? token, bool? isInitialized, String? error}) {
    return PushNotificationState(
      token: token ?? this.token,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
    );
  }
}

class PushNotificationViewModel extends Notifier<PushNotificationState> {
  @override
  PushNotificationState build() {
    return const PushNotificationState();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    try {
      final NotificationSettings settings = await _firebaseMessaging.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        final String? token = await _firebaseMessaging.getToken();
        state = state.copyWith(token: token, isInitialized: true);

        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isInitialized: false);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Handle foreground messages
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle background messages
  }

  Future<String?> getToken() async {
    if (state.token == null) {
      final String? token = await _firebaseMessaging.getToken();
      state = state.copyWith(token: token);
    }

    return state.token;
  }

  Future<void> subscribeToTopic(String topic) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
