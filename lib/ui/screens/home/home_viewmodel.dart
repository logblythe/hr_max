import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/login_res.dart';

class HomeViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _storageService = locator<StorageService>();

  LoginRes get loginRes => _userService.loginModel;

  handleShowProfile() {
    _navigationService.navigateTo(Routes.ProfileRoute);
  }

  handleLogout() {
    _storageService.deleteAll();
    _navigationService.popAllAndNavigateTo(Routes.LoginRoute);
  }

  handleElearning() {
    _navigationService.navigateTo(Routes.LearningDashRoute);
  }
}
