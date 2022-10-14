import 'package:flutter/material.dart';

import '/components/stonks_logo.dart';
import 'stock_info.dart';

class StockDisplayContainer extends StatelessWidget {
  final Duration _animationDuration;
  final double _height;
  final bool _showInfo;
  final bool _isFocused;

  const StockDisplayContainer({
    super.key,
    required Duration animationDuration,
    required double height,
    required bool showInfo,
    required bool isFocused,
  })  : _animationDuration = animationDuration,
        _height = height,
        _showInfo = showInfo,
        _isFocused = isFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      height: _height,
      child: _showInfo
          ? StockInfo(
              scrollPhysics: _isFocused
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics())
          : Center(
              child: StonksLogo(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  size: _height / 2),
            ),
    );
  }
}
