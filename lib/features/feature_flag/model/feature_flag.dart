import 'package:json_annotation/json_annotation.dart';

part 'feature_flag.g.dart';

@JsonSerializable()
class FeatureFlag {
  const FeatureFlag({
    required this.key,
    required this.value,
  });

  factory FeatureFlag.fromJson(Map<String, dynamic> json) => _$FeatureFlagFromJson(json);

  final String key;
  final bool value;

  Map<String, dynamic> toJson() => _$FeatureFlagToJson(this);
}

@JsonSerializable()
class FeatureFlagsResponse {
  const FeatureFlagsResponse({
    required this.flags,
    this.lastUpdated,
  });

  factory FeatureFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsResponseFromJson(json);

  final List<FeatureFlag> flags;
  final DateTime? lastUpdated;

  Map<String, dynamic> toJson() => _$FeatureFlagsResponseToJson(this);
}
