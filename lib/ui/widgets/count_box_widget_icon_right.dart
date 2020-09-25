import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class CountBoxWidgetIconRight extends StatelessWidget {
  final dynamic count;
  final double imageSize;
  final String text;
  final String imagePath;
  final Function onPressed;

  const CountBoxWidgetIconRight(
      {Key key,
      this.text,
      this.imagePath,
      this.onPressed,
      this.count,
      this.imageSize})
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        count.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Image.asset(
                    imagePath,
                    height: imageSize ?? 40,
                    width: imageSize ?? 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
