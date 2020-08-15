import 'dart:async';

import 'package:flutter/material.dart';

class QuestionTimer extends StatefulWidget {
  final Duration duration;
  final Function onExpired;

  const QuestionTimer({Key key, this.duration, this.onExpired})
      : super(key: key);

  @override
  _QuestionTimerState createState() => _QuestionTimerState();
}

class _QuestionTimerState extends State<QuestionTimer> {
  Timer _timer;
  int seconds;

  @override
  void initState() {
    super.initState();
    seconds = widget.duration.inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      var sec = seconds - 1;
      if (sec >= 0) {
        setState(() {
          seconds = sec;
        });
      } else {
        _timer.cancel();
        if (widget.onExpired != null) {
          widget.onExpired();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      seconds.toString(),
      style: TextStyle(color: Colors.red),
    );
  }
}
