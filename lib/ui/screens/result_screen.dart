import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/widgets/question/multi_select_question.dart';
import 'package:hrmax/ui/widgets/question/single_select_question.dart';
import 'package:hrmax/utils.dart';

class ResultScreen extends StatefulWidget {
  final Map<int, List<Option>> answersMap;

  const ResultScreen({Key key, this.answersMap}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  QuestionResponse response;
  int _initialPage = 0;
  String _percentage = "0";
  PageController _controller;

  loadAsset() async {
    var result = await rootBundle.loadString('assets/response.json');
    setState(() => response = QuestionResponse.fromJsonMap(jsonDecode(result)));
    return;
  }

  @override
  void initState() {
    _controller = PageController(initialPage: _initialPage);
    loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (response != null)
      _calculatePercentage(response.questions, widget.answersMap);
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: response == null
          ? Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) => Container(
                color: Colors.grey.withAlpha(25),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('You scored $_percentage %',style: Theme.of(context).textTheme.headline4,),
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
                                    controller: _controller,
                                    onPageChanged: _handlePageChange,
                                    children: response.questions.map((question) {
//                                if (answersMap[question.id] == null) {
//                                  answersMap[question.id] = [];
//                                }
                                      if (question.questionTypeId ==
                                          QuestionResponse.SINGLE_SELECT) {
                                        return SingleSelectQuestion(
                                          question: question,
                                          showResult: true,
                                          showCorrectAnswer: true,
                                          selectedOption:
                                              widget.answersMap[question.id],
                                        );
                                      } else {
                                        return MultiSelectQuestion(
                                          question: question,
                                          showResult: true,
                                          showCorrectAnswer: true,
                                          selectedOption:
                                              widget.answersMap[question.id],
                                        );
                                      }
                                    }).toList(),
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
    );
  }

  void _handlePageChange(int value) {
    setState(() {
      _initialPage = value;
    });
  }

  void _calculatePercentage(
      List<Question> _questions, Map<int, List<Option>> answersMap) {
    double _initialPercent = 0;
    double _increment = 100 / _questions.length;
    for (int i = 0; i < _questions.length; i++) {
      List<int> correctAnswers = _questions[i].correctAnswer;
      List<int> answeredAnswers =
          answersMap.values.elementAt(i).map((e) => e.id).toList();
      bool correct = false;
      for (int i = 0; i < correctAnswers.length; i++) {
        if (areListsEqual(correctAnswers, answeredAnswers)) {
          correct = true;
        }
      }
      if (correct) {
        _initialPercent = _initialPercent + _increment;
      }
    }
    setState(() {
      _percentage = _initialPercent.toStringAsFixed(2);
    });
  }
}
