import 'package:flutter/material.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/ui/screens/question/widgets/question_timer.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class SingleSelectQuestion extends StatefulWidget {
  final Question question;
  final int questionDuration;
  final Function(int, List<Option>) onAnswered;
  final Function(int) onQuestionTimerExpired;
  final bool showResult;
  final bool showCorrectAnswer;
  final List<Option> selectedOption;

  const SingleSelectQuestion({
    Key key,
    this.question,
    this.onAnswered,
    this.onQuestionTimerExpired,
    this.questionDuration,
    this.showCorrectAnswer = false,
    this.selectedOption,
    this.showResult = false,
  }) : super(key: key);

  @override
  _SingleSelectQuestionState createState() => _SingleSelectQuestionState();
}

class _SingleSelectQuestionState extends State<SingleSelectQuestion>
    with AutomaticKeepAliveClientMixin {
  int _groupValue;
  bool _questionTimerExpired = false;
  List<Option> _options;
  bool _correct = false;
  int _expireTime;

  @override
  void initState() {
    _expireTime = widget.questionDuration;
    _options = widget.selectedOption;
    if (_options != null) {
      if (_options.length > 0) {
        if (_options.elementAt(0).id ==
            widget.question.correctAnswer
                .where((option) => option.isAnswer)
                .map((option) => option.id)
                .elementAt(0)) {
          setState(() {
            _correct = true;
          });
        }
        setState(() {
          _groupValue = _options.elementAt(0).id;
        });
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(SingleSelectQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _expireTime = widget.questionDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    widget.questionDuration != null &&
                            widget.questionDuration > 0
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: QuestionTimer(
                              duration: Duration(seconds: _expireTime),
                              onExpired: () {
                                setState(() => _questionTimerExpired = true);
                                widget
                                    .onQuestionTimerExpired(widget.question.id);
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                      child: Text(
                        widget.question.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: widget.question.options
                          .map(
                            (option) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withAlpha(25)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IgnorePointer(
                                ignoring: widget.showCorrectAnswer ||
                                    (widget.questionDuration != null &&
                                        _questionTimerExpired),
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      value: option.id,
                                      groupValue: _groupValue,
                                      onChanged: (value) =>
                                          _handleRadioValueChange(
                                        option,
                                        value: value,
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () =>
                                            _handleRadioValueChange(option),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.all(16.0),
                                          child: Text(option.name),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
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
                          "Correct Answer is",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Divider(height: 5, color: Colors.grey),
                        UIHelper.verticalSpaceSmall,
                        Text(
                          getCorrectAnswer(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )
                : Container()
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
  bool get wantKeepAlive => false;

  String getCorrectAnswer() {
    return widget.question.options
        .firstWhere((it) =>
            it.id ==
            widget.question.correctAnswer
                .where((option) => option.isAnswer)
                .map((option) => option.id)
                .elementAt(0))
        .name;
  }
}
