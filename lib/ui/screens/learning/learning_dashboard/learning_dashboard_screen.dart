import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/learning_dashboard/learning_view_model.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/circle.dart';
import 'package:hrmax/ui/widgets/count_box_widget.dart';

class LearningDashboardScreen extends StatefulWidget {
  @override
  _LearningDashboardScreenState createState() =>
      _LearningDashboardScreenState();
}

class _LearningDashboardScreenState extends State<LearningDashboardScreen> {
  LearningViewModel _model;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LearningViewModel>(
      model: LearningViewModel(),
      onModelReady: (model) {
        _model = model;
        _model.fetchLearningStats();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(LEARNING_DASHBOARD)),
          body: _buildBody(),
        );
      },
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CountBoxWidget(
                  count:
                      _model.loading ? 0 : _model.learningCount.totalAttempted,
                  text: "Attempted",
                  imagePath: ImagePath.PROFILE,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: CountBoxWidget(
                  onPressed: _model.navigateToExams,
                  count: _model.loading ? 0 : _model.learningCount.totalPending,
                  text: PENDING,
                  imagePath: ImagePath.LEARNING,
                ),
              )
            ],
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: CountBoxWidget(
                  count:
                      _model.loading ? 0 : _model.learningCount.totalLearning,
                  text: "Total",
                  imagePath: ImagePath.LEARNING,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: CountBoxWidget(
                  count: _model.loading ? 0 : _model.learningCount.totalAverage,
                  text: "Average",
                  imagePath: ImagePath.LEARNING,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 24,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Circle(
                          size: 12,
                          margin: const EdgeInsets.only(right: 8),
                        ),
                        Text(
                          LEARNING,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
