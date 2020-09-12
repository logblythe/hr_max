import 'package:flutter/material.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/network/models/learning_material.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LearningService {
  final ApiService _apiService;

  LearningService({@required ApiService apiService}) : _apiService = apiService;

  List<LearningTrackerRes> _learningTrackers;
  LearningTrackerRes _selectedTracker;
  List<LearningMaterial> _learningMaterials;
  LearningMaterial _selectedMaterial;
  QuestionResponse _questionResponse;
  Map<int, List<Option>> _answersMap = {};
  bool _submitted = false;

  List<LearningTrackerRes> get learningTrackers => _learningTrackers;

  LearningTrackerRes get selectedTracker => _selectedTracker;

  List<LearningMaterial> get materials => _learningMaterials;

  LearningMaterial get selectedMaterial => _selectedMaterial;

  QuestionResponse get questionResponse => _questionResponse;

  bool get submitted => _submitted;

  Map<int, List<Option>> get answersMap => _answersMap;

  setSelectedTracker(LearningTrackerRes learningTracker) {
    _selectedTracker = learningTracker;
  }

  selectMaterial(LearningMaterial material) {
    _selectedMaterial = material;
  }

  setAnswers(Map<int, List<Option>> answersMap) {
    _answersMap = answersMap;
  }

  fetchTracker() => _apiService
      .get("/eLearning/getELearningTracker?paramSessionUserId=1")
      .then((value) => _learningTrackers =
          List.from(value.map((e) => LearningTrackerRes.fromJsonMap(e))));

  fetchMaterials() => _apiService
      .get("/eLearning/getELearningMaterials?idCourse=7")
      .then((value) => _learningMaterials =
          List.from(value.map((e) => LearningMaterial.fromJsonMap(e))));

  fetchQuestions() => _apiService
      .get("/eLearning/getELearningQuestions?idTracker=10002")
      .then((value) => _questionResponse = QuestionResponse.fromJsonMap(value));

  submitQuestions(params) => _apiService
      .post("/eLearning/submitELearning", params: params)
      .then((value) => _submitted = true);
}
