import 'package:intl/intl.dart';

const _monthDayDateFormat = "MMM dd";
const _monthYearDateFormat = "MMM yyyy";
const _yearDateFormat = "yyyy";

enum StocksPeriodState {
  oneMonth(
    timeInterval: 'past month',
    buttonLabel: '1M',
    dateFormat: _monthDayDateFormat,
    durationInDays: 30,
  ),
  sixMonths(
    timeInterval: 'past 6 months',
    buttonLabel: '6M',
    dateFormat: _monthYearDateFormat,
    durationInDays: 180,
  ),
  ytd(
    timeInterval: 'year to date',
    buttonLabel: 'YTD',
    dateFormat: _monthYearDateFormat,
  ),
  oneYear(
    timeInterval: 'past year',
    buttonLabel: '1Y',
    dateFormat: _monthYearDateFormat,
    durationInDays: 365,
  ),
  fiveYears(
    timeInterval: 'past 5 years',
    buttonLabel: '5Y',
    dateFormat: _yearDateFormat,
    durationInDays: 5 * 365,
  ),
  max(
    timeInterval: 'all time',
    buttonLabel: 'Max',
    dateFormat: _yearDateFormat,
  ),
  ;

  final String timeInterval;
  final String buttonLabel;
  final String _dateFormat;
  final int? _durationInDays;

  const StocksPeriodState({
    required this.timeInterval,
    required this.buttonLabel,
    required dateFormat,
    durationInDays,
  })  : _dateFormat = dateFormat,
        _durationInDays = durationInDays;

  DateFormat get dateFormatter {
    return DateFormat(_dateFormat);
  }

  String Function(String) _startFromEndBuilder(int days) => (String endDate) {
        final startDate =
            DateTime.parse(endDate).subtract(Duration(days: days));
        return "${startDate.year}-${startDate.month}-${startDate.day}";
      };

  String Function(String) get startFromEnd {
    if (this == StocksPeriodState.ytd) {
      return (endDate) => "${DateTime.parse(endDate).year}-01-01";
    }
    if (this == StocksPeriodState.max) {
      return (_) => "1500-01-01";
    }
    assert(_durationInDays != null);
    return _startFromEndBuilder(_durationInDays!);
  }
}
