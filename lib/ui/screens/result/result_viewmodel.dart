import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/utils.dart';

class ResultViewmodel extends BaseViewModel {
  final _learningService = locator<LearningService>();
  String _percentage = "0";

  Map<int, List<Option>> get answersMap => _learningService.answersMap;

  List<Question> get questions => _learningService.questionResponse.questions;

  bool get showResult => _learningService.questionResponse.enableShowResult;

  bool get showCorrectAnswer =>
      _learningService.questionResponse.enableShowCorrectAnswer;

  bool get enableAutoClose =>
      _learningService.questionResponse.config.enableAutoClose;

  get percentage => _percentage;

  void calculatePercentage() {
    double _initialPercent = 0;
    double _increment = 100 / questions.length;
    for (int i = 0; i < questions.length; i++) {
      List<int> correctAnswers = questions[i]
          .correctAnswer
          .where((option) => option.isAnswer)
          .map((option) => option.id)
          .toList();
      List<int> answeredAnswers =
          answersMap.values.elementAt(i).map((e) => e.id).toList();
      bool correct = false;
      for (int i = 0; i < correctAnswers.length; i++) {
        if (areListsEqual(correctAnswers, answeredAnswers)) {
          correct = true;
        }
      }
      if (correct) {
        _initialPercent = _initialPercent + _increment;
      }
    }
    _percentage = _initialPercent.toStringAsFixed(2);
    notifyListeners();
  }
}
