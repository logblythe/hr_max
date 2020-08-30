import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/screens/question/widgets/quit_quiz_dialog.dart';
import 'package:hrmax/ui/screens/question/widgets/review_dialog.dart';
import 'package:hrmax/ui/screens/question/widgets/review_submit_dialog.dart';
import 'package:hrmax/ui/screens/question/widgets/settings_dialog.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
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
        title: Text(
          "Quiz Title",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
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
                child: WillPopScope(
                  onWillPop: () async {
                    bool _exit;
                    _exit = await showDialog(
                        context: context,
                        builder: (context) => QuitQuizDialog());
                    return Future.value(_exit);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_initialPage + 1}/${response?.questions?.length} questions',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TimerWidget(
                            duration: Duration(minutes: 10),
                            warningDuration: Duration(minutes: 5),
                            initialText: "Time remaining",
                            onExpiredText: "Time is up",
                            onExpired: () => _handleQuizTimerExpired(context),
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            warningTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      Expanded(
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
                                      children:
                                          response.questions.map((question) {
                                        if (answersMap[question.id] == null) {
                                          answersMap[question.id] = [];
                                        }
                                        if (question.questionTypeId ==
                                            QuestionResponse.SINGLE_SELECT) {
                                          return SingleSelectQuestion(
                                            question: question,
                                            onAnswered: _handleAnswered,
                                            questionDuration:
                                                _settings.questionTimer
                                                    ? 60
                                                    : null,
                                            onQuestionTimerExpired:
                                                _handleQuestionTimeExpired,
                                            selectedOption:
                                                answersMap[question.id],
                                          );
                                        } else {
                                          return MultiSelectQuestion(
                                            question: question,
                                            onAnswered: _handleAnswered,
                                            questionDuration:
                                                _settings.questionTimer
                                                    ? 60
                                                    : null,
                                            onQuestionTimerExpired:
                                                _handleQuestionTimeExpired,
                                            selectedOption:
                                                answersMap[question.id],
                                          );
                                        }
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 16, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Visibility(
                                            visible: _settings.allowBack,
                                            child: Button(
                                              label: PREV,
                                              onPressed: () => _handlePrev(),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Visibility(
                                              visible: _settings.allowSubmit &&
                                                  _initialPage + 1 !=
                                                      response
                                                          ?.questions?.length,
                                              child: Button(
                                                label: SUBMIT,
                                                onPressed: () =>
                                                    _handleSubmit(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Button(
                                            label: _initialPage + 1 ==
                                                    response?.questions?.length
                                                ? SUBMIT
                                                : NEXT,
                                            onPressed: () =>
                                                _handleNext(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 16, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Visibility(
                                            visible: _settings.allowFirst &&
                                                _initialPage != 0,
                                            child: Button(
                                              label: FIRST,
                                              onPressed: _handleFirst,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Visibility(
                                              visible: _settings.allowReview,
                                              child: Button(
                                                label: REVIEW,
                                                onPressed: () =>
                                                    _handleReview(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Visibility(
                                            visible: _settings.allowLast &&
                                                _initialPage + 1 !=
                                                    response?.questions?.length,
                                            child: Button(
                                              label: LAST,
                                              onPressed: _handleLast,
                                            ),
                                          ),
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
                    ],
                  ),
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
    bool _lastPageReached = _initialPage == _questions.length - 1;
    bool _timeUp = timerMap[_questions[_initialPage].id] ?? false;
    bool _answered = false;
    if (isSingleSelect() &&
        answersMap[_questions[_initialPage].id].length == 1) {
      _answered = true;
    } else if (isMultiSelect() &&
        answersMap[_questions[_initialPage].id].length >= 2) {
      _answered = true;
    }
    if (_timeUp || !_settings.isAnswerMandatory) {
      if (!_lastPageReached) {
        setState(() => _initialPage = _initialPage + 1);
        _controller.animateToPage(
          _initialPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      } else {
        _handleSubmit(context);
      }
    } else if (_answered) {
      if (!_lastPageReached) {
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
      showToast(
          isSingleSelect()
              ? "Please select one answer"
              : isMultiSelect()
                  ? "Please select two or more answers"
                  : "Please select answer",
          context: context,
          axis: Axis.horizontal,
          alignment: Alignment.topCenter,
          position: StyledToastPosition.center);
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
    Navigator.of(context).pushReplacementNamed(RoutePaths.RESULT, arguments: [
      answersMap,
      _settings.showResult,
      _settings.showCorrectAnswer
    ]);
  }

  _handleQuestionTimeExpired(int quesId) {
    timerMap[quesId] = true;
    showToast("Time up",
        context: context,
        axis: Axis.horizontal,
        alignment: Alignment.topCenter,
        position: StyledToastPosition.center);
    _handleNext(context);
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
    showDialog(
        context: context,
        builder: (context) {
          return ReviewDialog(
            answersMap: answersMap,
            onItemClick: _handleReviewItemClick,
          );
        });
/*    showGeneralDialog(
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
                    child: ReviewDialog(
                      answersMap: answersMap,
                      onItemClick: _handleReviewItemClick,
                    ),
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
        });*/
  }

  void _handleSubmit(BuildContext context) {
    if (_settings.enableReviewDialog) {
      int _answeredCount = 0;
      answersMap.forEach((key, value) {
        if (value.length != 0) {
          _answeredCount = _answeredCount + 1;
        }
      });
      showDialog(
        context: context,
        builder: (context) {
          return ReviewSubmitDialog(
            answeredCount: _answeredCount,
            totalCount: response.questions.length,
            onAccept: () {
              if (_settings.enableAutoClose) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacementNamed(RoutePaths.RESULT,
                    arguments: [
                      answersMap,
                      _settings.showResult,
                      _settings.showCorrectAnswer
                    ]);
              }
            },
            onReject: () {},
          );
        },
      );
    } else {
      if (_settings.enableAutoClose) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacementNamed(RoutePaths.RESULT,
            arguments: [
              answersMap,
              _settings.showResult,
              _settings.showCorrectAnswer
            ]);
      }
    }
  }

  _handleSettingsSave(Settings settings) {
    setState(() {
      _settings = settings;
    });
  }

  _handleReviewItemClick(int index) {
    setState(() {
      _initialPage = index;
    });
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInCubic);
  }
}
