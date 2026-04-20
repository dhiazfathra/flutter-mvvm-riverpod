import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../view_model/splash_view_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    if (!mounted) {
      return;
    }

    final SplashViewModel viewModel = ref.read(splashViewModelProvider.notifier);
    await viewModel.initialize();

    if (!mounted) {
      return;
    }

    final SplashState state = ref.read(splashViewModelProvider);

    if (state.needsUpdate) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please update the app')));
      }

      return;
    }

    final bool isLoggedIn = viewModel.isLoggedIn();
    if (isLoggedIn) {
      context.go(AppConstants.homeRoute);
    } else {
      context.go(AppConstants.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SplashState splashState = ref.watch(splashViewModelProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 80),
            const SizedBox(height: 24),
            const Text(
              'E-Commerce App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (splashState.isLoading) ...[
              const CircularProgressIndicator(),
            ] else if (splashState.error != null) ...[
              Text('Error: ${splashState.error}'),
            ],
          ],
        ),
      ),
    );
  }
}
