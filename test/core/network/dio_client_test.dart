import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_riverpod/core/network/dio_client.dart';
import 'package:flutter_mvvm_riverpod/core/storage/secure_storage.dart';

void main() {
  late DioClient dioClient;
  late SecureStorage secureStorage;

  setUp(() {
    secureStorage = SecureStorage();
    dioClient = DioClient(secureStorage: secureStorage);
  });

  group('DioClient', () {
    test('should have base URL configured', () {
      expect(dioClient.dio.options.baseUrl, isNotEmpty);
    });

    test('should have correct timeout settings', () {
      expect(dioClient.dio.options.connectTimeout, isNotNull);
      expect(dioClient.dio.options.receiveTimeout, isNotNull);
    });
  });
}
