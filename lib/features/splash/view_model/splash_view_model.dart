import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/view_model/auth_view_model.dart';
import '../model/app_config.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, SplashState>((ref) {
  return SplashViewModel(ref);
});

class SplashState {
  const SplashState({
    this.isLoading = true,
    this.appConfig,
    this.featureFlags = const {},
    this.announcement,
    this.needsUpdate = false,
    this.error,
  });
  final bool isLoading;
  final AppConfig? appConfig;
  final Map<String, bool> featureFlags;
  final String? announcement;
  final bool needsUpdate;
  final String? error;

  SplashState copyWith({
    bool? isLoading,
    AppConfig? appConfig,
    Map<String, bool>? featureFlags,
    String? announcement,
    bool? needsUpdate,
    String? error,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      appConfig: appConfig ?? this.appConfig,
      featureFlags: featureFlags ?? this.featureFlags,
      announcement: announcement,
      needsUpdate: needsUpdate ?? this.needsUpdate,
      error: error,
    );
  }
}

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel(this._ref) : super(const SplashState());

  final Ref _ref;

  Future<void> initialize() async {
    try {
      final AppConfig appConfig = await _loadAppConfig();
      const currentVersion = 1;
      final bool needsUpdate = appConfig.minVersion > currentVersion;
      final Map<String, bool> flags = await _loadFeatureFlags();
      final String? announcement = await _loadAnnouncement();

      state = state.copyWith(
        isLoading: false,
        appConfig: appConfig,
        featureFlags: flags,
        announcement: announcement,
        needsUpdate: needsUpdate,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<AppConfig> _loadAppConfig() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return AppConfig.defaultConfig;
  }

  Future<Map<String, bool>> _loadFeatureFlags() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return {
      'is_home_enabled': true,
      'is_payment_enabled': false,
      'is_chat_enabled': false,
    };
  }

  Future<String?> _loadAnnouncement() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return null;
  }

  bool isLoggedIn() {
    return _ref.read(authViewModelProvider).isLoggedIn;
  }
}
