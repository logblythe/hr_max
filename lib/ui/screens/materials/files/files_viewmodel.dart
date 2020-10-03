import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/material_file.dart';
import 'package:hrmax/network/models/material_folder.dart';

class FilesViewmodel extends BaseViewModel {
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  List<MaterialFile> get files => _learningService.files;

  MaterialFolder get selectedFolder => _learningService.selectedFolder;

  List<MaterialFolder> get materialFolders => _learningService.folders;

  fetchFiles() async {
    setLoading();
    try {
      await _learningService.fetchMaterialFiles(
          selectedFolder.idFolder, _userService.loginModel.idUser);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  selectFile(MaterialFile file) {
    _learningService.setSelectedFile(file);
    _navigationService.navigateTo(Routes.MaterialViewerRoute);
  }

  selectFolder(MaterialFolder folder) {
    _learningService.setSelectedFolder(folder);
    _navigationService.navigateTo(Routes.FilesRoute);
  }
}
