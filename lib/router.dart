import 'package:flutter/material.dart';
import 'package:hrmax/ui/screens/exam/exams_screen.dart';
import 'package:hrmax/ui/screens/home_screen.dart';
import 'package:hrmax/ui/screens/learning_dashboard/learning_dashboard_screen.dart';
import 'package:hrmax/ui/screens/login_screen.dart';
import 'package:hrmax/ui/screens/question/questions_screen.dart';
import 'package:hrmax/ui/screens/result_screen.dart';

class RoutePaths {
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String PROFILE = "/profile";
  static const String LEARNING_DASHBOARD = "/learning-dashboard";
  static const String EXAM_LIST = "/exams";
  static const String RESULT = "/result";
  static const String QUESTIONS = "/questions";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutePaths.HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutePaths.LEARNING_DASHBOARD:
        return MaterialPageRoute(builder: (_) => LearningDashboardScreen());
      case RoutePaths.EXAM_LIST:
        return MaterialPageRoute(builder: (_) => ExamsScreen());
      case RoutePaths.QUESTIONS:
        return MaterialPageRoute(builder: (_) => QuestionsScreen());
      case RoutePaths.RESULT:
        {
          List<dynamic> arguments = settings.arguments;
          return MaterialPageRoute(
            builder: (_) {
              return ResultScreen(
                answersMap: arguments[0],
                showResult: arguments[1],
                showCorrectAnswer: arguments[2],
              );
            },
          );
        }
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
