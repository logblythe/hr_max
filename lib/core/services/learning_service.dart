import 'package:flutter/material.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/network/models/files_response.dart';
import 'package:hrmax/network/models/learning_count.dart';
import 'package:hrmax/network/models/learning_material.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/network/models/material_file.dart';
import 'package:hrmax/network/models/material_folder.dart';
import 'package:hrmax/network/models/month_wise_stat_res.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LearningService {
  final ApiService _apiService;

  LearningService({@required ApiService apiService}) : _apiService = apiService;

  Map<int, List<Option>> _answersMap = {};
  LearningCount _learningCount;
  List<LearningTrackerRes> _learningTrackers = [];
  List<LearningMaterial> _learningMaterials;
  FilesResponse _filesResponse;
  List<MaterialFolder> _folders;
  List<MaterialFile> _files;
  LearningMaterial _selectedMaterial;
  LearningTrackerRes _selectedTracker;
  MaterialFolder _selectedFolder;
  MaterialFile _selectedFile;
  MonthWiseStatResponse _monthWiseStatResponse;
  QuestionResponse _questionResponse;

  String _submitResponse;

  List<MaterialFolder> get folders => _folders;

  LearningCount get learningCount => _learningCount;

  List<LearningTrackerRes> get learningTrackers => _learningTrackers;

  LearningTrackerRes get selectedTracker => _selectedTracker;

  List<LearningMaterial> get materials => _learningMaterials;

  LearningMaterial get selectedMaterial => _selectedMaterial;

  QuestionResponse get questionResponse => _questionResponse;

  String get submitResponse => _submitResponse;

  Map<int, List<Option>> get answersMap => _answersMap;

  MaterialFolder get selectedFolder => _selectedFolder;

  MaterialFile get selectedFile => _selectedFile;

  List<MaterialFile> get files => _files;

  MonthWiseStatResponse get monthWiseStat => _monthWiseStatResponse;

  setSelectedFile(MaterialFile file) {
    _selectedFile = file;
  }

  setSelectedFolder(MaterialFolder folder) {
    _selectedFolder = folder;
  }

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
      .then((value) {
    _learningTrackers =
        List.from(value.map((e) => LearningTrackerRes.fromJsonMap(e)));
  });

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

  fetchMonthWiseStats(int userId) => _apiService
          .get(
              '/eLearning/getAssignedCoursesByMonth?paramSessionUserId=$userId')
          .then((value) {
        _monthWiseStatResponse = MonthWiseStatResponse.fromJsonMap(value);
      });

  fetchMaterialFolder(int userId) => _apiService
          .get('/Circular/getFolder?paramSessionUserId=$userId')
          .then((value) {
        _folders = List.from(value.map((e) => MaterialFolder.fromJsonMap(e)));
      });

  fetchMaterialFiles(int folderId, int userId) => _apiService
          .get(
              '/Circular/getFile?paramIdFolder=$folderId&&paramSessionUserId=$userId')
          .then((value) {
        _filesResponse = FilesResponse.fromJsonMap(value);
        _folders = _filesResponse.folders;
        _files = _filesResponse.files;
      });

  downloadCertificate(String fullName) => _apiService.downloadCertificate(
      '/eLearning/generateCertificate?idTracker=${selectedTracker.idELearningTracker}&idTrackerHistory=${selectedTracker.idTrackerHistory}&loginName=$fullName',
      selectedTracker.idELearningTracker,
      selectedTracker.idTrackerHistory);
}
