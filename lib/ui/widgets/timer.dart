import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration duration;
  final TextStyle textStyle;
  final TextStyle warningTextStyle;
  final Duration warningDuration;
  final Function onExpired;
  final String initialText;
  final String onExpiredText;

  const TimerWidget({
    Key key,
    this.textStyle,
    this.warningTextStyle,
    this.warningDuration = const Duration(minutes: 5),
    this.onExpired,
    this.initialText,
    this.onExpiredText,
    this.duration,
  }) : assert(duration != null);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds;
  int min = 00;
  int sec = 00;
  Timer _timer;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    seconds = widget.duration.inSeconds;
    calculateMinutesAndSeconds();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      seconds = seconds - 1;
      if (seconds >= 0) {
        if (!_disposed) {
          setState(() {
            calculateMinutesAndSeconds();
          });
        }
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
    _disposed = true;
  }

  void calculateMinutesAndSeconds() {
    var quotient = seconds / 60;
    var remainder = seconds % 60;
    if (quotient >= 1) {
      min = quotient.toInt();
    } else {
      min = 0;
    }
    if (remainder >= 0) {
      sec = remainder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return seconds > 0
        ? RichText(
            text: TextSpan(
                text: widget.initialText,
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text:
                        "  ${getZeroPrependedString(min)} : ${getZeroPrependedString(sec)}",
                    style: seconds <= widget.warningDuration.inSeconds
                        ? widget.warningTextStyle
                        : widget.textStyle,
                  ),
                ]),
          )
        : Text(
            widget.onExpiredText,
            style: widget.warningTextStyle,
          );
  }

  getZeroPrependedString(int number) {
    if (number < 10) {
      return number.toString().padLeft(2, "0");
    } else
      return number.toString();
  }
}
