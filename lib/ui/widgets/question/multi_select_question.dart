import 'package:flutter/material.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/ui/screens/question/widgets/question_timer.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/utils.dart';

class MultiSelectQuestion extends StatefulWidget {
  final Question question;
  final int questionDuration;
  final Function(int, List<Option>) onAnswered;
  final Function(int) onQuestionTimerExpired;
  final bool showResult;
  final bool showCorrectAnswer;
  final List<Option> selectedOption;

  const MultiSelectQuestion({
    Key key,
    this.question,
    this.onAnswered,
    this.questionDuration,
    this.onQuestionTimerExpired,
    this.showResult = false,
    this.showCorrectAnswer = false,
    this.selectedOption,
  }) : super(key: key);

  @override
  _MultiSelectQuestionState createState() => _MultiSelectQuestionState();
}

class _MultiSelectQuestionState extends State<MultiSelectQuestion>
    with AutomaticKeepAliveClientMixin {
  Map<int, bool> selectedAnswers = {};
  bool _questionTimerExpired = false;
  bool _correct = false;

  @override
  void initState() {
    super.initState();
    widget.question.options.forEach((option) {
      if (widget.selectedOption != null) {
        if (widget.selectedOption
            .map((e) => e.id)
            .toList()
            .contains(option.id)) {
          selectedAnswers[option.id] = true;
        } else {
          selectedAnswers[option.id] = false;
        }

        List<int> correctAnswers = widget.question.correctAnswer;
        List<int> answers = widget.selectedOption.map((e) => e.id).toList();
        if (areListsEqual(correctAnswers,answers)) {
          setState(() {
            _correct=true;
          });
        }
      } else {
        selectedAnswers[option.id] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                widget.question.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Expanded(
              child: IgnorePointer(
                ignoring: widget.showCorrectAnswer ||
                    (widget.questionDuration != null && _questionTimerExpired),
                child: ListView(
                  children: widget.question.options
                      .map(
                        (option) => Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withAlpha(25)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: selectedAnswers[option.id],
                                onChanged: (selected) {
                                  handleCheckValueChange(selected, option.id);
                                },
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () => handleCheckValueChange(
                                        !selectedAnswers[option.id], option.id),
                                    child: Text(option.name)),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            widget.showCorrectAnswer
                ? Container(
                    margin: EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, -1),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Correct answers are",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        UIHelper.verticalSpaceSmall,
                         Text(
                          getQuestionByAnswerIndex(0),
                          style: TextStyle(fontSize: 12),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Text(
                          getQuestionByAnswerIndex(1),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
        widget.showResult
            ? Positioned(
                right: 4,
                top: 4,
                child: Icon(
                  _correct ? Icons.check_circle : Icons.error,
                  size: 32,
                  color: _correct ? Colors.green[700] : Colors.red,
                ),
              )
            : Container(),
        widget.questionDuration != null
            ? Positioned(
          right: 4,
          top: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: QuestionTimer(
              duration: Duration(seconds: widget.questionDuration ?? 10),
              onExpired: () {
                setState(() {
                  _questionTimerExpired = true;
                });
                widget.onQuestionTimerExpired(widget.question.id);
              },
            ),
          ),
        )
            : Container(),
      ],
    );
  }

  String getQuestionByAnswerIndex(int index) {
    return widget.question.options.firstWhere((element) {
      return element.id == widget.question.correctAnswer.elementAt(index);
    }).name;
  }

  void handleCheckValueChange(bool selected, int id) {
    var ss = setState(() {
      selectedAnswers.forEach((key, value) {
        if (key == id && value != selected) {
          selectedAnswers[key] = selected;
        }
      });
    });
    List<Option> selectedOptions = [];
    widget.question.options.forEach((option) {
      if (selectedAnswers[option.id]) {
        selectedOptions.add(option);
      }
    });
    widget.onAnswered(widget.question.id, selectedOptions);
  }

  @override
  bool get wantKeepAlive => true;
}
