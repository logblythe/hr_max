import 'package:flutter/material.dart';

class ReviewDialog extends StatelessWidget {
  final Map<int, dynamic> answersMap;
  final Function(int) onItemClick;

  const ReviewDialog({
    Key key,
    this.answersMap,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: answersMap.length,
      itemBuilder: (ctx, index) {
        bool answered = answersMap.values.elementAt(index).length != 0;
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 16,
                child: Text((index + 1).toString()),
              ),
              Text(
                answered ? "Answered" : "Not answered",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              answered
                  ? Icon(
                      Icons.done,
                      color: Colors.lightGreen,
                    )
                  : Icon(
                      Icons.error,
                      color: Colors.red,
                    )
            ],
          ),
        );
      },
    );
  }
}
