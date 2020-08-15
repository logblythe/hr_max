import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/box_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleProfileClick() {}

  void handleElearningClick() {
    Navigator.pushNamed(context, RoutePaths.LEARNING_DASHBOARD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MENU),
      ),
      body: Column(
        children: <Widget>[
          UIHelper.verticalSpaceMedium,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: BoxWidget(
                    text: PROFILE,
                    imagePath: 'assets/images/profile.png',
                    onPressed: handleProfileClick,
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: BoxWidget(
                    text: E_LEARNING,
                    imagePath: 'assets/images/e-learning.png',
                    onPressed: handleElearningClick,
                  ),
                )
              ],
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: BoxWidget(
                    text: ISSUE_TICKET,
                    imagePath: 'assets/images/ticket.png',
                    onPressed: handleElearningClick,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
