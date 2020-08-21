import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/screens/exam/widgets/exam_card.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/button.dart';

class ExamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams'),
      ),
      body: Container(
        color: Colors.grey.withAlpha(25),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ExamCard(
                index: index,
                onProcess: () => handleProceedPress(index, context),
                onInstructions: () => handleInstructionPress(index, context));
          },
        ),
      ),
    );
  }

  handleProceedPress(int index, context) {
    Navigator.of(context).pushNamed(RoutePaths.QUESTIONS);
  }

  handleInstructionPress(int index, context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Basic Operation Level entry course",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                UIHelper.verticalSpaceMedium,
                Icon(
                  Icons.cloud_upload,
                  size: 96,
                  color: Theme.of(context).primaryColorLight,
                ),
                Text("Here we will render the html content we get from the api",
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).hintColor)),
                UIHelper.verticalSpaceLarge,
                Button(
                  label: Proceed,
                  onPressed: () {
                    Navigator.of(context).pop();
                    handleProceedPress(index, context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
