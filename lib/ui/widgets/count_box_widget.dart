import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class CountBoxWidget extends StatelessWidget {
  final int count;
  final double imageSize;
  final String imagePath;
  final String text;
  final Function onPressed;

  const CountBoxWidget(
      {Key key,
      this.text,
      this.onPressed,
      this.count,
      this.imageSize,
      this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    height: imageSize ?? 40,
                    width: imageSize ?? 40,
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Text(
                    count.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Row(
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).disabledColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
