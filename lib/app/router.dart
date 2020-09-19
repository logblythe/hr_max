import 'package:auto_route/auto_route_annotations.dart';
import 'package:hrmax/ui/screens/exam/exams_screen.dart';
import 'package:hrmax/ui/screens/home/home_screen.dart';
import 'package:hrmax/ui/screens/initial/initial_screen.dart';
import 'package:hrmax/ui/screens/instructions/instructions_screen.dart';
import 'package:hrmax/ui/screens/learning_dashboard/learning_dashboard_screen.dart';
import 'package:hrmax/ui/screens/login/login_screen.dart';
import 'package:hrmax/ui/screens/materials/material_viewer_screen.dart';
import 'package:hrmax/ui/screens/materials/materials_screen.dart';
import 'package:hrmax/ui/screens/question/questions_screen.dart';
import 'package:hrmax/ui/screens/result/result_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: InitialScreen, name: "InitialRoute", initial: true),
    MaterialRoute(page: ExamsScreen, name: "ExamRoute"),
    MaterialRoute(page: HomeScreen, name: "HomeRoute"),
    MaterialRoute(page: InstructionsScreen, name: "InstructionRoute"),
    MaterialRoute(page: LearningDashboardScreen, name: "LearningDashRoute"),
    MaterialRoute(page: LoginScreen, name: "LoginRoute"),
    MaterialRoute(page: MaterialScreen, name: "MaterialsRoute"),
    MaterialRoute(page: MaterialViewerScreen, name: "MaterialViewerRoute"),
    MaterialRoute(page: QuestionsScreen, name: "QuestionRoute"),
    MaterialRoute(page: ResultScreen, name: "ResultRoute"),
  ],
)
class $Router {}
