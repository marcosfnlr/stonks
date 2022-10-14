import 'package:flutter_bloc/flutter_bloc.dart';

import 'stocks_period_state.dart';

abstract class PeriodChipChangeEvent {
  const PeriodChipChangeEvent();
}

class PeriodChipSelected extends PeriodChipChangeEvent {
  final StocksPeriodState period;
  const PeriodChipSelected({required this.period});
}

class PeriodChipChangeBloc
    extends Bloc<PeriodChipChangeEvent, StocksPeriodState> {
  PeriodChipChangeBloc() : super(StocksPeriodState.oneMonth) {
    on<PeriodChipSelected>((event, emit) => emit(event.period));
  }
}
