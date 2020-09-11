import 'package:flutter/material.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning_dashboard/learning_view_model.dart';
import 'package:hrmax/ui/screens/learning_dashboard/widgets/learning_analytics.dart';
import 'package:provider/provider.dart';

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
      model: LearningViewModel(navigationService: Provider.of(context)),
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

  _handlePendingClick() {
    Navigator.of(context).pushNamed(Routes.ExamRoute);
  }

//  handleAnalyticsClick(context) {
//    showGeneralDialog(
//        context: context,
//        barrierDismissible: true,
//        barrierLabel:
//            MaterialLocalizations.of(context).modalBarrierDismissLabel,
//        barrierColor: Colors.black54,
//        transitionBuilder: (context, a1, a2, widget) {
//          return Transform.scale(
//            scale: a1.value,
//            child: Opacity(
//              opacity: a1.value,
//              child: SafeArea(
//                child: Center(
//                  child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(20)),
//                      width: MediaQuery.of(context).size.width - 10,
//                      height: MediaQuery.of(context).size.height - 100,
//                      child: LearningAnalytics()),
//                ),
//              ),
//            ),
//          );
//        },
//        transitionDuration: const Duration(milliseconds: 200),
//        pageBuilder: (BuildContext buildContext, Animation animation,
//            Animation secondaryAnimation) {
//          return;
//        });
//  }

}
