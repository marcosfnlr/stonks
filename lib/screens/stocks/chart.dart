import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../../models/tick_data.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series<TickData, int>> _seriesList;
  final bool animate;
  final int _minDomainValue;
  final int _maxDomainValue;
  final double _minMeasureValue;
  final double _maxMeasureValue;
  final DateFormat _dateFormatter;
  final List<charts.TickSpec<int>> _domainTicks;
  final List<charts.TickSpec<double>> _measureTicks;
  final void Function(charts.SelectionModel)? onSelectionChanged;

  StackedAreaLineChart(
    List<TickData> data, {
    required DateFormat dateFormater,
    this.animate = false,
    this.onSelectionChanged,
    Key? key,
  })  : _seriesList = _initSeriesList(data),
        _minDomainValue = data.first.date.millisecondsSinceEpoch,
        _maxDomainValue = data.last.date.millisecondsSinceEpoch,
        _minMeasureValue = _initMinMeasure(data),
        _maxMeasureValue = _initMaxMeasure(data),
        _domainTicks = _initDomainTicks(data),
        _measureTicks = _initMeasureTicks(data),
        _dateFormatter = dateFormater,
        super(key: key);

  static List<charts.Series<TickData, int>> _initSeriesList(
    List<TickData> data,
  ) {
    return [
      charts.Series<TickData, int>(
        id: 'Tickers',
        colorFn: (_, __) => data.first.value > data.last.value
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.green.shadeDefault,
        domainFn: (TickData t, _) => t.date.millisecondsSinceEpoch,
        measureFn: (TickData t, _) => t.value,
        data: data,
      )
    ];
  }

  static double _initMaxMeasure(List<TickData> data) =>
      data.map((t) => t.value).reduce(max) * 1.05;

  static double _initMinMeasure(List<TickData> data) =>
      data.map((t) => t.value).reduce(min) * 0.95;

  static List<charts.TickSpec<int>> _initDomainTicks(List<TickData> data) {
    final ticksIndexes = [
      (data.length * 0.1).ceil(),
      (data.length / 2).round(),
      (data.length * 0.9).floor(),
    ];
    return List.from(ticksIndexes.map(
      (index) => charts.TickSpec<int>(data[index].date.millisecondsSinceEpoch),
    ));
  }

  static List<charts.TickSpec<double>> _initMeasureTicks(List<TickData> data) {
    const measureTicksNumber = 5;
    final minMeasure = _initMinMeasure(data);
    final maxMeasure = _initMaxMeasure(data);
    final delta = (maxMeasure - minMeasure) / (measureTicksNumber - 1);
    return List.from([
      charts.TickSpec<double>(minMeasure),
      for (var i = 1; i <= measureTicksNumber - 2; i++)
        charts.TickSpec<double>(minMeasure + delta * i),
      charts.TickSpec<double>(maxMeasure),
    ]);
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
      _seriesList,
      defaultRenderer:
          charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: animate,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: onSelectionChanged,
        ),
      ],
      domainAxis: _buildDomainAxis(labelColor, domainLineColor),
      primaryMeasureAxis: _buildMeasureAxis(labelColor, lineColor),
    );
  }

  charts.NumericAxisSpec _buildMeasureAxis(
    charts.Color labelColor,
    charts.Color lineColor,
  ) {
    return charts.NumericAxisSpec(
      viewport: charts.NumericExtents(_minMeasureValue, _maxMeasureValue),
      tickProviderSpec: charts.StaticNumericTickProviderSpec(_measureTicks),
      tickFormatterSpec:
          charts.BasicNumericTickFormatterSpec(_measureTickFormatter),
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
    );
  }

  charts.NumericAxisSpec _buildDomainAxis(
    charts.Color labelColor,
    charts.Color domainLineColor,
  ) {
    return charts.NumericAxisSpec(
      viewport: charts.NumericExtents(_minDomainValue, _maxDomainValue),
      tickProviderSpec: charts.StaticNumericTickProviderSpec(_domainTicks),
      tickFormatterSpec:
          charts.BasicNumericTickFormatterSpec(_domainTickFormatter),
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
    );
  }

  String _measureTickFormatter(num? value) {
    if (value == null) {
      throw const FormatException(
        "Invalid number format for measure axis",
      );
    }
    final int fractionDigits;
    final delta = _maxMeasureValue - _minMeasureValue;
    if (delta < 1) {
      fractionDigits = 2;
    } else if (delta < 10) {
      fractionDigits = 1;
    } else {
      fractionDigits = 0;
    }
    return value.toStringAsFixed(fractionDigits);
  }

  String _domainTickFormatter(num? value) {
    if (value is! int) {
      throw const FormatException(
        "Invalid number format for domain axis",
      );
    }
    return _dateFormatter.format(DateTime.fromMillisecondsSinceEpoch(value));
  }
}
