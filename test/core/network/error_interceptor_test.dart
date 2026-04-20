import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_riverpod/core/errors/exceptions.dart';
import 'package:flutter_mvvm_riverpod/core/network/error_interceptor.dart';

void main() {
  group('ErrorInterceptor', () {
    late ErrorInterceptor interceptor;

    setUp(() {
      interceptor = ErrorInterceptor();
    });

    test('maps connection error to NetworkException', () {
      final exception = DioException(
        type: DioExceptionType.connectionError,
        requestOptions: RequestOptions(path: '/test'),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<NetworkException>());
    });

    test('maps send timeout to NetworkException', () {
      final exception = DioException(
        type: DioExceptionType.sendTimeout,
        requestOptions: RequestOptions(path: '/test'),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<NetworkException>());
    });

    test('maps receive timeout to NetworkException', () {
      final exception = DioException(
        type: DioExceptionType.receiveTimeout,
        requestOptions: RequestOptions(path: '/test'),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<NetworkException>());
    });

    test('maps 403 to AuthException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 403,
          data: 'Forbidden',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<AuthException>());
    });

    test('maps 401 without expired/token to AuthException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: 'Unauthorized',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<AuthException>());
    });

    test('maps 401 with expired message to TokenExpiredException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: 'Token expired',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<TokenExpiredException>());
    });

    test('maps 401 with token message to TokenExpiredException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: 'Invalid token',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<TokenExpiredException>());
    });

    test('maps 422 to ValidationException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: 'Validation error',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<ValidationException>());
    });

    test('maps 500 to ServerException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: 'Internal server error',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<ServerException>());
      expect((result as ServerException).code, 500);
    });

    test('maps 503 to ServerException', () {
      final exception = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 503,
          data: 'Service unavailable',
        ),
      );

      final result = interceptor.mapToCustomException(exception);

      expect(result, isA<ServerException>());
      expect((result as ServerException).code, 503);
    });
  });
}
