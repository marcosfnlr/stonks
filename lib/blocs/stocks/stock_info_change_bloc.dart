import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/tick_data.dart';
import '/models/ticker.dart';
import 'container_selection_bloc.dart';
import 'stocks_period_state.dart';
import 'stock_info_change_sate.dart';

abstract class StockInfoChangeEvent {}

class StockSelected extends StockInfoChangeEvent {
  final Ticker ticker;

  StockSelected({required this.ticker});
}

class PeriodChange extends StockInfoChangeEvent {
  final StocksPeriodState period;

  PeriodChange({required this.period});
}

class StockInfoChangeBloc
    extends Bloc<StockInfoChangeEvent, StockInfoChangeState> {
  final ContainerSelectionBloc containerSelectionBloc;
  StockInfoChangeBloc({
    required this.containerSelectionBloc,
  }) : super(StockInfoChangeState(
          chartData: [],
          period: StocksPeriodState.oneMonth,
          selectedTicker: const Ticker('Dummy', 'Dummy'),
        )) {
    on<StockSelected>(
      _onStockSelected,
    );
    on<PeriodChange>(
      _onPeriodSelected,
    );
  }

  FutureOr<void> _onStockSelected(
    StockSelected event,
    Emitter<StockInfoChangeState> emit,
  ) async {
    await _getTickerHistory(event.ticker, state.period, emit);
  }

  FutureOr<void> _onPeriodSelected(
    PeriodChange event,
    Emitter<StockInfoChangeState> emit,
  ) async {
    await _getTickerHistory(state.selectedTicker, event.period, emit);
  }

  Future<void> _getTickerHistory(
      Ticker ticker,
      StocksPeriodState stocksPeriodOption,
      Emitter<StockInfoChangeState> emit) async {
    const pseudoToday = "2014-02-12";
    final response = await http.post(
      Uri.parse('http://localhost:5000/stocks/history'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "ticker": ticker.symbol,
        "start": stocksPeriodOption.startFromEnd(pseudoToday),
        "end": pseudoToday
      }),
    );

    switch (response.statusCode) {
      case 200:
        final chartData = List<TickData>.from(
          Map<String, double>.from(jsonDecode(response.body)['Close'])
              .entries
              .map((entry) => TickData(DateTime.parse(entry.key), entry.value)),
        );
        emit(
          StockInfoChangeState(
            chartData: chartData,
            selectedTicker: ticker,
            period: stocksPeriodOption,
          ),
        );
        containerSelectionBloc.add(StockInfoSelected());
        break;
      case 401:
        //TODO
        break;
      default:
      //TODO
    }
  }
}
