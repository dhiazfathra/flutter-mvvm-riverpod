import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_riverpod/core/errors/exceptions.dart';

void main() {
  group('AppExceptions', () {
    test('NetworkException should have correct message', () {
      const exception = NetworkException('No internet');
      expect(exception.message, 'No internet');
    });

    test('TokenExpiredException should have code 401', () {
      const exception = TokenExpiredException();
      expect(exception.code, 401);
    });

    test('AuthException should have correct default message', () {
      const exception = AuthException();
      expect(exception.message, 'Authentication failed');
    });
  });
}
