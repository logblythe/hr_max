import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/option.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/question/question_viewmodel.dart';
import 'package:hrmax/ui/screens/question/widgets/review_dialog.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/button.dart';
import 'package:hrmax/ui/widgets/dialog_widget.dart';
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
  Map<int, List<Option>> answersMap = {};
  Map<int, bool> timerMap = {};
  QuestionViewmodel _model;

  @override
  void initState() {
    _controller = PageController(initialPage: _initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<QuestionViewmodel>(
      model: QuestionViewmodel(),
      onModelReady: (model) => model.fetchQuestions(),
      builder: (context, model, child) {
        _model = model;
        response = model.questionResponse;
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
        );
      },
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(
        response?.quiz?.name ?? "",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  buildBody() {
    if (_model.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (_model.error != null) {
      return Center(child: Text(_model.error));
    } else {
      return Container(
        color: Colors.grey.withAlpha(25),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Column(
            children: [
              buildTimerRow(),
              UIHelper.verticalSpaceSmall,
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: <Widget>[
                      buildQuestionsViewer(),
                      buildUpperButtons(),
                      buildLowerButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Row buildTimerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_initialPage + 1}/${response.questions.length} questions',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TimerWidget(
          duration: Duration(minutes: response.config.duration),
          warningDuration: Duration(minutes: 5),
          initialText: "Time remaining",
          onExpiredText: "Time is up",
          onExpired: _handleQuizTimerExpired,
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
    );
  }

  Expanded buildQuestionsViewer() {
    return Expanded(
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: _handlePageChange,
        children: response.questions.map((question) {
          if (answersMap[question.id] == null) {
            answersMap[question.id] = [];
          }
          if (question.questionTypeId == QuestionResponse.SINGLE_SELECT) {
            return SingleSelectQuestion(
              question: question,
              onAnswered: _handleAnswered,
              questionDuration: response.config.timePerQuestion,
              onQuestionTimerExpired: _handleQuestionTimeExpired,
              selectedOption: answersMap[question.id],
            );
          } else {
            return MultiSelectQuestion(
              question: question,
              onAnswered: _handleAnswered,
              questionDuration: response.config.timePerQuestion,
              onQuestionTimerExpired: _handleQuestionTimeExpired,
              selectedOption: answersMap[question.id],
            );
          }
        }).toList(),
      ),
    );
  }

  Padding buildLowerButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Visibility(
              visible: response.config.allowFirst && _initialPage != 0,
              child: Button(
                label: FIRST,
                onPressed: _handleFirst,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Visibility(
                visible: response.config.allowReview,
                child: Button(
                  label: REVIEW,
                  onPressed: () => _handleReview(context),
                ),
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: response.config.allowLast &&
                  _initialPage + 1 != response?.questions?.length,
              child: Button(
                label: LAST,
                onPressed: _handleLast,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildUpperButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Visibility(
              visible: _initialPage > 0 && response.config.allowBack,
              child: Button(label: PREV, onPressed: _handlePrev),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Visibility(
                visible: response.config.allowSubmit &&
                    _initialPage + 1 != response?.questions?.length,
                child: Button(label: SUBMIT, onPressed: _handleSubmit),
              ),
            ),
          ),
          Expanded(
            child: Button(
              label: _initialPage + 1 == response?.questions?.length
                  ? SUBMIT
                  : NEXT,
              onPressed: _handleNext,
            ),
          ),
        ],
      ),
    );
  }

  _handleAnswered(int questionId, dynamic answers) =>
      answersMap.addAll({questionId: answers});

  _handlePageChange(int current) => _initialPage = current;

  _handlePrev() {
    if (_initialPage > 0) {
      animateTo(_initialPage - 1);
    }
  }

  _handleNext() {
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
    if (_timeUp || !response.config.isAnswerMandatory || _answered) {
      if (!_lastPageReached) {
        animateTo(_initialPage + 1);
      } else {
        _handleSubmit();
      }
    } else {
      Fluttertoast.showToast(
          msg: isSingleSelect()
              ? "Please select one answer"
              : isMultiSelect()
                  ? "Please select two or more answers"
                  : "Please select answer",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _handleFirst() => animateTo(0);

  _handleLast() => animateTo(response.questions.length - 1);

  _handleQuizTimerExpired() => _model.showResult(answersMap);

  _handleQuestionTimeExpired(int quesId) {
    timerMap[quesId] = true;
    Fluttertoast.showToast(
        msg: "Time up",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 16.0);
    _handleNext();
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

  _handleReview(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ReviewDialog(
            answersMap: answersMap,
            onItemClick: animateTo,
          );
        });
  }

  _handleSubmit() => _model.submit(answersMap);

  animateTo(index) {
    setState(() => _initialPage = index);
    _controller.animateToPage(
      _initialPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

  Future<bool> _onWillPop() async {
    bool _exit;
    _exit = await showDialog(
      context: context,
      builder: (context) => DialogWidget(
          title: "Quit session?",
          description:
              "Are you sure you want to quit this quiz? All the answers will be lost."),
    );
    return Future.value(_exit);
  }
}
