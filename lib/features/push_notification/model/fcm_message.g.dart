// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmMessage _$FcmMessageFromJson(Map<String, dynamic> json) => FcmMessage(
      title: json['title'] as String?,
      body: json['body'] as String?,
      data: json['data'] as String?,
      androidNotification: json['androidNotification'] as Map<String, dynamic>?,
      aps: json['aps'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FcmMessageToJson(FcmMessage instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'androidNotification': instance.androidNotification,
      'aps': instance.aps,
    };
