import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/secure_storage_dao_abstraction.dart';

class SecureStorageDao implements SecureStorageDaoAbstraction {
  final storage = const FlutterSecureStorage();

  @override
  Future delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future write(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
