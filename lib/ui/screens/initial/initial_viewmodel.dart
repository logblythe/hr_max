import 'dart:convert';

import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class InitialViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<StorageService>();
  final _userService = locator<UserService>();

  init() async {
    if (await _storageService.get(KEY_TOKEN) != null) {
      String storedModel = await _storageService.get(KEY_LOGIN_RESPONSE);
      _userService.loginModel = jsonDecode(storedModel);
      _navigationService.replace(Routes.HomeRoute);
    } else {
      _navigationService.replace(Routes.LoginRoute);
    }
  }
}
