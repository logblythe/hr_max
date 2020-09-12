import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/ui/widgets/button.dart';

class ExamCard extends StatelessWidget {
  final Function onProcess;
  final Function onInstructions;
  final Function onViewMaterials;
  final LearningTrackerRes tracker;

  ExamCard({
    this.onProcess,
    this.onInstructions,
    this.onViewMaterials,
    this.tracker,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
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
                          tracker.courseName ?? "",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Text("Attempt count : ${tracker.attemptCount} ",
                      style: Theme.of(context).textTheme.caption),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: Button(
                            label: Proceed,
                            onPressed: onProcess,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: Button(
                            label: Instructions,
                            onPressed: onInstructions,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12),
                    child: Button(
                      label: VIEW_READING_MATERIALS,
                      onPressed: onViewMaterials,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 26,
          top: 20,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Text(
              tracker.status,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
