import 'package:flutter/material.dart';
import 'package:hrmax/network/models/question_model.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/result/result_viewmodel.dart';
import 'package:hrmax/ui/widgets/question/multi_select_question.dart';
import 'package:hrmax/ui/widgets/question/single_select_question.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _initialPage = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ResultViewmodel>(
      model: ResultViewmodel(),
      onModelReady: (model) => model.calculatePercentage(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Result")),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withAlpha(25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: !model.showResult
                ? Text(
                    'You scored ${model.percentage} %',
                    style: Theme.of(context).textTheme.headline4,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'You scored ${model.percentage} %',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: PageView(
                                      controller: _controller,
                                      onPageChanged: _handlePageChange,
                                      children: model.questions.map((question) {
                                        if (question.questionTypeId ==
                                            QuestionResponse.SINGLE_SELECT) {
                                          return SingleSelectQuestion(
                                            question: question,
                                            showResult: model.showResult,
                                            showCorrectAnswer:
                                                model.showCorrectAnswer,
                                            selectedOption:
                                                model.answersMap[question.id],
                                          );
                                        } else {
                                          return MultiSelectQuestion(
                                            question: question,
                                            showResult: model.showResult,
                                            showCorrectAnswer:
                                                model.showCorrectAnswer,
                                            selectedOption:
                                                model.answersMap[question.id],
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
        );
      },
    );
  }

  void _handlePageChange(int value) {
    setState(() => _initialPage = value);
  }
}
