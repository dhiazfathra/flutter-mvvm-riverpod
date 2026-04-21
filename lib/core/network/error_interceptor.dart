import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import '../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final AppException customException = _mapToCustomException(err);
    final DioException newError = err.copyWith(error: customException);
    handler.next(newError);
  }

  AppException _mapToCustomException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        return NetworkException(_getErrorMessage(err));
      case DioExceptionType.badResponse:
        return _mapStatusCodeToException(err);
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return NetworkException(_getErrorMessage(err));
    }
  }

  AppException _mapStatusCodeToException(DioException err) {
    final int? statusCode = err.response?.statusCode;
    final Object? data = err.response?.data;
    final String? responseText = data is String ? data : data?.toString();

    if (statusCode == null) {
      return NetworkException(_getErrorMessage(err));
    }

    if (statusCode == 401) {
      final String text = responseText?.toLowerCase() ?? '';
      final bool hasExpiryIndicator =
          text.contains('expired') ||
          text.contains('token_expired') ||
          _hasErrorCodeExpiry(err.response?.data);
      if (hasExpiryIndicator) {
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

    if (statusCode >= 400) {
      return ServerException(responseText ?? 'Request failed', statusCode);
    }

    return NetworkException(_getErrorMessage(err));
  }

  bool _hasErrorCodeExpiry(Object? data) {
    if (data is! Map<String, dynamic>) {
      return false;
    }
    final String errorCode = data['errorCode']?.toString().toLowerCase() ?? '';
    return errorCode == 'token_expired';
  }

  String _getErrorMessage(DioException err) {
    return err.error?.toString() ?? 'An error occurred';
  }
}

extension DioExceptionExtension on DioException {
  DioException copyWith({
    Object? error,
    DioExceptionType? type,
    RequestOptions? requestOptions,
    Response<dynamic>? response,
    String? message,
    StackTrace? stackTrace,
  }) {
    return DioException(
      type: type ?? this.type,
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      error: error ?? this.error,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}
