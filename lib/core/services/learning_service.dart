import 'package:flutter/material.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/network/models/learning_count.dart';
import 'package:hrmax/network/models/learning_material.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LearningService {
  final ApiService _apiService;

  LearningService({@required ApiService apiService}) : _apiService = apiService;

  LearningCount _learningCount;
  List<LearningTrackerRes> _learningTrackers = [];
  LearningTrackerRes _selectedTracker;
  List<LearningMaterial> _learningMaterials;
  LearningMaterial _selectedMaterial;
  QuestionResponse _questionResponse;
  Map<int, List<Option>> _answersMap = {};
  String _submitResponse;

  LearningCount get learningCount => _learningCount;

  List<LearningTrackerRes> get learningTrackers => _learningTrackers;

  LearningTrackerRes get selectedTracker => _selectedTracker;

  List<LearningMaterial> get materials => _learningMaterials;

  LearningMaterial get selectedMaterial => _selectedMaterial;

  QuestionResponse get questionResponse => _questionResponse;

  String get submitResponse => _submitResponse;

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

  fetchTracker({int userId}) => _apiService
      .get("/eLearning/getELearningTracker?paramSessionUserId=$userId")
      .then((value) => _learningTrackers =
          List.from(value.map((e) => LearningTrackerRes.fromJsonMap(e))));

  fetchMaterials({int courseId}) => _apiService
      .get("/eLearning/getELearningMaterials?idCourse=$courseId")
      .then((value) => _learningMaterials =
          List.from(value.map((e) => LearningMaterial.fromJsonMap(e))));

  fetchQuestions({int idTracker}) => _apiService
      .get("/eLearning/getELearningQuestions?idTracker=$idTracker")
      .then((value) => _questionResponse = QuestionResponse.fromJsonMap(value));

  submitQuestions(params) => _apiService
          .post("/eLearning/submitELearning", params: params)
          .then((value) {
        _submitResponse = value;
      });

  fetchLearningStats(int userId) => _apiService
          .get('/eLearning/getELearningCount?paramSessionUserId=$userId')
          .then((value) {
        _learningCount = LearningCount.fromJsonMap(value);
      });
}
