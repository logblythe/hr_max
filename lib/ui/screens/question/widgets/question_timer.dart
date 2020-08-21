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
  int _seconds;
  double _progress;

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration.inSeconds;
    _progress = 1;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      var sec = _seconds - 1;
      if (sec >= 0) {
        setState(() {
          _seconds = sec;
          _progress = sec / widget.duration.inSeconds;
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
  void dispose() {
super.dispose();
_timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme
              .of(context)
              .primaryColor,
        ),
        value: _progress,
      ),
    );
  }
}
