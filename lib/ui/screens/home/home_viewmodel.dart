import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class HomeViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<StorageService>();

  void handleLogout() {
    _storageService.deleteAll();
    _navigationService.navigateTo(Routes.LoginRoute);
  }

  handleElearning() {
    _navigationService.navigateTo(Routes.LearningDashRoute);
  }
}
