import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_riverpod/features/auth/model/auth_response.dart';

void main() {
  group('AuthResponse', () {
    test('fromJson should parse correctly', () {
      final json = {
        'accessToken': 'token123',
        'refreshToken': 'refresh123',
        'userId': 'user123',
        'email': 'test@example.com',
      };

      final response = AuthResponse.fromJson(json);

      expect(response.accessToken, 'token123');
      expect(response.refreshToken, 'refresh123');
      expect(response.userId, 'user123');
      expect(response.email, 'test@example.com');
    });

    test('toJson should serialize correctly', () {
      const response = AuthResponse(
        accessToken: 'token123',
        refreshToken: 'refresh123',
        userId: 'user123',
        email: 'test@example.com',
      );

      final json = response.toJson();

      expect(json['accessToken'], 'token123');
      expect(json['refreshToken'], 'refresh123');
    });
  });
}
