import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/container_selection_bloc.dart';
import '/blocs/stocks/container_selection_state.dart';
import '/blocs/stocks/stock_info_change_bloc.dart';
import '/blocs/stocks/stocks_listing_bloc.dart';
import '/blocs/stocks/stocks_listing_sate.dart';

class StocksTiles extends StatelessWidget {
  final ScrollPhysics _scrollPhysics;

  const StocksTiles({required scrollPhysics, super.key})
      : _scrollPhysics = scrollPhysics;

  @override
  Widget build(BuildContext context) {
    final change = Random().nextDouble() * 10 - 5;
    final isPositive = change >= 0;
    return BlocBuilder<StocksListingBloc, StocksListingState>(
      builder: ((context, state) {
        final tiles = state.shownTickers.map((ticker) => ListTile(
              title: Text(ticker.symbol),
              subtitle: Text(ticker.name),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.timeline,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    semanticLabel: 'Ticker chart',
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive ? Colors.green[700] : Colors.red[700],
                    semanticLabel:
                        isPositive ? 'Positive change' : 'Negative change',
                  ),
                  Text(change.abs().toStringAsFixed(2) + "%",
                      style: TextStyle(
                        color: isPositive ? Colors.green[700] : Colors.red[700],
                      )),
                ],
              ),
              onTap: () {
                final containerSelectionBloc =
                    BlocProvider.of<ContainerSelectionBloc>(context);
                if (containerSelectionBloc.state ==
                    ContainerSelectionState.stockInfoFocused) {
                  containerSelectionBloc.add(TickerListSelected());
                } else {
                  BlocProvider.of<StockInfoChangeBloc>(context)
                      .add(StockSelected(ticker: ticker));
                }
              },
            ));
        return ListView(
          physics: _scrollPhysics,
          children:
              ListTile.divideTiles(context: context, tiles: tiles).toList(),
        );
      }),
    );
  }
}
