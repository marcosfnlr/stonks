import 'package:flutter/material.dart';

class CurrentValueInfo extends StatelessWidget {
  final double _currentValue;

  const CurrentValueInfo({required currentValue, super.key})
      : _currentValue = currentValue;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: _currentValue.toStringAsFixed(2),
        style: Theme.of(context).textTheme.headlineLarge,
        children: [
          TextSpan(
            text: ' BRL',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
