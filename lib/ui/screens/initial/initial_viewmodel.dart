import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class InitialViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<StorageService>();

  init() async {
    if (await _storageService.get(KEY_TOKEN) != null) {
      _navigationService.replace(Routes.HomeRoute);
    } else {
      _navigationService.replace(Routes.LoginRoute);
    }
  }
}
