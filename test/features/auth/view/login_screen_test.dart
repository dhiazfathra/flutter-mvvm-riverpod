import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/features/auth/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginScreen should display email and password fields', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Lanjutkan'), findsAtLeast(1));
    expect(find.text('Halo, Selamat Datang'), findsAtLeast(1));
  });
}
