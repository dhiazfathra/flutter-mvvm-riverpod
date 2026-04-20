// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      minVersion: (json['minVersion'] as num).toInt(),
      forceUpdate: json['forceUpdate'] as bool? ?? false,
      announcementTitle: json['announcementTitle'] as String?,
      announcementBody: json['announcementBody'] as String?,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'minVersion': instance.minVersion,
      'forceUpdate': instance.forceUpdate,
      'announcementTitle': instance.announcementTitle,
      'announcementBody': instance.announcementBody,
    };
