import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/ui/widgets/button.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Function onProcess;
  final Function onInstructions;
  final Function onViewMaterials;
  final Function onDownloadCertificate;
  final LearningTrackerRes tracker;
  final bool downloading;

  ExamCard({
    this.onProcess,
    this.onInstructions,
    this.onViewMaterials,
    this.onDownloadCertificate,
    this.tracker,
    this.downloading,
  });

  @override
  Widget build(BuildContext context) {
    bool showMaterials = tracker.readingMaterialExist;
    bool showProceed = (tracker.attemptCount > 0 && withinRange());
    bool showDownload =
        tracker.enableGenerateCertificate && tracker.status == "Passed";
    return Stack(
      children: <Widget>[
        Container(
          margin:
              const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 8.0),
                    child: Text(
                      tracker.courseName ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text("Attempt count : ${tracker.attemptCount} ",
                      style: Theme.of(context).textTheme.caption),
                  Text("Scored marks : ${tracker.obtainedMark} ",
                      style: Theme.of(context).textTheme.caption),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      showProceed
                          ? Expanded(
                              child: Button(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                label: Proceed,
                                onPressed: onProcess,
                              ),
                            )
                          : SizedBox.shrink(),
                      Expanded(
                        child: Button(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          label: Instructions,
                          onPressed: onInstructions,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      showMaterials
                          ? Expanded(
                              child: Button(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                label: VIEW_READING_MATERIALS,
                                onPressed: onViewMaterials,
                              ),
                            )
                          : SizedBox.shrink(),
                      showDownload
                          ? Expanded(
                              child: Button(
                                loading: downloading,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                label: "Download certificate",
                                onPressed: onDownloadCertificate,
                              ),
                            )
                          : SizedBox.shrink()
                    ],
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
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Text(
              tracker.status,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  bool withinRange() {
    bool inRange = DateTime.now().isAfter(
            DateFormat("M/dd/yyyy").parse(tracker.learningFromDateTime)) &&
        DateTime.now().isBefore(
            DateFormat("M/dd/yyyy").parse(tracker.learningToDateTime));
    return inRange;
  }
}
