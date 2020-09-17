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
      _navigationService.replace(Routes.HomeRoute);
      _userService.login({
        "username":await _storageService.get(KEY_EMAIL),
        "password":await _storageService.get(KEY_PASSWORD),
        "deviceId":await _storageService.get(KEY_DEVICE_ID)
      });
      
    } else {
      _navigationService.replace(Routes.LoginRoute);
    }
  }
}
