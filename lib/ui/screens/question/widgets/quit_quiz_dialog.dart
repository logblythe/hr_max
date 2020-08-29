import 'package:flutter/material.dart';
import 'package:hrmax/ui/widgets/button.dart';

class QuitQuizDialog extends StatefulWidget {

  @override
  _QuitQuizDialogState createState() => _QuitQuizDialogState();
}

class _QuitQuizDialogState extends State<QuitQuizDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: AlertDialog(
              title: Text("Quit session?",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).primaryColorDark)),
              content: Text(
                "Are you sure you want to quit this quiz? All the answers will be lost.",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(
                  width: 64,
                  child: Button(
                    label: "Ok",
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
