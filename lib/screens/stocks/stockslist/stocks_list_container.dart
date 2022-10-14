import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/stocks_listing_bloc.dart';
import '/models/ticker.dart';
import '../stockslist/stocks_tiles.dart';
import 'search_header.dart';

class StocksListContainer extends StatelessWidget {
  final Duration _animationDuration;
  final double _containerHeight;
  final bool _isFocused;

  const StocksListContainer({
    required animationDuration,
    required containerHeight,
    required isFocused,
    super.key,
  })  : _animationDuration = animationDuration,
        _containerHeight = containerHeight,
        _isFocused = isFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      color: Theme.of(context).colorScheme.secondaryContainer,
      height: _containerHeight,
      child: BlocProvider(
        create: (context) => StocksListingBloc(tickers: _mockTickers()),
        child: Column(
          children: [
            SearchHeader(enabled: _isFocused),
            Expanded(
              child: StocksTiles(
                scrollPhysics: _isFocused
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Ticker> _mockTickers() {
    return [
      {
        'symbol': 'PETR4.SA',
        'name': 'Petróleo Brasileiro S.A.',
      },
      {
        'symbol': 'PETR3.SA',
        'name': 'Petrobras',
      },
      {
        'symbol': 'VALE3.SA',
        'name': 'Vale S.A.',
      },
      {
        'symbol': 'BBAS3.SA',
        'name': 'Banco do Brasil S.A.',
      },
      {
        'symbol': 'PETR4.SA',
        'name': 'Petróleo Brasileiro S.A.',
      },
      {
        'symbol': 'PETR3.SA',
        'name': 'Petrobras',
      },
      {
        'symbol': 'VALE3.SA',
        'name': 'Vale S.A.',
      },
      {
        'symbol': 'BBAS3.SA',
        'name': 'Banco do Brasil S.A.',
      },
    ].map((tick) => Ticker(tick['symbol']!, tick['name']!)).toList();
  }
}
