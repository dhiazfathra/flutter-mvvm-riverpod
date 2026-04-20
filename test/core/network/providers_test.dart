import 'package:flutter_mvvm_riverpod/core/network/api_client.dart';
import 'package:flutter_mvvm_riverpod/core/network/dio_client.dart';
import 'package:flutter_mvvm_riverpod/core/network/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('dioClientProvider', () {
    test('should provide DioClient instance', () {
      final dioClient = container.read(dioClientProvider);
      expect(dioClient, isA<DioClient>());
    });

    test('should have base URL configured', () {
      final dioClient = container.read(dioClientProvider);
      expect(dioClient.dio.options.baseUrl, isNotEmpty);
    });
  });

  group('apiClientProvider', () {
    test('should provide ApiClient instance', () {
      final apiClient = container.read(apiClientProvider);
      expect(apiClient, isA<ApiClient>());
    });

    test('should depend on dioClientProvider', () {
      final apiClient = container.read(apiClientProvider);
      expect(apiClient, isNotNull);
    });
  });

  group('secureStorageProvider', () {
    test('should provide SecureStorage instance', () {
      final secureStorage = container.read(secureStorageProvider);
      expect(secureStorage, isNotNull);
    });
  });
}
