import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
  final String userId;
  final String email;

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
