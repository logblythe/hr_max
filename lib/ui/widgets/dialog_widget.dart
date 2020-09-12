import 'package:flutter/material.dart';
import 'package:hrmax/ui/widgets/button.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String description;

  const DialogWidget({Key key, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColorDark)),
      content: Text(
        description,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.pop(context, false),
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
    );
  }
}
