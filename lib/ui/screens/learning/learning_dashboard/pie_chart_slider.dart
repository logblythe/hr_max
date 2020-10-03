import 'package:flutter/material.dart';
import 'package:hrmax/network/models/month_wise_stat_res.dart';
import 'package:hrmax/ui/widgets/pie_chart/pie_chart.dart';

class PieChartSlider extends StatelessWidget {
  final MonthWiseStatResponse monthWiseStats;

  PieChartSlider(this.monthWiseStats);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(initialPage: DateTime.now().month - 1),
      children: [
        PieChartView(monthStat: monthWiseStats.january, month: "January"),
        PieChartView(monthStat: monthWiseStats.february, month: "February"),
        PieChartView(monthStat: monthWiseStats.march, month: "March"),
        PieChartView(monthStat: monthWiseStats.april, month: "April"),
        PieChartView(monthStat: monthWiseStats.may, month: "May"),
        PieChartView(monthStat: monthWiseStats.june, month: "June"),
        PieChartView(monthStat: monthWiseStats.july, month: "July"),
        PieChartView(monthStat: monthWiseStats.august, month: "August"),
        PieChartView(monthStat: monthWiseStats.september, month: "September"),
        PieChartView(monthStat: monthWiseStats.october, month: "October"),
        PieChartView(monthStat: monthWiseStats.november, month: "November"),
        PieChartView(monthStat: monthWiseStats.december, month: "December"),
      ],
    );
  }
}
