// ignore_for_file: use_super_parameters, prefer-match-file-name

import 'app_exception.dart';

class NetworkException extends AppException {
  const NetworkException([String message = 'Network error occurred']) : super(message);
}

class AuthException extends AppException {
  const AuthException([String message = 'Authentication failed']) : super(message);
}

class TokenExpiredException extends AppException {
  const TokenExpiredException([String message = 'Token expired']) : super(message, code: 401);
}

class ValidationException extends AppException {
  const ValidationException([String message = 'Validation failed']) : super(message);
}

class ServerException extends AppException {
  const ServerException([String message = 'Server error', int? code]) : super(message, code: code);
}
