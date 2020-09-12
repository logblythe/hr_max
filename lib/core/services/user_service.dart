import 'package:auto_route/auto_route.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/network/models/login_res.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  ApiService _api;
  StorageService _storage;

  UserService(
      {@required ApiService apiService,
      @required StorageService storageService})
      : _api = apiService,
        _storage = storageService;

  LoginRes _loginModel;

  LoginRes get loginModel => _loginModel;

  login(params) => _api.post("/account/userLogin", params: params).then(
        (value) {
          _loginModel = LoginRes.fromJsonMap(value);

          ///TODO get deviceId in response and save it
          _storage.set(KEY_DEVICE_ID, value: "1");
          _storage.set(KEY_TOKEN, value: _loginModel.userToken);
        },
      );
}
