import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/core/errors/exceptions.dart';
import 'package:flutter_mvvm_riverpod/core/network/error_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorInterceptor', () {
    late ErrorInterceptor interceptor;

    setUp(() {
      interceptor = ErrorInterceptor();
    });

    group('onError', () {
      test('maps connection error to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError, isNotNull);
        expect(capturedError!.error, isA<NetworkException>());
      });

      test('maps send timeout to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
      });

      test('maps receive timeout to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
      });

      test('maps connection timeout to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<AuthException>());
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<AuthException>());
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<TokenExpiredException>());
      });

      test('maps 401 with TOKEN_EXPIRED error code to TokenExpiredException', () {
        final exception = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 401,
            data: <String, dynamic>{'errorCode': 'TOKEN_EXPIRED', 'message': 'Nope'},
          ),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<TokenExpiredException>());
      });

      test('maps 401 with token message to AuthException', () {
        final exception = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 401,
            data: 'Invalid token',
          ),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<AuthException>());
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<ValidationException>());
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<ServerException>());
        expect((capturedError!.error! as ServerException).code, 500);
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

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<ServerException>());
        expect((capturedError!.error! as ServerException).code, 503);
      });

      test('maps cancel to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.cancel,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
      });

      test('maps unknown to NetworkException', () {
        final exception = DioException(requestOptions: RequestOptions(path: '/test'));

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
      });

      test('maps badCertificate to NetworkException', () {
        final exception = DioException(
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(exception, handler);

        expect(capturedError!.error, isA<NetworkException>());
      });

      test('preserves type property in copyWith', () {
        final originalException = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(originalException, handler);

        expect(capturedError!.type, equals(originalException.type));
      });

      test('preserves requestOptions in copyWith', () {
        final requestOptions = RequestOptions(path: '/test');
        final originalException = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: requestOptions,
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(originalException, handler);

        expect(capturedError!.requestOptions, equals(originalException.requestOptions));
      });

      test('preserves response in copyWith', () {
        final originalException = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 500,
            data: {'error': 'Server error'},
          ),
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(originalException, handler);

        expect(capturedError!.response, equals(originalException.response));
      });

      test('preserves message in copyWith', () {
        final originalException = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/test'),
          message: 'Connection failed',
        );

        DioException? capturedError;
        final handler = _MockErrorInterceptorHandler((error) {
          capturedError = error;
        });

        interceptor.onError(originalException, handler);

        expect(capturedError!.message, equals(originalException.message));
      });
    });
  });
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  _MockErrorInterceptorHandler(this.callback);

  final void Function(DioException) callback;

  @override
  void next(DioException err) {
    callback(err);
  }
}
