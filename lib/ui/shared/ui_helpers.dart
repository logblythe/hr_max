import 'package:flutter/material.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 40.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 40.0;

  static const Widget verticalSpaceSmall =
  SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium =
  SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge =
  SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceSmall =
  SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
  SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
  SizedBox(width: _HorizontalSpaceLarge);
  static BoxDecoration boxDecoration(context,{color,radius}) => BoxDecoration(
    color: color??Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(radius??8.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 2.0,
        offset: Offset(0, 0.3),
        spreadRadius: 0.5,
      )
    ],
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: Colors.grey[700],
    brightness: Brightness.dark,
  );
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.red[400],
    backgroundColor: Colors.grey[200],
    brightness: Brightness.light,
  );
}
