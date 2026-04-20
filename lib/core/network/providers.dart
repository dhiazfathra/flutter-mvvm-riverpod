import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/secure_storage.dart';
import 'api_client.dart';
import 'dio_client.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final dioClientProvider = Provider<DioClient>((ref) {
  final SecureStorage secureStorage = ref.read(secureStorageProvider);
  return DioClient(secureStorage: secureStorage);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final DioClient dioClient = ref.read(dioClientProvider);
  return ApiClient(dioClient);
});
