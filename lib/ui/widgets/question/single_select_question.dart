import 'package:flutter/material.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/ui/screens/question/widgets/question_timer.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class SingleSelectQuestion extends StatefulWidget {
  final Question question;
  final int questionDuration;
  final Function(int, List<Option>) onAnswered;
  final Function(int) onQuestionTimerExpired;

  const SingleSelectQuestion({
    Key key,
    this.question,
    this.onAnswered,
    this.onQuestionTimerExpired,
    this.questionDuration,
  }) : super(key: key);

  @override
  _SingleSelectQuestionState createState() => _SingleSelectQuestionState();
}

class _SingleSelectQuestionState extends State<SingleSelectQuestion>
    with AutomaticKeepAliveClientMixin {
  int _groupValue;
  bool _questionTimerExpired = false;

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
                              Radio(
                                value: option.id,
                                groupValue: _groupValue,
                                onChanged: (value) => _handleRadioValueChange(
                                  option,
                                  value: value,
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => _handleRadioValueChange(option),
                                  child: Text(option.name),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
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

  void _handleRadioValueChange(Option selectedOption, {int value}) {
    widget.onAnswered(widget.question.id, [selectedOption]);
    if (value == null) {
      for (Option option in widget.question.options) {
        if (option.id == selectedOption.id) {
          value = option.id;
        }
      }
    }
    setState(() {
      _groupValue = value;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
