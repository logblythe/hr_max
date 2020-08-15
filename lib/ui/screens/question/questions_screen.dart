import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/widgets/button.dart';
import 'package:hrmax/ui/widgets/question/multi_select_question.dart';
import 'package:hrmax/ui/widgets/question/single_select_question.dart';
import 'package:hrmax/ui/widgets/timer.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  QuestionResponse response;
  int _initialPage = 0;
  PageController _controller;
  Map<int, dynamic> answersMap = {};
  Map<int, bool> timerMap = {};

  loadAsset() async {
    var result = await rootBundle.loadString('assets/response.json');
    setState(() => response = QuestionResponse.fromJsonMap(jsonDecode(result)));
  }

  @override
  void initState() {
    _controller = PageController(initialPage: _initialPage);
    loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TimerWidget(
                duration: Duration(minutes: 12),
                warningDuration: Duration(minutes: 2),
                initialText: "Time remaining",
                onExpiredText: "Time is up",
                onExpired: _handleQuizTimerExpired,
                textStyle: TextStyle(color: Colors.black),
                warningTextStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
          )
        ],
      ),
      body: response == null
          ? Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) => Container(
                color: Colors.grey.withAlpha(25),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Stack(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              onPageChanged: _handlePageChange,
                              children: response.questions.map((question) {
                                answersMap[question.id] = [];
                                if (question.questionTypeId ==
                                    QuestionResponse.SINGLE_SELECT) {
                                  return SingleSelectQuestion(
                                    question: question,
                                    onAnswered: _handleAnswered,
                                    onQuestionTimerExpired:
                                        _handleQuestionTimeExpired,
                                  );
                                } else {
                                  return MultiSelectQuestion(
                                    question: question,
                                    onAnswered: _handleAnswered,
                                    onQuestionTimerExpired:
                                        _handleQuestionTimeExpired,
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    '${_initialPage + 1}/${response.questions.length}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Button(
                                        label: Prev,
                                        onPressed: () => _handlePrev(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Button(
                                        label: _initialPage + 1 !=
                                                response.questions.length
                                            ? Next
                                            : Submit,
                                        onPressed: () => _handleNext(context),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  mini: true,
                                  child: Icon(
                                    Icons.skip_previous,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  onPressed: () => _handleFirst(),
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  mini: true,
                                  child: Icon(
                                    Icons.skip_next,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  onPressed: () => _handleLast(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _handleAnswered(int questionId, dynamic answers) {
    answersMap[questionId] = answers;
  }

  void _handlePageChange(int current) => _initialPage = current;

  void _handlePrev() {
    if (_initialPage > 0) {
      setState(() => _initialPage = _initialPage - 1);
      _controller.animateToPage(
        _initialPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    }
  }

  void _handleNext(context) {
    List<Question> _questions = response.questions;
    bool _lastPageReached = _initialPage < _questions.length - 1;
    bool _timeUp = timerMap[_questions[_initialPage].id] ?? false;
    bool _answered = false;
    if (isSingleSelect() &&
        answersMap[_questions[_initialPage].id].length == 1) {
      _answered = true;
    } else if (isMultiSelect() &&
        answersMap[_questions[_initialPage].id].length >= 2) {
      _answered = true;
    }
//      answersMap.containsKey(_questions[_initialPage].id);
    if (_timeUp) {
      if (_lastPageReached) {
        setState(() => _initialPage = _initialPage + 1);
        _controller.animateToPage(
          _initialPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      }
    } else if (_answered) {
      if (_lastPageReached) {
        setState(() => _initialPage = _initialPage + 1);
        _controller.animateToPage(
          _initialPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Ready to submit")),
        );
      }
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(isSingleSelect()
              ? "Please select one answer"
              : isMultiSelect()
                  ? "Please select two or more answers"
                  : "Please select answer"),
        ),
      );
    }
  }

  _handleFirst() {
    setState(() => _initialPage = 0);
    _controller.animateToPage(
      _initialPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

  _handleLast() {
    setState(() => _initialPage = response.questions.length - 1);
    _controller.animateToPage(
      _initialPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

  _handleQuizTimerExpired() {}

  _handleQuestionTimeExpired(int quesId) {
    timerMap[quesId] = true;
  }

  isSingleSelect() {
    return response.questions[_initialPage].questionTypeId ==
        QuestionResponse.SINGLE_SELECT;
  }

  isMultiSelect() {
    bool isMulti=response.questions[_initialPage].questionTypeId ==
        QuestionResponse.MULTI_SELECT;
    return isMulti;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
