import '/models/tick_data.dart';
import '/models/ticker.dart';
import 'stocks_period_state.dart';

class StockInfoChangeState {
  final List<TickData> chartData;
  final Ticker selectedTicker;
  final StocksPeriodState period;

  StockInfoChangeState({
    required this.chartData,
    required this.selectedTicker,
    required this.period,
  });
}
