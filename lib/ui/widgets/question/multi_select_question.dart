import 'package:flutter/material.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/ui/screens/question/widgets/question_timer.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class MultiSelectQuestion extends StatefulWidget {
  final Question question;
  final int questionDuration;
  final Function(int, List<Option>) onAnswered;
  final Function(int) onQuestionTimerExpired;

  const MultiSelectQuestion(
      {Key key,
      this.question,
      this.onAnswered,
      this.questionDuration,
      this.onQuestionTimerExpired})
      : super(key: key);

  @override
  _MultiSelectQuestionState createState() => _MultiSelectQuestionState();
}

class _MultiSelectQuestionState extends State<MultiSelectQuestion>
    with AutomaticKeepAliveClientMixin {
  Map<int, bool> selectedAnswers = {};
  bool _questionTimerExpired = false;

  @override
  void initState() {
    super.initState();
    widget.question.options.forEach((option) {
      //todo use this for loading the already answered questions
//      selectedAnswers[option.id] = option.isAnswer;
      selectedAnswers[option.id] = false;
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
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Expanded(
              child: IgnorePointer(
                ignoring: _questionTimerExpired,
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
                                    child: Text(widget.question.name)),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        widget.questionDuration != null
            ? Positioned(
                top: 0,
                right: 0,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  child: QuestionTimer(
                    duration: Duration(seconds: widget.questionDuration ?? 10),
                    onExpired: () {
                      setState(() {
                        _questionTimerExpired = true;
                      });
                      widget.onQuestionTimerExpired(widget.question.id);
                    },
                  ),
                  onPressed: null,
                ),
              )
            : Container()
      ],
    );
  }

  void handleCheckValueChange(bool selected, int id) {
    setState(() {
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
