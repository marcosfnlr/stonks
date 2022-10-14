import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/period_chip_change_bloc.dart';
import '/blocs/stocks/stock_info_change_bloc.dart';
import '/blocs/stocks/stocks_period_state.dart';

class PeriodChips extends StatelessWidget {
  const PeriodChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocProvider(
        create: (context) => PeriodChipChangeBloc(),
        child: Row(
          children: StocksPeriodState.values.map((period) {
            return BlocBuilder<PeriodChipChangeBloc, StocksPeriodState>(
              builder: (context, state) {
                return ChoiceChip(
                  label: Text(
                    period.buttonLabel,
                    style: TextStyle(
                      color: state == period
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
                  ),
                  selected: state == period,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  onSelected: (selected) {
                    BlocProvider.of<PeriodChipChangeBloc>(context)
                        .add(PeriodChipSelected(period: period));
                    BlocProvider.of<StockInfoChangeBloc>(context)
                        .add(PeriodChange(period: period));
                  },
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
