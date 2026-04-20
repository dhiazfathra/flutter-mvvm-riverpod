import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/providers.dart';
import '../model/feature_flag.dart';

final featureFlagsProvider = FutureProvider<List<FeatureFlag>>((ref) async {
  final ApiClient apiClient = ref.read(apiClientProvider);
  final Map<String, dynamic> response = await apiClient.getFeatureFlags();
  final List<dynamic> flagsList = response['flags'] as List<dynamic>;
  return flagsList.map((f) {
    final map = Map<String, dynamic>.from(f as Map);
    return FeatureFlag(key: map['key'] as String, value: map['value'] as bool);
  }).toList();
});
