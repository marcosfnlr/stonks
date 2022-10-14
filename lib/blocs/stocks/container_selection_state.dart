import 'package:flutter/material.dart';

enum ContainerSelectionState {
  nothingSelected(hasInfo: false),
  tickerListFocused,
  stockInfoFocused;

  final bool hasInfo;

  const ContainerSelectionState({this.hasInfo = true});

  double stockInfoContainerHeight(BoxConstraints constraints) {
    return this != stockInfoFocused
        ? constraints.maxHeight * 0.3
        : constraints.maxHeight * 0.8;
  }

  double stocksListContainerHeight(BoxConstraints constraints) {
    return constraints.maxHeight - stockInfoContainerHeight(constraints);
  }
}
