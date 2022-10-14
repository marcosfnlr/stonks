import 'package:flutter_bloc/flutter_bloc.dart';

import 'container_selection_state.dart';

abstract class ContainerSelectionEvent {}

class StockInfoSelected extends ContainerSelectionEvent {}

class TickerListSelected extends ContainerSelectionEvent {}

class ContainerSelectionBloc
    extends Bloc<ContainerSelectionEvent, ContainerSelectionState> {
  ContainerSelectionBloc() : super(ContainerSelectionState.nothingSelected) {
    on<TickerListSelected>(
      (event, emit) {
        if (state == ContainerSelectionState.tickerListFocused) return;
        emit(ContainerSelectionState.tickerListFocused);
      },
    );
    on<StockInfoSelected>(
      (event, emit) {
        if (state == ContainerSelectionState.stockInfoFocused) return;
        emit(ContainerSelectionState.stockInfoFocused);
      },
    );
  }
}
