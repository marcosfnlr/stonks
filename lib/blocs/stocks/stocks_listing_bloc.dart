import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '/models/ticker.dart';
import 'stocks_listing_sate.dart';

abstract class StocksListingEvent {
  const StocksListingEvent();
}

class _StocksListRequested extends StocksListingEvent {
  const _StocksListRequested();
}

class StocksListFiltered extends StocksListingEvent {
  final String filter;
  const StocksListFiltered({required this.filter});
}

class StocksListingBloc extends Bloc<StocksListingEvent, StocksListingState> {
  late final List<Ticker> _tickers;

  StocksListingBloc() : super(const StocksListingState(shownTickers: [])) {
    on<StocksListFiltered>(_onTickerListFiltered);
    on<_StocksListRequested>(_onStocksListRequested);
    add(const _StocksListRequested());
  }

  FutureOr<void> _onTickerListFiltered(
    StocksListFiltered event,
    Emitter<StocksListingState> emit,
  ) {
    emit(
      StocksListingState(
        shownTickers: _tickers.where(
          (ticker) {
            final filter =
                event.filter.replaceAll(RegExp(r'\s'), '').toLowerCase();
            final symbolContainsFilter =
                _filter(ticker.symbol.toLowerCase(), filter);
            final nameContainsFilter =
                _filter(ticker.name.toLowerCase(), filter);
            return symbolContainsFilter || nameContainsFilter;
          },
        ).toList(),
      ),
    );
  }

  bool _filter(String hayStack, String needle) {
    if (needle.isEmpty) return true;
    var index = hayStack.indexOf(needle[0]);
    if (index == -1) return false;
    return _filter(hayStack.substring(index + 1), needle.substring(1));
  }

  Future<void> _onStocksListRequested(
    _StocksListRequested event,
    Emitter<StocksListingState> emit,
  ) async {
    final response = await http.get(
      Uri.parse('http://localhost:5000/stocks/list'),
    );

    switch (response.statusCode) {
      case 200:
        final stocks = List<Ticker>.from(
            (jsonDecode(response.body)['stocks'] as List<dynamic>)
                .map((json) => Ticker.fromJson(json)));
        _tickers = stocks;
        emit(StocksListingState(shownTickers: stocks));
        break;
      case 400:
        //TODO
        break;
      default:
      //TODO
    }
  }
}
