import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/instructions/instructions_viewmodel.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<InstructionsViewmodel>(
      model: InstructionsViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(title: Text(model.tracker.courseName)),
            body: Html(data: model.tracker.instruction));
      },
    );
  }
}
