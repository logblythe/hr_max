import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/services/learning_service.dart';
import 'package:hrmax/core/view_models/base_view_model.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';

class InstructionsViewmodel extends BaseViewModel {
  final _learningService = locator<LearningService>();

  LearningTrackerRes get tracker => _learningService.selectedTracker;
}
