import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('1', 8),
      new OrdinalSales('2', 9),
      new OrdinalSales('3', 7),
      new OrdinalSales('4', 10),
      new OrdinalSales('5', 10),
      new OrdinalSales('6', 6),
      new OrdinalSales('7', 11),
      new OrdinalSales('8', 18),
      new OrdinalSales('9', 18),
      new OrdinalSales('10', 13),
      new OrdinalSales('11', 14),
      new OrdinalSales('12', 20),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
