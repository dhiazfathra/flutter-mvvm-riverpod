import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiClient {
  ApiClient(this._dioClient);

  final DioClient _dioClient;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Response<dynamic> response = await _dioClient.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return response.data as Map<String, dynamic>;
  }

  Future<void> logout() async {
    await _dioClient.post<void>('/auth/logout');
  }

  Future<Map<String, dynamic>> getAppConfig() async {
    final Response<dynamic> response = await _dioClient.get('/config/app');

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getFeatureFlags() async {
    final Response<dynamic> response = await _dioClient.get('/feature-flags');

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getAnnouncement() async {
    final Response<dynamic> response = await _dioClient.get('/announcement');

    return response.data as Map<String, dynamic>;
  }
}
