import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool busy;
  final FocusNode focusNode;
  final Function onPressed;

  const PrimaryButton({
    Key key,
    this.busy,
    this.focusNode,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        focusNode: focusNode,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(text, style: TextStyle(color: Colors.white, fontSize: 16.0)),
            AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(child: child, scale: animation),
              duration: Duration(milliseconds: 250),
              child: busy
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.arrow_forward, color: Colors.white),
            )
          ],
        ),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
