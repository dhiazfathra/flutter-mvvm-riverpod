import 'package:json_annotation/json_annotation.dart';

part 'feature_flag.g.dart';

@JsonSerializable()
class FeatureFlag {
  final String key;
  final bool value;

  const FeatureFlag({
    required this.key,
    required this.value,
  });

  factory FeatureFlag.fromJson(Map<String, dynamic> json) => _$FeatureFlagFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFlagToJson(this);
}

@JsonSerializable()
class FeatureFlagsResponse {
  final List<FeatureFlag> flags;
  final DateTime? lastUpdated;

  const FeatureFlagsResponse({
    required this.flags,
    this.lastUpdated,
  });

  factory FeatureFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFlagsResponseToJson(this);
}
