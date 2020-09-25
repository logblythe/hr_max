import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/login_res.dart';

class ProfileViewmodel extends BaseViewModel {
  final _userService = locator<UserService>();

  LoginRes get loginRes => _userService.loginModel;
}
