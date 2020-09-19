import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';

class ExamsViewModel extends BaseViewModel {
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  List<LearningTrackerRes> get learningTrackers =>
      _learningService.learningTrackers;

  getLearningTrackers() async {
    try {
      setLoading();
      await _learningService.fetchTracker(
          userId: _userService.loginModel.idUser);
      setCompleted();
    } catch (e) {
      setError(e);
    }
  }

  handleViewMaterials(LearningTrackerRes learningTracker) {
    _learningService.setSelectedTracker(learningTracker);
    _navigationService.navigateTo(Routes.MaterialsRoute);
  }

  handleProceed(LearningTrackerRes learningTracker) async {
    if (learningTracker.attemptCount == 0) {
      showToast('Maximum available attempt count completed');
    } else {
      _learningService.setSelectedTracker(learningTracker);
      await _navigationService.navigateTo(Routes.QuestionRoute);
      getLearningTrackers();
    }
  }
}
