import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

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

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration.inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      var sec = _seconds - 1;
      if (sec >= 0) {
        setState(() {
          _seconds = sec;
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
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: UIHelper.boxDecoration(context,
          color: Colors.grey.withOpacity(0.5), radius: 16.0),
      child: Text(_seconds.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white)),
    );
  }
}
