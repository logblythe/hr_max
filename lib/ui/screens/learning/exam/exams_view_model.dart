import 'package:hrmax/app/dialog_response.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/services/dialog_service.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/core/services/permission_service.dart';
import 'package:hrmax/core/services/user_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:permission_handler/permission_handler.dart';

class ExamsViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _learningService = locator<LearningService>();
  final _navigationService = locator<NavigationService>();
  final _permissionService = locator<PermissionService>();
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
    DialogResponse result = await _dialogService.showModal(
        title: "Confirm proceed?",
        description:
            "Are you sure you want to start ${learningTracker.courseName}?",
        buttonTitleNegative: "Cancel",
        buttonTitlePositive: "Yes");
    if (result.confirmed) {
      _learningService.setSelectedTracker(learningTracker);
      await _navigationService.navigateTo(Routes.QuestionRoute);
      getLearningTrackers();
    }
  }

  handleInstructions(LearningTrackerRes learningTracker) {
    _learningService.setSelectedTracker(learningTracker);
    _navigationService.navigateTo(Routes.InstructionRoute);
  }

  handleDownloadCertificate(LearningTrackerRes learningTracker) {
    _learningService.setSelectedTracker(learningTracker);
    try {
      _permissionService
          .checkPermission(Permission.storage)
          .then((hasPermission) {
        print('hasPermission $hasPermission');
        if (hasPermission) {
          learningTracker.downloading = true;
          String name =
              _userService.loginModel.fullName.trim().split(" ").join("");
          _learningService.downloadCertificate(name);
          notifyListeners();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void onDownloadComplete() {
    showToast("Download Complete.");
    _learningService.selectedTracker.downloading = false;
    notifyListeners();
  }

  void onDownloadFailed() {
    showError("Something went wrong.");
    _learningService.selectedTracker.downloading = false;
    notifyListeners();
  }
}
