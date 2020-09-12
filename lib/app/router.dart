import 'package:auto_route/auto_route_annotations.dart';
import 'package:hrmax/ui/screens/exam/exams_screen.dart';
import 'package:hrmax/ui/screens/home_screen.dart';
import 'package:hrmax/ui/screens/learning_dashboard/learning_dashboard_screen.dart';
import 'package:hrmax/ui/screens/login/login_screen.dart';
import 'package:hrmax/ui/screens/materials/material_viewer_screen.dart';
import 'package:hrmax/ui/screens/materials/materials_screen.dart';
import 'package:hrmax/ui/screens/question/questions_screen.dart';
import 'package:hrmax/ui/screens/result_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginScreen, name: "LoginRoute", initial: true),
    MaterialRoute(page: HomeScreen, name: "HomeRoute"),
    MaterialRoute(page: LearningDashboardScreen, name: "LearningDashRoute"),
    MaterialRoute(page: ExamsScreen, name: "ExamRoute"),
    MaterialRoute(page: QuestionsScreen, name: "QuestionRoute"),
    MaterialRoute(page: ResultScreen, name: "ResultRoute"),
    MaterialRoute(page: MaterialScreen, name: "MaterialsRoute"),
    MaterialRoute(page: MaterialViewerScreen, name: "MaterialViewerRoute"),
  ],
)
class $Router {}
