import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;
  final void Function(charts.SelectionModel)? onSelectionChanged;

  const StackedAreaLineChart(this.seriesList,
      {this.animate = false, this.onSelectionChanged, Key? key})
      : super(key: key);

  factory StackedAreaLineChart.withSampleData(
      {void Function(charts.SelectionModel)? onSelectionChanged}) {
    return StackedAreaLineChart(
      _createSampleData(),
      animate: false,
      onSelectionChanged: onSelectionChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final charts.Color labelColor;
    final charts.Color lineColor;
    final charts.Color domainLineColor;
    if (Theme.of(context).brightness == Brightness.dark) {
      labelColor = charts.MaterialPalette.gray.shade500;
      lineColor = charts.MaterialPalette.gray.shade800;
      domainLineColor = charts.MaterialPalette.gray.shade500;
    } else {
      labelColor = charts.MaterialPalette.gray.shade500;
      lineColor = charts.MaterialPalette.gray.shade100;
      domainLineColor = charts.MaterialPalette.gray.shade400;
    }

    return charts.LineChart(
      seriesList,
      defaultRenderer:
          charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: animate,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: onSelectionChanged,
        )
      ],
      domainAxis: charts.NumericAxisSpec(
        showAxisLine: true,
        renderSpec: charts.GridlineRendererSpec(
          lineStyle: const charts.LineStyleSpec(
            color: charts.MaterialPalette.transparent,
          ),
          labelStyle: charts.TextStyleSpec(
            color: labelColor,
          ),
          axisLineStyle: charts.LineStyleSpec(
            color: domainLineColor,
            thickness: 2,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.red.shadeDefault,
          ),
          labelStyle: charts.TextStyleSpec(
            color: labelColor,
          ),
          lineStyle: charts.LineStyleSpec(
            color: lineColor,
          ),
        ),
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      LinearSales(0, 200),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    var myFakeTabletData = [
      LinearSales(0, 10),
      LinearSales(1, 50),
      LinearSales(2, 200),
      LinearSales(3, 150),
    ];

    var myFakeMobileData = [
      LinearSales(0, 15),
      LinearSales(1, 75),
      LinearSales(2, 300),
      LinearSales(3, 225),
    ];

    return [
      // charts.Series<LinearSales, int>(
      //   id: 'Desktop',
      //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //   domainFn: (LinearSales sales, _) => sales.year,
      //   measureFn: (LinearSales sales, _) => sales.sales,
      //   data: myFakeDesktopData,
      // ),
      // charts.Series<LinearSales, int>(
      //   id: 'Tablet',
      //   colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //   domainFn: (LinearSales sales, _) => sales.year,
      //   measureFn: (LinearSales sales, _) => sales.sales,
      //   data: myFakeTabletData,
      // ),
      charts.Series<LinearSales, int>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
