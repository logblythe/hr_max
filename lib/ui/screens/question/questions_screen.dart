import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/screens/question/widgets/review_dialog.dart';
import 'package:hrmax/ui/screens/question/widgets/settings_dialog.dart';
import 'package:hrmax/ui/widgets/button.dart';
import 'package:hrmax/ui/widgets/question/multi_select_question.dart';
import 'package:hrmax/ui/widgets/question/single_select_question.dart';
import 'package:hrmax/ui/widgets/timer.dart';

class Settings {
  bool allowBack;
  bool allowFirst;
  bool allowLast;
  bool allowReview;
  bool allowSubmit;
  bool isAnswerMandatory;
  bool questionTimer;

  Settings({
    this.allowBack,
    this.allowFirst,
    this.allowLast,
    this.allowReview,
    this.allowSubmit,
    this.isAnswerMandatory,
    this.questionTimer,
  });

  Settings.init()
      : allowBack = true,
        allowFirst = true,
        allowLast = true,
        allowReview = true,
        allowSubmit = true,
        isAnswerMandatory = true,
        questionTimer = true;
}

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  QuestionResponse response;
  int _initialPage = 0;
  PageController _controller;
  Map<int, List<Option>> answersMap = {};
  Map<int, bool> timerMap = {};
  Settings _settings = Settings.init();

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: <Widget>[
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TimerWidget(
                    duration: Duration(minutes: 12),
                    warningDuration: Duration(minutes: 2),
                    initialText: "",
                    onExpiredText: "Time is up",
                    onExpired: () => _handleQuizTimerExpired(context),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    warningTextStyle: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.scatter_plot),
                onPressed: _handleOptionsPress,
              )
            ],
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
                                if (answersMap[question.id] == null) {
                                  answersMap[question.id] = [];
                                }
                                if (question.questionTypeId ==
                                    QuestionResponse.SINGLE_SELECT) {
                                  return SingleSelectQuestion(
                                    question: question,
                                    onAnswered: _handleAnswered,
                                    questionDuration:
                                        _settings.questionTimer ? 10 : null,
                                    onQuestionTimerExpired:
                                        _handleQuestionTimeExpired,
                                  );
                                } else {
                                  return MultiSelectQuestion(
                                    question: question,
                                    onAnswered: _handleAnswered,
                                    questionDuration:
                                        _settings.questionTimer ? 10 : null,
                                    onQuestionTimerExpired:
                                        _handleQuestionTimeExpired,
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _settings.allowBack
                                    ? Button(
                                        label: Prev,
                                        onPressed: () => _handlePrev(),
                                      )
                                    : Container(),
                                _settings.allowSubmit
                                    ? Button(
                                        label: Submit,
                                        onPressed: () => _handleSubmit(context),
                                      )
                                    : Container(),
                                Button(
                                  label: _initialPage + 1 !=
                                          response.questions.length
                                      ? Next
                                      : Submit,
                                  onPressed: () => _handleNext(context),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _settings.allowFirst
                                    ? FloatingActionButton(
                                        tooltip: FIRST,
                                        backgroundColor: Colors.white,
                                        mini: true,
                                        child: Icon(
                                          Icons.skip_previous,
                                          color: Theme.of(context).accentColor,
                                        ),
                                        onPressed: () => _handleFirst(),
                                      )
                                    : Container(),
                                _settings.allowReview
                                    ? FloatingActionButton(
                                        tooltip: "Review",
                                        child: Icon(Icons.rate_review),
                                        onPressed: () => _handleReview(context),
                                      )
                                    : Container(),
                                _settings.allowLast
                                    ? FloatingActionButton(
                                        tooltip: LAST,
                                        backgroundColor: Colors.white,
                                        mini: true,
                                        child: Icon(
                                          Icons.skip_next,
                                          color: Theme.of(context).accentColor,
                                        ),
                                        onPressed: () => _handleLast(),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${_initialPage + 1}/${response.questions.length}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _handleAnswered(int questionId, dynamic answers) {
    answersMap.addAll({questionId: answers});
  }

  void _handleOptionsPress() {
    showDialog(
      context: context,
      builder: (context) {
        return SettingsDialog(
          settings: _settings,
          onSave: _handleSettingsSave,
        );
      },
    );
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
    if (_timeUp || !_settings.isAnswerMandatory) {
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
        _handleSubmit(context);
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

  _handleQuizTimerExpired(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("Your time is up")),
    );
  }

  _handleQuestionTimeExpired(int quesId) {
    timerMap[quesId] = true;
  }

  isSingleSelect() {
    return response.questions[_initialPage].questionTypeId ==
        QuestionResponse.SINGLE_SELECT;
  }

  isMultiSelect() {
    bool isMulti = response.questions[_initialPage].questionTypeId ==
        QuestionResponse.MULTI_SELECT;
    return isMulti;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleReview(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionBuilder: (context, a1, a2, w) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Center(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width - 80,
                    height: MediaQuery.of(context).size.height - 100,
                    child: ReviewDialog(answersMap: answersMap),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return;
        });
  }

  void _handleSubmit(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("Ready to submit")),
    );
  }

  _handleSettingsSave(Settings settings) {
    setState(() {
      _settings = settings;
    });
  }
}
