import 'package:flutter/material.dart';

class ChangeValueInfo extends StatelessWidget {
  final double _firstValue;
  final double _lastValue;
  final String _timeInterval;

  const ChangeValueInfo({
    required firstValue,
    required lastValue,
    required timeInterval,
    super.key,
  })  : _firstValue = firstValue,
        _lastValue = lastValue,
        _timeInterval = timeInterval;

  @override
  Widget build(BuildContext context) {
    final changeValue = _lastValue - _firstValue;
    final isPositive = changeValue >= 0;
    final color = isPositive ? Colors.green[700] : Colors.red[700];
    final percentageRelative = (_lastValue / _firstValue - 1) * 100;
    return RichText(
      text: TextSpan(
        text:
            "${changeValue.toStringAsFixed(2)} (${percentageRelative.toStringAsFixed(2)}%)",
        style: TextStyle(color: color),
        children: [
          WidgetSpan(
            child: Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: DefaultTextStyle.of(context).style.fontSize,
            ),
          ),
          TextSpan(text: _timeInterval),
        ],
      ),
    );
  }
}
