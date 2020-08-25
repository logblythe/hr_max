import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  TextButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Text(
        label,
        style: Theme.of(context).textTheme.subtitle2.copyWith(decoration: TextDecoration.underline,),
      ),
      onTap: onPressed,
    );
  }
}
