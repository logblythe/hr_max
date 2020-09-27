import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/material_file.dart';

class FilesViewmodel extends BaseViewModel {
  final _learningService = locator<LearningService>();

  List<MaterialFile> get files => _learningService.files;

  fetchFolders() async {
    setLoading();
    try {
      await _learningService
          .fetchMaterialFiles(_learningService.selectedFolder.IdFolder);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }
}
