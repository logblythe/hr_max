import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/network/api_exceptions.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  bool _obscureText = true;

  get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  login(String email, String password) async {
    try {
      setLoading();
      await _userService.login({
        "username": email,
        "password": password,
        "deviceId": "1",
      });
      setCompleted();
      _navigationService.replace(Routes.HomeRoute);
    } catch (e) {
      setError(e);
      var error;
      if (e is AppException) {
        error = e.toJson()['Message'] ?? e.toJson()['message'];
      } else {
        error = e.toString();
      }
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
