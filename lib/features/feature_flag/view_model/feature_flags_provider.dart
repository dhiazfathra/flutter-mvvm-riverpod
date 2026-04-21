import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/providers.dart';
import '../model/feature_flag.dart';

final featureFlagsProvider = FutureProvider<List<FeatureFlag>>((ref) async {
  final ApiClient apiClient = ref.read(apiClientProvider);
  final Map<String, dynamic> response = await apiClient.getFeatureFlags();

  return FeatureFlagsResponse.fromJson(response).flags;
});
