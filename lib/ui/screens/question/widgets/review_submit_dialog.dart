import 'package:flutter/material.dart';
import 'package:hrmax/ui/widgets/button.dart';

class ReviewSubmitDialog extends StatefulWidget {
  final int answeredCount;
  final int totalCount;
  final Function() onAccept;
  final Function() onReject;

  const ReviewSubmitDialog(
      {Key key,
      this.answeredCount,
      this.totalCount,
      this.onAccept,
      this.onReject})
      : super(key: key);

  @override
  _ReviewSubmitDialogState createState() => _ReviewSubmitDialogState();
}

class _ReviewSubmitDialogState extends State<ReviewSubmitDialog>
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
              title: Text("Confirm Submission",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).primaryColorDark)),
              content: Text(
                "You have answered ${widget.answeredCount} out of ${widget.totalCount} questions. Are you sure you want to submit?",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onReject();
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
                      Navigator.of(context).pop();
                      widget.onAccept();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
