import 'package:auto_route/auto_route.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitlePositive;
  final String buttonTitleNegative;

  DialogRequest({
    @required this.title,
    @required this.description,
    @required this.buttonTitlePositive,
    @required this.buttonTitleNegative,
  });
}
