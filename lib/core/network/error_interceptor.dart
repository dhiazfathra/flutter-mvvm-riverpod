import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import '../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final customException = mapToCustomException(err);
    final newError = err.copyWith(error: customException);
    handler.next(newError);
  }

  AppException mapToCustomException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        return NetworkException(_getErrorMessage(err));
      default:
        return _mapStatusCodeToException(err);
    }
  }

  AppException _mapStatusCodeToException(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;
    final responseText = data is String ? data : data?.toString();

    if (statusCode == null) {
      return NetworkException(_getErrorMessage(err));
    }

    if (statusCode == 401) {
      final text = responseText?.toLowerCase() ?? '';
      if (text.contains('expired') || text.contains('token')) {
        return TokenExpiredException(responseText ?? 'Token expired');
      }
      return AuthException(responseText ?? 'Unauthorized');
    }

    if (statusCode == 403) {
      return const AuthException('Forbidden');
    }

    if (statusCode == 422) {
      return ValidationException(responseText ?? 'Validation failed');
    }

    if (statusCode >= 500) {
      return ServerException(responseText ?? 'Server error', statusCode);
    }

    return NetworkException(_getErrorMessage(err));
  }

  String _getErrorMessage(DioException err) {
    return err.error?.toString() ?? 'An error occurred';
  }
}

extension DioExceptionExtension on DioException {
  DioException copyWith({Object? error}) {
    return DioException(
      type: type,
      requestOptions: requestOptions,
      response: response,
      error: error ?? this.error,
      message: message,
    );
  }
}
