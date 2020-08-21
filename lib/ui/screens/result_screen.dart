import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/widgets/question/multi_select_question.dart';
import 'package:hrmax/ui/widgets/question/single_select_question.dart';

class ResultScreen extends StatefulWidget {
  final Map<int, List<Option>> answersMap;

  const ResultScreen({Key key, this.answersMap}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  QuestionResponse response;
  int _initialPage = 0;
  PageController _controller;

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
        title: Text("Result"),
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
                                    selectedOption: widget.answersMap[question.id],
                                  );
                                } else {
                                  return MultiSelectQuestion(
                                    question: question,
                                    showResult: true,
                                    showCorrectAnswer: true,
                                    selectedOption: widget.answersMap[question.id],
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
            ),
    );
  }

  void _handlePageChange(int value) {
    setState(() {
      _initialPage = value;
    });
  }
}
