import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/container_selection_state.dart';
import '/blocs/stocks/container_selection_bloc.dart';
import '/blocs/stocks/stock_info_change_bloc.dart';
import 'stockslist/stocks_list_container.dart';
import 'stockinfo/stock_display_container.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 150);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ContainerSelectionBloc()),
            BlocProvider(
              create: (context) => StockInfoChangeBloc(
                containerSelectionBloc:
                    BlocProvider.of<ContainerSelectionBloc>(context),
              ),
            )
          ],
          child: BlocBuilder<ContainerSelectionBloc, ContainerSelectionState>(
            builder: (context, state) => Column(
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    if (state.hasInfo) {
                      BlocProvider.of<ContainerSelectionBloc>(context)
                          .add(StockInfoSelected());
                    }
                  },
                  child: StockDisplayContainer(
                    animationDuration: animationDuration,
                    height: state.stockInfoContainerHeight(constraints),
                    showInfo: state.hasInfo,
                    isFocused:
                        state == ContainerSelectionState.stockInfoFocused,
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) =>
                      BlocProvider.of<ContainerSelectionBloc>(context)
                          .add(TickerListSelected()),
                  child: StocksListContainer(
                    animationDuration: animationDuration,
                    containerHeight:
                        state.stocksListContainerHeight(constraints),
                    isFocused:
                        state != ContainerSelectionState.stockInfoFocused,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
