import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_material.dart';
import 'package:hrmax/network/models/material_file.dart';

class LearningMaterialViewModel extends BaseViewModel {
  final LearningService _learningService = locator<LearningService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<LearningMaterial> get materials => _learningService.materials;

  LearningMaterial get selectedMaterial => _learningService.selectedMaterial;

  MaterialFile get selectedFile => _learningService.selectedFile;

  fetchLearningMaterials() async {
    try {
      setLoading();
      await _learningService.fetchMaterials(
          courseId: _learningService.selectedTracker.idHRCourse);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  selectMaterial(LearningMaterial material) {
    _learningService.selectMaterial(material);
    _navigationService.navigateTo(Routes.MaterialViewerRoute);
  }

  @override
  void dispose() {
    _learningService.selectMaterial(null);
    _learningService.setSelectedFile(null);
    super.dispose();
  }
}
