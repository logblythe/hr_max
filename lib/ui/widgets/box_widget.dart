import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class BoxWidget extends StatelessWidget {
  final double imageSize;
  final String text;
  final Function onPressed;
  final String imagePath;

  const BoxWidget(
      {Key key, this.text, this.onPressed, this.imageSize, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.only(top: 16, bottom: 32),
          child: Column(
            children: <Widget>[
              Image.asset(
                imagePath,
                height: imageSize ?? 40,
                width: imageSize ?? 40,
              ),
              UIHelper.verticalSpaceMedium,
              Text(
                text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
