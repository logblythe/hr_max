import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/router.dart';
import 'package:hrmax/ui/widgets/button.dart';

class ExamsScreen extends StatelessWidget {
  final Function(int) onProceedPress;
  final Function(int) onInstructionPress;

  const ExamsScreen({Key key, this.onProceedPress, this.onInstructionPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams'),
      ),
      body: Container(
        color: Colors.grey.withAlpha(25),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 16, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Test Course",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                shadowColor: Colors.grey,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Text(
                                    "Passed",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text("Attempt count : 86 ",
                            style: Theme.of(context).textTheme.caption),
                        Text("0.00%",
                            style: Theme.of(context).textTheme.caption),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Button(
                                  label: Proceed,
                                  onPressed: () =>
                                      handleProceedPress(index, context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Button(
                                  label: Instructions,
                                  onPressed: () =>
                                      handleInstructionPress(index),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  handleProceedPress(int index, context) {
    Navigator.of(context).pushNamed(RoutePaths.QUESTIONS);
  }

  handleInstructionPress(int index) {}
}
