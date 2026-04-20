import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage.dart';
import 'api_interceptors.dart';

class DioClient {
  final Dio _dio;
  final SecureStorage _secureStorage;

  DioClient({required SecureStorage secureStorage})
      : _secureStorage = secureStorage,
        _dio = Dio(BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          headers: {'Content-Type': 'application/json'},
        )) {
    _dio.interceptors.addAll([
      AuthInterceptor(_secureStorage, _dio),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
  }
}
