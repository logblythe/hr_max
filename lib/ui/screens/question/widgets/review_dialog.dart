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
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: answersMap.length,
          itemBuilder: (ctx, index) {
            bool answered = answersMap.values.elementAt(index).length != 0;
            return Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onItemClick(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        child: Text((index + 1).toString()),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            answered ? "Answered" : "Not answered",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ),
                      ),
                      answered
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.lightGreen,
                            )
                          : Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
