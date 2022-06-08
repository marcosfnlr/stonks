import 'package:flutter/material.dart';

import 'chart.dart';
import 'spacing.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  bool _isChartFocused = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            GestureDetector(
              onTapDown: _focusChart(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: _chartContainerHeight(constraints),
                // width: MediaQuery.of(context).size.width / 2,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          height: 250.0,
                          padding: const EdgeInsets.all(Spacing.large),
                          child: StackedAreaLineChart.withSampleData(
                            onSelectionChanged: _focusChart(true),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTapDown: _focusChart(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: _stocksContainerHeight(constraints),
                color: Theme.of(context).colorScheme.primary,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        Row(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _focusChart(bool focusChart) {
    return (_) {
      if (_isChartFocused != focusChart) {
        setState(() {
          _isChartFocused = focusChart;
        });
      }
    };
  }

  double _chartContainerHeight(BoxConstraints constraints) {
    return _isChartFocused
        ? constraints.maxHeight * 0.8
        : constraints.maxHeight * 0.3;
  }

  double _stocksContainerHeight(BoxConstraints constraints) {
    return constraints.maxHeight - _chartContainerHeight(constraints);
  }
}
