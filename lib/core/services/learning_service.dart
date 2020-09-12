import 'package:flutter/material.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/network/models/learning_material.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LearningService {
  final ApiService _apiService;

  LearningService({@required ApiService apiService}) : _apiService = apiService;

  List<LearningTrackerRes> _learningTrackers;
  LearningTrackerRes _selectedTracker;
  List<LearningMaterial> _learningMaterials;
  LearningMaterial _selectedMaterial;

  List<LearningTrackerRes> get learningTrackers => _learningTrackers;

  LearningTrackerRes get selectedTracker => _selectedTracker;

  List<LearningMaterial> get materials => _learningMaterials;

  LearningMaterial get selectedMaterial => _selectedMaterial;

  fetchLearningTracker() => _apiService
      .get("/eLearning/getELearningTracker?paramSessionUserId=1")
      .then((value) => _learningTrackers =
          List.from(value.map((e) => LearningTrackerRes.fromJsonMap(e))));

  fetchLearningMaterials() => _apiService
      .get("/eLearning/getELearningMaterials?idCourse=7")
      .then((value) => _learningMaterials =
          List.from(value.map((e) => LearningMaterial.fromJsonMap(e))));

  getLearningQuestions() => _apiService
      .get("/eLearning/getELearningQuestions")
      .then((value) => _learningTrackers =
          List.from(value.map((e) => LearningTrackerRes.fromJsonMap(e))));

  setSelectedTracker(LearningTrackerRes learningTracker) {
    _selectedTracker = learningTracker;
  }

  selectMaterial(LearningMaterial material) {
    _selectedMaterial = material;
  }
}
