import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const _PlaceholderScreen('Splash'),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        builder: (context, state) => const _PlaceholderScreen('Login'),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const _PlaceholderScreen('Home'),
      ),
    ],
  );
});

class _PlaceholderScreen extends StatelessWidget {
  final String name;
  const _PlaceholderScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('$name Screen - Placeholder')),
    );
  }
}
