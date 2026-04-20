import 'package:json_annotation/json_annotation.dart';

part 'fcm_message.g.dart';

@JsonSerializable()
class FcmMessage {
  const FcmMessage({
    this.title,
    this.body,
    this.data,
    this.androidNotification,
    this.aps,
  });

  factory FcmMessage.fromJson(Map<String, dynamic> json) => _$FcmMessageFromJson(json);

  final String? title;
  final String? body;
  final String? data;
  final Map<String, dynamic>? androidNotification;
  final Map<String, dynamic>? aps;

  Map<String, dynamic> toJson() => _$FcmMessageToJson(this);
}
