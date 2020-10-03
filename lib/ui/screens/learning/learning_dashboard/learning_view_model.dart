import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_count.dart';
import 'package:hrmax/network/models/month_wise_stat_res.dart';

class LearningViewModel extends BaseViewModel {
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  LearningCount get learningCount => _learningService.learningCount;

  MonthWiseStatResponse get monthWiseStats => _learningService.monthWiseStat;

  fetchLearningStats() async {
    setLoading();
    try {
      await _learningService.fetchLearningStats(_userService.loginModel.idUser);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  fetchMonthWiseStats() async {
    setLoading();
    try {
      await _learningService
          .fetchMonthWiseStats(_userService.loginModel.idUser);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  navigateToExams() {
    _navigationService.navigateTo(Routes.ExamRoute);
  }
}