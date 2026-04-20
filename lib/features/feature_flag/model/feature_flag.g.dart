// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) => FeatureFlag(
      key: json['key'] as String,
      value: json['value'] as bool,
    );

Map<String, dynamic> _$FeatureFlagToJson(FeatureFlag instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

FeatureFlagsResponse _$FeatureFlagsResponseFromJson(Map<String, dynamic> json) =>
    FeatureFlagsResponse(
      flags: (json['flags'] as List<dynamic>)
          .map((e) => FeatureFlag.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated:
          json['lastUpdated'] == null ? null : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$FeatureFlagsResponseToJson(FeatureFlagsResponse instance) =>
    <String, dynamic>{
      'flags': instance.flags,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
