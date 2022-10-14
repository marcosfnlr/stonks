import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/container_selection_bloc.dart';
import '/blocs/stocks/stock_info_change_bloc.dart';
import '/blocs/stocks/stock_info_change_sate.dart';
import '/components/labeled_info.dart';
import '/models/spacing.dart';
import '../chart.dart';
import 'change_value_info.dart';
import 'current_value_info.dart';
import 'period_chips.dart';

class StockInfo extends StatelessWidget {
  final ScrollPhysics _scrollPhysics;

  const StockInfo({
    required scrollPhysics,
    super.key,
  }) : _scrollPhysics = scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: _scrollPhysics,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.large,
            horizontal: Spacing.medium,
          ),
          child: BlocBuilder<StockInfoChangeBloc, StockInfoChangeState>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentValueInfo(currentValue: state.chartData.first.value),
                ChangeValueInfo(
                  firstValue: state.chartData.first.value,
                  lastValue: state.chartData.last.value,
                  timeInterval: state.period.timeInterval,
                ),
                const SizedBox(
                  height: Spacing.large,
                ),
                const PeriodChips(),
                const SizedBox(
                  height: Spacing.large,
                ),
                SizedBox(
                  height: 250.0,
                  child: StackedAreaLineChart(
                    state.chartData,
                    dateFormater: state.period.dateFormatter,
                    onSelectionChanged: (_) =>
                        BlocProvider.of<ContainerSelectionBloc>(context)
                            .add(StockInfoSelected()),
                  ),
                ),
                const SizedBox(
                  height: Spacing.large,
                ),
                LabeledInfo(
                  label: 'Symbol',
                  info: state.selectedTicker.symbol,
                ),
                const SizedBox(
                  height: Spacing.small,
                ),
                LabeledInfo(
                  label: 'Name',
                  info: state.selectedTicker.name,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
