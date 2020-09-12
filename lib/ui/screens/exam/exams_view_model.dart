import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/api_exceptions.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';

class ExamsViewModel extends BaseViewModel {
  final LearningService _learningService = locator<LearningService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<LearningTrackerRes> get learningTrackers =>
      _learningService.learningTrackers;

  getLearningTrackers() async {
    try {
      setLoading();
      await _learningService.fetchLearningTracker();
      setCompleted();
      // _navigationService.replace(Routes.QuestionRoute);
    } catch (e) {
      setError(e);
      var error;
      if (e is AppException) {
        error = e.toJson()['Message'] ?? e.toJson()['message'];
      } else {
        error = e.toString();
      }
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

  handleViewMaterials(LearningTrackerRes learningTracker) {
    _learningService.setSelectedTracker(learningTracker);
    _navigationService.navigateTo(Routes.MaterialsRoute);
  }
}
