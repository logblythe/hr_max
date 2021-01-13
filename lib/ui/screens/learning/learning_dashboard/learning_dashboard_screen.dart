import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/learning_dashboard/learning_view_model.dart';
import 'package:hrmax/ui/screens/learning/learning_dashboard/pie_chart_slider.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
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
        _model.init();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          UIHelper.verticalSpaceMedium,
          Row(
            children: <Widget>[
              Expanded(
                child: CountBoxWidget(
                  onPressed: _model.navigateToExams,
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
                  text: "Not Attempted",
                  imagePath: ImagePath.LEARNING,
                ),
              )
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                child: CountBoxWidget(
                  onPressed: _model.navigateToExams,
                  count:
                      _model.loading ? 0 : _model.learningCount.totalLearning,
                  text: "Total",
                  imagePath: ImagePath.LEARNING,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: CountBoxWidget(
                  onPressed: _model.navigateToExams,
                  count: _model.loading ? 0 : _model.learningCount.totalAverage,
                  text: "Average",
                  imagePath: ImagePath.LEARNING,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _model.loading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(child: PieChartSlider(_model.monthWiseStats))
              ],
            ),
          )
        ],
      ),
    );
  }
}
