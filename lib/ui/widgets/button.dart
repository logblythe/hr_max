import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function onPressed;
  final EdgeInsets margin;
  final bool loading;

  const Button(
      {Key key, this.label, this.onPressed, this.margin, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Theme.of(context).primaryColorDark,
        textColor: Colors.white,
        child: loading ? _Progress() : Text(label),
        onPressed: loading ? null : onPressed,
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
