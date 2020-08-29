import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/provider_setup.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: StyledToast(
        locale: const Locale('en', 'US'),
        textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
        backgroundColor: Color(0x99000000),
        borderRadius: BorderRadius.circular(5.0),
        textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
        toastAnimation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        startOffset: Offset(0.0, -1.0),
        reverseEndOffset: Offset(0.0, -1.0),
        duration: Duration(seconds: 3),
        animDuration: Duration(seconds: 1),
        alignment: Alignment.center,
        toastPositions: StyledToastPosition.center,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn,
        dismissOtherOnShow: true,
        movingOnWindowChange: true,
        child: MaterialApp(
          title: APP_TITLE,
          home: LoginScreen(),
          onGenerateRoute: (settings) => Router.generateRoute(settings),
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
