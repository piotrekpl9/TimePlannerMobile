abstract class SecureStorageDaoAbstraction {
  Future<String?> read(String key);
  Future write(String key, String value);
  Future delete(String key);
}
