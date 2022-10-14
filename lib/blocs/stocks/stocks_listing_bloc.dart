import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/ticker.dart';
import 'stocks_listing_sate.dart';

abstract class StocksListingEvent {
  const StocksListingEvent();
}

class StocksListFiltered extends StocksListingEvent {
  final String filter;
  const StocksListFiltered({required this.filter});
}

class StocksListingBloc extends Bloc<StocksListingEvent, StocksListingState> {
  final List<Ticker> _tickers;

  StocksListingBloc({required tickers})
      : _tickers = tickers,
        super(StocksListingState(shownTickers: tickers)) {
    on<StocksListFiltered>(_onTickerListFiltered);
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
}
