import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/material_folder.dart';

class FolderViewmodel extends BaseViewModel {
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  List<MaterialFolder> get materialFolders => _learningService.folders;

  fetchFolders() async {
    setLoading();
    try {
      await _learningService
          .fetchMaterialFolder(_userService.loginModel.idUser);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  selectFolder(MaterialFolder folder) {
    _learningService.setSelectedFolder(folder);
    _navigationService.navigateTo(Routes.FilesRoute);
  }
}
