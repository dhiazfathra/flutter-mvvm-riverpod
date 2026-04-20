import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  const AppConfig({
    required this.minVersion,
    this.forceUpdate = false,
    this.announcementTitle,
    this.announcementBody,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
  final int minVersion;
  final bool forceUpdate;
  final String? announcementTitle;
  final String? announcementBody;

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  static AppConfig get defaultConfig => const AppConfig(
        minVersion: 1,
      );
}
