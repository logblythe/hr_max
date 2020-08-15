import 'package:hrmax/network/models/quiz.dart';
import 'package:hrmax/network/models/config.dart';
import 'package:hrmax/network/models/employee_detail.dart';
import 'package:hrmax/network/models/question.dart';

class QuestionResponse {
	static const SINGLE_SELECT = "Multiple Choice";
	static const MULTI_SELECT = "Multiple Choice - Multiple Answer";
  int totalQuestionsInExam;
  String eLearningEmailID;
  String eLearningContactPoint;
  String baseUrl;
  int idTracker;
  double score;
  String instruction;
  Quiz quiz;
  Config config;
  bool autoClose;
  bool readingMaterialExist;
  EmployeeDetail employeeDetail;
  List<Question> questions;
  Object questionsAnswered;
  List<Object> materials;
  List<Object> materialsEditable;
  Object trackerQuestionResult;
  bool enableReview;
  bool enableShowResult;
  bool enableShowCorrectAnswer;

  QuestionResponse.fromJsonMap(Map<String, dynamic> map)
      : totalQuestionsInExam = map["totalQuestionsInExam"],
        eLearningEmailID = map["eLearningEmailID"],
        eLearningContactPoint = map["eLearningContactPoint"],
        baseUrl = map["baseUrl"],
        idTracker = map["IdTracker"],
        score = map["score"],
        instruction = map["instruction"],
        quiz = Quiz.fromJsonMap(map["quiz"]),
        config = Config.fromJsonMap(map["config"]),
        autoClose = map["autoClose"],
        readingMaterialExist = map["readingMaterialExist"],
        employeeDetail = EmployeeDetail.fromJsonMap(map["employeeDetail"]),
        questions = List<Question>.from(
            map["questions"].map((it) => Question.fromJsonMap(it))),
        questionsAnswered = map["questionsAnswered"],
        materials = map["materials"],
        materialsEditable = map["materialsEditable"],
        trackerQuestionResult = map["trackerQuestionResult"],
        enableReview = map["enableReview"],
        enableShowResult = map["enableShowResult"],
        enableShowCorrectAnswer = map["enableShowCorrectAnswer"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQuestionsInExam'] = totalQuestionsInExam;
    data['eLearningEmailID'] = eLearningEmailID;
    data['eLearningContactPoint'] = eLearningContactPoint;
    data['baseUrl'] = baseUrl;
    data['IdTracker'] = idTracker;
    data['score'] = score;
    data['instruction'] = instruction;
    data['quiz'] = quiz == null ? null : quiz.toJson();
    data['config'] = config == null ? null : config.toJson();
    data['autoClose'] = autoClose;
    data['readingMaterialExist'] = readingMaterialExist;
    data['employeeDetail'] =
        employeeDetail == null ? null : employeeDetail.toJson();
    data['questions'] = questions != null
        ? this.questions.map((v) => v.toJson()).toList()
        : null;
    data['questionsAnswered'] = questionsAnswered;
    data['materials'] = materials;
    data['materialsEditable'] = materialsEditable;
    data['trackerQuestionResult'] = trackerQuestionResult;
    data['enableReview'] = enableReview;
    data['enableShowResult'] = enableShowResult;
    data['enableShowCorrectAnswer'] = enableShowCorrectAnswer;
    return data;
  }
}
