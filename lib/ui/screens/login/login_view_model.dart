import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class LoginViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _storageService = locator<StorageService>();
  bool _obscureText = true;
  String _deviceId;

  get obscureText => _obscureText;

  toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  login(String username, String password) async {
    _storageService.deleteAll();
    try {
      setLoading();
      await _userService.login({
        "username": username,
        "password": password,
        "deviceId": _deviceId,
      });
      setCompleted();
      _navigationService.replace(Routes.HomeRoute);
    } catch (e) {
      setError(e);
    }
  }

  getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.codename.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    _deviceId = "$deviceName$deviceVersion$identifier";
  }
}
