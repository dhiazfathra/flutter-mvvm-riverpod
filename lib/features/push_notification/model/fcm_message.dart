import 'package:json_annotation/json_annotation.dart';

part 'fcm_message.g.dart';

@JsonSerializable()
class FcmMessage {
  final String? title;
  final String? body;
  final String? data;
  final Map<String, dynamic>? androidNotification;
  final Map<String, dynamic>? aps;

  const FcmMessage({
    this.title,
    this.body,
    this.data,
    this.androidNotification,
    this.aps,
  });

  factory FcmMessage.fromJson(Map<String, dynamic> json) => _$FcmMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FcmMessageToJson(this);
}
