import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';

final featureFlagViewModelProvider = NotifierProvider<FeatureFlagViewModel, FeatureFlagState>(
  FeatureFlagViewModel.new,
);

class FeatureFlagState {
  const FeatureFlagState({this.flags = const {}, this.isLoading = false, this.error});

  final Map<String, bool> flags;
  final bool isLoading;
  final String? error;

  FeatureFlagState copyWith({Map<String, bool>? flags, bool? isLoading, String? error}) {
    return FeatureFlagState(
      flags: flags ?? this.flags,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class FeatureFlagViewModel extends Notifier<FeatureFlagState> {
  @override
  FeatureFlagState build() {
    return const FeatureFlagState();
  }

  Future<void> loadFlags() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      final flags = Map<String, bool>.from(AppConstants.defaultFeatureFlags);

      state = state.copyWith(flags: flags, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  bool isEnabled(String key) {
    return state.flags[key] ?? false;
  }

  bool getFlag(String key, {bool defaultValue = false}) {
    return state.flags[key] ?? defaultValue;
  }
}
