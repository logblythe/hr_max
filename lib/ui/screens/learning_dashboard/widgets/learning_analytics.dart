import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/bar_chart.dart';
import 'package:hrmax/ui/widgets/circle.dart';
import 'package:hrmax/ui/widgets/count_box_widget.dart';
import 'package:hrmax/ui/widgets/count_box_widget_icon_right.dart';

class LearningAnalytics extends StatelessWidget {
  final Function onPendingClick;

  const LearningAnalytics({Key key, this.onPendingClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CountBoxWidget(
                  count: 10,
                  text: COMPLETED,
                  imagePath: ImagePath.PROFILE,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: CountBoxWidget(
                  onPressed: onPendingClick,
                  count: 12,
                  text: PENDING,
                  imagePath: ImagePath.LEARNING,
                ),
              )
            ],
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: CountBoxWidgetIconRight(
            count: 30,
            text: MONTH_LEARNING,
            imagePath: ImagePath.LEARNING,
            imageSize: 60,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 24,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Circle(
                          size: 12,
                          margin: const EdgeInsets.only(right: 8),
                        ),
                        Text(
                          LEARNING,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: BarChart.withSampleData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
