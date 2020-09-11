import 'package:flutter/material.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class LearningViewModel extends BaseViewModel {
  UserService _userService;
  NavigationService _navigationService;
  bool _obscureText = true;

  LearningViewModel({
    @required NavigationService navigationService,
  }) : this._navigationService = navigationService;

  get obscureText => _obscureText;

//  Future<LoginResponse> login(String email, String password) async {
//    setBusy(true);
//    var loginResponse = await _userService.performLogin(email, password);
//    if (loginResponse.error != null) {
//      setError(loginResponse.error);
//    } else {
//      setBusy(false);
//    }
//    return loginResponse;
//  }

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  navigateToHome() => _navigationService.replace(Routes.HomeRoute);

  fetchJokes(String category) async {}

  void login(String email, String password) {
    navigateToHome();
//    setBusy(true);
//    Future.delayed(Duration(milliseconds: 500)).then((value) {
//      setBusy(false);
//      navigateToHome();
//    });
  }
}
