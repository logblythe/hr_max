import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final double size;
  final Color color;

  const Circle({Key key, this.size, this.margin, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
