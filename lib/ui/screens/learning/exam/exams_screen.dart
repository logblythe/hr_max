import 'package:flutter/material.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/exam/exams_view_model.dart';
import 'package:hrmax/ui/screens/learning/exam/widgets/exam_card.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exams')),
      body: BaseWidget<ExamsViewModel>(
        model: ExamsViewModel(),
        onModelReady: (model) {
          model.getLearningTrackers();
        },
        builder: (context, model, child) {
          if (model.loading) {
            return Center(child: CircularProgressIndicator());
          }
          var learningTrackers = model.learningTrackers;
          return learningTrackers.length > 0
              ? Container(
                  color: Colors.grey.withAlpha(25),
                  child: ListView.builder(
                    itemCount: learningTrackers.length,
                    itemBuilder: (context, index) {
                      return ExamCard(
                        tracker: learningTrackers[index],
                        onProcess: () =>
                            model.handleProceed(learningTrackers[index]),
                        onInstructions: () =>
                            model.handleInstructions(learningTrackers[index]),
                        onViewMaterials: () =>
                            model.handleViewMaterials(learningTrackers[index]),
                      );
                    },
                  ),
                )
              : Container();
        },
      ),
    );
  }
}