import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';

class ApiInterceptors extends Interceptor {
  ApiInterceptors(this._secureStorage, this._dio);
  final SecureStorage _secureStorage;

  final Dio _dio;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final bool refreshed = await _refreshToken();
        if (refreshed) {
          final Response<Object?> retryResponse = await _retry(err.requestOptions);

          return handler.resolve(retryResponse);
        }
      } catch (e) {
        await _secureStorage.clearAuth();
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final String? refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null) {
      return false;
    }

    try {
      final Response<Object?> response = await _dio.post<Object?>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {}),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final accessToken = data['access_token'] as String?;
        if (accessToken != null) {
          await _secureStorage.setAccessToken(accessToken);
        }
        final newRefreshToken = data['refresh_token'] as String?;
        if (newRefreshToken != null) {
          await _secureStorage.setRefreshToken(newRefreshToken);
        }

        return true;
      }
    } catch (_) {}

    return false;
  }

  Future<Response<Object?>> _retry(RequestOptions requestOptions) async {
    final String? token = await _secureStorage.getAccessToken();
    requestOptions.headers['Authorization'] = 'Bearer $token';

    return _dio.fetch(requestOptions);
  }
}
