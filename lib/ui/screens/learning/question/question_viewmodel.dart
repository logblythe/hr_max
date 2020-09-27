import 'package:hrmax/app/dialog_response.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/dialog_service.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question_model.dart';

class QuestionViewmodel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();

  QuestionResponse get questionResponse => _learningService.questionResponse;

  bool get autoClose =>
      _learningService.questionResponse.config.enableAutoClose;

  fetchQuestions() async {
    try {
      setLoading();
      await _learningService.fetchQuestions(
          idTracker: _learningService.selectedTracker.idELearningTracker);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  void submit(Map<int, List<Option>> answersMap) async {
    if (questionResponse.config.allowReview ||
        !questionResponse.config.isAnswerMandatory) {
      int _answeredCount = 0;
      answersMap.forEach((key, value) {
        if (value.length != 0) {
          _answeredCount = _answeredCount + 1;
        }
      });
      DialogResponse result = await _dialogService.showDialog(
          title: "Confirm submission?",
          description:
              "You have answered $_answeredCount out of ${questionResponse.questions.length} questions. Are you sure you want to submit?",
          buttonTitleNegative: "Cancel",
          buttonTitlePositive: "Ok");
      if (result.confirmed) {
        showResult(answersMap);
      }
    } else {
      showResult(answersMap);
    }
  }

  void showResult(Map<int, List<Option>> answersMap) async {
    try {
      setLoading();
      _learningService.setAnswers(answersMap);
      StringBuffer _listToSubmit = StringBuffer();
      answersMap.forEach((questionId, options) {
        for (Option option in options) {
          _listToSubmit.write("$questionId:${option.id},");
        }
      });
      await _learningService.submitQuestions({
        "idELearningTracker":
            _learningService.selectedTracker.idELearningTracker.toString(),
        "questionAnsweredString": _listToSubmit.toString(),
      });
      setCompleted();
      //FIXME irrespective of autoclose flag, popping questions screen after viewing result
      /*if (autoClose) {
        _navigationService.replace(Routes.ResultRoute);
      } else {
        _navigationService.navigateTo(Routes.ResultRoute);
      }*/
      _navigationService.replace(Routes.ResultRoute);
    } catch (e) {
      setError(e);
    }
  }
}
