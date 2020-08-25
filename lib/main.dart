import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:hrmax/provider_setup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: APP_TITLE,
       /* theme: ThemeData(
          accentColor: Color(0xFF512DA8),
          primaryColorDark: Color(0xFF512DA8),
          primaryColorLight: Color(0xFFD1C4E9),
          primaryColor: Color(0xFF673AB7),
//          accentColor: Color(0xFFE040FB),
        ),*/
        home: LoginScreen(),
        onGenerateRoute: (settings) => Router.generateRoute(settings),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
