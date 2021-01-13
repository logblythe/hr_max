import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class CountBoxWidget extends StatelessWidget {
  final dynamic count;
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
                    height: imageSize ?? 32,
                    width: imageSize ?? 32,
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Expanded(
                    child: Text(
                      count.toString(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                text,
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).disabledColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
