import 'package:flutter/material.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning_dashboard/learning_view_model.dart';
import 'package:hrmax/ui/screens/learning_dashboard/widgets/learning_analytics.dart';

class LearningDashboardScreen extends StatefulWidget {
  @override
  _LearningDashboardScreenState createState() =>
      _LearningDashboardScreenState();
}

class _LearningDashboardScreenState extends State<LearningDashboardScreen> {
  LearningViewModel learningViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LearningViewModel>(
      model: LearningViewModel(),
      onModelReady: (model) => learningViewModel = model,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(LEARNING_DASHBOARD)),
          body: LearningAnalytics(
            onPendingClick: _handlePendingClick,
          ),
        );
      },
    );
  }

  _handlePendingClick() => Navigator.pushNamed(context, Routes.ExamRoute);
}
