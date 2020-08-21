import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function onPressed;

  const Button({Key key, this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Theme.of(context).primaryColorDark,
      textColor: Colors.white,
      child: Text(label),
      onPressed: onPressed,
    );
  }
}
