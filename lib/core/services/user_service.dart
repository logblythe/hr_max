import 'package:auto_route/auto_route.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/network/models/login_res.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  ApiService _api;

  UserService({@required ApiService apiService}) : _api = apiService;

  LoginRes _loginModel;

  LoginRes get loginModel => _loginModel;

  login(params) => _api.post("/account/userLogin", params: params).then(
        (value) {
          _loginModel = LoginRes.fromJsonMap(value);
          /*   _storageHelper.set(key: KEY_EMAIL, value: params['email']);
          _storageHelper.set(key: KEY_PASSWORD, value: params['password']);
          _storageHelper.set(key: KEY_TOKEN, value: _loginModel.token);*/
        },
      );
}
