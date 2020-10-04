import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/client.dart';

class LoginViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  bool _obscureText = true;
  String _deviceId;
  HrClient _selectedClient;
  List<HrClient> _clients;

  get obscureText => _obscureText;

  List<HrClient> get clients => _clients;

  toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  init() async {
    getDeviceDetails();
    getClients();
  }

  login(String username, String password) async {
    if (_selectedClient != null && _selectedClient.status == "Registered") {
      _userService.saveBaseUrl(_selectedClient.baseUrl);
      try {
        setLoading();
        await _userService.login({
          "username": username,
          "password": password,
          "deviceId": _deviceId,
          "apiLink": _selectedClient.baseUrl,
          "companyName": _selectedClient.name
        });
        setCompleted();
        _navigationService.replace(Routes.HomeRoute);
      } catch (e) {
        setError(e);
      }
    } else {
      setError("Your organisation is not registered");
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

  void getClients() {
    _clients = [
      HrClient(
          name: "Mega Bank Nepal",
          status: "Registered",
          baseUrl: "https://elearning.megabank.com.np/"),
      HrClient(
        name: "Macchapucchre Bank",
        status: "NotRegistered",
      ),
      HrClient(
        name: "Kamana Sewa Bikas Bank",
        status: "NotRegistered",
      ),
      HrClient(
        name: "Kumari Bank",
        status: "NotRegistered",
      ),
      HrClient(
        name: "Global Ime Bank",
        status: "NotRegistered",
      ),
      HrClient(
          name: "Technomax",
          status: "Registered",
          baseUrl: "https://api.technomax.com.np/"),
    ];
  }

  void selectOrganisation(int index) {
    _selectedClient = _clients.elementAt(index);
  }
}
