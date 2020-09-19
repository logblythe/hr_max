import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const String KEY_EMAIL = "username";
const String KEY_PASSWORD = "password";
const String KEY_TOKEN = "key_token";
const String KEY_DEVICE_ID = "key_device_id";
const String KEY_LOGIN_RESPONSE = "key_login_response";

@lazySingleton
class StorageService {
  FlutterSecureStorage _secureStorage;

  FlutterSecureStorage get secureStorage {
    if (_secureStorage == null) {
      _secureStorage = FlutterSecureStorage();
    }
    return _secureStorage;
  }

  set(key, {value}) => secureStorage.write(key: key, value: value);

  get(key) => secureStorage.read(key: key);

  delete(key) => secureStorage.delete(key: key);

  Future<Map<String, String>> allValues() => secureStorage.readAll();

  deleteAll() => secureStorage.deleteAll();
}
