import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hrmax/network/models/month_stat.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

import 'indicator.dart';

class PieChartView extends StatefulWidget {
  final MonthStat monthStat;
  final String month;

  const PieChartView({Key key, this.monthStat, this.month}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartViewState(monthStat, month);
}

class PieChartViewState extends State {
  int touchedIndex;
  final MonthStat monthStat;
  final String month;

  PieChartViewState(this.monthStat, this.month);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 28),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Indicator(
                  color: const Color(0xff0293ee),
                  text: 'Assigned',
                  isSquare: false,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xfff8b250),
                  text: 'Attempted',
                  isSquare: false,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            monthStat.attempted == 0 && monthStat.attempted == 0
                ? Container()
                : Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 8,
                            centerSpaceRadius: 0,
                            sections: showingSections()),
                      ),
                    ),
                  ),
            monthStat.attempted == 0 && monthStat.attempted == 0
                ? Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text("No assignments for $month"),
                  )
                : Text(month),
            UIHelper.verticalSpaceMedium
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.8;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value: monthStat.assigned.toDouble(),
              title: monthStat.assigned == 0 ? '' : '${monthStat.assigned}',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: monthStat.attempted.toDouble(),
              title: monthStat.attempted == 0 ? '' : '${monthStat.attempted}',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}
