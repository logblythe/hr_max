import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';

class LearningViewModel extends BaseViewModel {
  final LearningService _learningService = locator<LearningService>();


  fetchLearningTrackers() async {
    try {
      setLoading();
      await _learningService.fetchLearningTracker();
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



}
