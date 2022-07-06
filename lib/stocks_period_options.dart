import 'package:intl/intl.dart';

enum StocksPeriodOption {
  oneMonth,
  sixMonths,
  ytd,
  oneYear,
  fiveYears,
  max,
}

extension StocksPeriodOptionExtension on StocksPeriodOption {
  String get timeInterval {
    switch (this) {
      case StocksPeriodOption.oneMonth:
        return 'past month';
      case StocksPeriodOption.sixMonths:
        return 'past 6 months';
      case StocksPeriodOption.ytd:
        return 'year to date';
      case StocksPeriodOption.oneYear:
        return 'past year';
      case StocksPeriodOption.fiveYears:
        return 'past 5 years';
      case StocksPeriodOption.max:
        return 'all time';
    }
  }

  String get buttonLabel {
    switch (this) {
      case StocksPeriodOption.oneMonth:
        return '1M';
      case StocksPeriodOption.sixMonths:
        return '6M';
      case StocksPeriodOption.ytd:
        return 'YTD';
      case StocksPeriodOption.oneYear:
        return '1Y';
      case StocksPeriodOption.fiveYears:
        return '5Y';
      case StocksPeriodOption.max:
        return 'Max';
    }
  }

  DateFormat get dateFormatter {
    switch (this) {
      case StocksPeriodOption.oneMonth:
        return DateFormat("MMM dd");
      case StocksPeriodOption.sixMonths:
      case StocksPeriodOption.ytd:
      case StocksPeriodOption.oneYear:
        return DateFormat("MMM yyyy");
      case StocksPeriodOption.fiveYears:
      case StocksPeriodOption.max:
        return DateFormat("yyyy");
    }
  }

  String Function(String) _startFromEndBuilder(int days) => (String endDate) {
        final startDate =
            DateTime.parse(endDate).subtract(Duration(days: days));
        return "${startDate.year}-${startDate.month}-${startDate.day}";
      };

  String Function(String) get startFromEnd {
    switch (this) {
      case StocksPeriodOption.oneMonth:
        return _startFromEndBuilder(30);
      case StocksPeriodOption.sixMonths:
        return _startFromEndBuilder(180);
      case StocksPeriodOption.ytd:
        return (endDate) => "${DateTime.parse(endDate).year}-01-01";
      case StocksPeriodOption.oneYear:
        return _startFromEndBuilder(365);
      case StocksPeriodOption.fiveYears:
        return _startFromEndBuilder(5 * 365);
      case StocksPeriodOption.max:
        return (_) => "1500-01-01";
    }
  }
}
