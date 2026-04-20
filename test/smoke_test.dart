import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/app.dart';
import 'package:flutter_mvvm_riverpod/features/push_notification/view_model/push_notification_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPushNotificationViewModel extends Notifier<PushNotificationState>
    implements PushNotificationViewModel {
  @override
  PushNotificationState build() {
    return const PushNotificationState();
  }

  @override
  Future<void> initialize() async {
    state = state.copyWith(isInitialized: true);
  }

  @override
  Future<String?> getToken() async => null;

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}
}

void main() {
  testWidgets('App should build without errors', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pushNotificationViewModelProvider.overrideWith(() => MockPushNotificationViewModel()),
        ],
        child: const MaterialApp(home: App()),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
