import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/button.dart';

class Settings {
  bool allowBack;
  bool allowFirst;
  bool allowLast;
  bool allowReview;
  bool allowSubmit;
  bool isAnswerMandatory;
  bool questionTimer;
  bool showResult;
  bool showCorrectAnswer;
  bool enableAutoClose;
  bool enableReviewDialog;

  Settings({
    this.allowBack,
    this.allowFirst,
    this.allowLast,
    this.allowReview,
    this.allowSubmit,
    this.isAnswerMandatory,
    this.questionTimer,
    this.showResult,
    this.showCorrectAnswer,
    this.enableAutoClose,
    this.enableReviewDialog,
  });

  Settings.init()
      : allowBack = true,
        allowFirst = true,
        allowLast = true,
        allowReview = true,
        allowSubmit = true,
        isAnswerMandatory = true,
        questionTimer = true,
        showResult = true,
        showCorrectAnswer = true,
        enableAutoClose = true,
        enableReviewDialog = true;
}

class SettingsDialog extends StatefulWidget {
  final Function(Settings) onSave;
  final Settings settings;

  const SettingsDialog({Key key, this.onSave, this.settings}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool mandatory;
  bool back;
  bool first;
  bool last;
  bool submit;
  bool review;
  bool timer;
  bool result;
  bool correctAnswer;
  bool enableAutoClose;
  bool enableReviewDialog;

  @override
  void initState() {
    super.initState();
    mandatory = widget.settings.isAnswerMandatory;
    back = widget.settings.allowBack;
    first = widget.settings.allowFirst;
    last = widget.settings.allowLast;
    submit = widget.settings.allowSubmit;
    review = widget.settings.allowReview;
    timer = widget.settings.questionTimer;
    result = widget.settings.showResult;
    correctAnswer = widget.settings.showCorrectAnswer;
    enableAutoClose = widget.settings.enableAutoClose;
    enableReviewDialog = widget.settings.enableReviewDialog;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CheckboxListTile(
            value: mandatory,
            title: Text("Mandatory questions"),
            onChanged: (value) {
              setState(() {
                mandatory = value;
              });
            },
          ),
          CheckboxListTile(
            value: back,
            title: Text("Show back"),
            onChanged: (value) {
              setState(() {
                back = value;
              });
            },
          ),
          CheckboxListTile(
            value: first,
            title: Text("Show first"),
            onChanged: (value) {
              setState(() {
                first = value;
              });
            },
          ),
          CheckboxListTile(
            value: last,
            title: Text("Show last"),
            onChanged: (value) {
              setState(() {
                last = value;
              });
            },
          ),
          CheckboxListTile(
            value: review,
            title: Text("Show review"),
            onChanged: (value) {
              setState(() {
                review = value;
              });
            },
          ),
          CheckboxListTile(
            value: submit,
            title: Text("Show submit"),
            onChanged: (value) {
              setState(() {
                submit = value;
              });
            },
          ),
          CheckboxListTile(
            value: timer,
            title: Text("10 sec per question"),
            onChanged: (value) {
              setState(() {
                timer = value;
              });
            },
          ),
          CheckboxListTile(
            value: result,
            title: Text("Show result"),
            onChanged: (value) {
              setState(() {
                result = value;
              });
            },
          ),
          CheckboxListTile(
            value: correctAnswer,
            title: Text("Show correct answer"),
            onChanged: (value) {
              setState(() {
                correctAnswer = value;
              });
            },
          ),
          CheckboxListTile(
            value: enableAutoClose,
            title: Text("enableAutoClose"),
            onChanged: (value) {
              setState(() {
                enableAutoClose = value;
              });
            },
          ),
          CheckboxListTile(
            value: enableReviewDialog,
            title: Text("enableReviewDialog"),
            onChanged: (value) {
              setState(() {
                enableReviewDialog = value;
              });
            },
          ),
          Button(
            label: "Save",
            onPressed: () {
              widget.onSave(Settings(
                allowBack: back,
                allowFirst: first,
                allowLast: last,
                allowReview: review,
                allowSubmit: submit,
                isAnswerMandatory: mandatory,
                questionTimer: timer,
                showResult: result,
                showCorrectAnswer: correctAnswer,
                enableAutoClose: enableAutoClose,
                enableReviewDialog: enableReviewDialog,
              ));
              Navigator.of(context).pop();
            },
          ),
          UIHelper.verticalSpaceMedium,
        ],
      ),
    );
  }
}
