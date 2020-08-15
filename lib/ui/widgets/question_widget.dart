import 'package:flutter/material.dart';
import 'package:hrmax/network/models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(question.name),
          Expanded(child: ListView(children: question.options.map((e) => Text(e.name)).toList()))
        ],
      ),
    );
  }
}
