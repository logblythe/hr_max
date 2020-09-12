import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_material.dart';

class LearningMaterialViewModel extends BaseViewModel {
  final LearningService _learningService = locator<LearningService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<LearningMaterial> get materials => _learningService.materials;

  LearningMaterial get selectedMaterial => _learningService.selectedMaterial;

  fetchLearningMaterials() async {
    try {
      setLoading();
      await _learningService.fetchMaterials();
      setCompleted();
    } catch (e) {
      setError(e);
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  selectMaterial(LearningMaterial material) {
    _learningService.selectMaterial(material);
    _navigationService.navigateTo(Routes.MaterialViewerRoute);
  }
}
