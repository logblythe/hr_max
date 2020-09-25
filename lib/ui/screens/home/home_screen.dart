import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/home/home_viewmodel.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/box_widget.dart';
import 'package:hrmax/ui/widgets/dialog_widget.dart';
import 'package:hrmax/ui/widgets/profile_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewmodel>(
      model: HomeViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(model),
          body: WillPopScope(
            onWillPop: _onWillPop,
            child: Column(
              children: <Widget>[
                UIHelper.verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: BoxWidget(
                          text: "Materials",
                          imagePath: 'assets/images/profile.png',
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Expanded(
                        child: BoxWidget(
                          text: E_LEARNING,
                          imagePath: 'assets/images/e-learning.png',
                          onPressed: model.handleElearning,
                        ),
                      )
                    ],
                  ),
                ),
                // UIHelper.verticalSpaceMedium,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: <Widget>[
                //       Expanded(
                //         child: BoxWidget(
                //           text: ISSUE_TICKET,
                //           imagePath: 'assets/images/ticket.png',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(HomeViewmodel model) {
    //TODO if we want to show image
    /*Container(
      padding: const EdgeInsets.all(4),
      child: ProfileImage(
        name: model.loginRes.fullName,
        userId: model.loginRes.idUser,
      ),
    )*/
    return AppBar(
      title: Text("Hr Max"),
      leading: InkResponse(
        child: Icon(Icons.perm_identity),
        onTap: model.handleShowProfile,
      ),
      actions: [
        InkResponse(
          child: Icon(Icons.exit_to_app),
          onTap: model.handleLogout,
        )
      ],
    );
  }

  Future<bool> _onWillPop() async {
    bool _exit;
    _exit = await showDialog(
      context: context,
      builder: (context) => DialogWidget(
          title: "Quit app?", description: "Are you sure you want to exit?"),
    );
    return Future.value(_exit);
  }
}
