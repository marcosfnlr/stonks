enum StocksPeriodOption {
  oneDay,
  fiveDays,
  oneMonth,
  sixMonths,
  oneYear,
  fiveYears,
  max,
}

extension StocksPeriodOptionExtension on StocksPeriodOption {
  String get timeInterval {
    switch (this) {
      case StocksPeriodOption.oneDay:
        return 'today';
      case StocksPeriodOption.fiveDays:
        return 'past 5 days';
      case StocksPeriodOption.oneMonth:
        return 'past month';
      case StocksPeriodOption.sixMonths:
        return 'past 6 months';
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
      case StocksPeriodOption.oneDay:
        return '1D';
      case StocksPeriodOption.fiveDays:
        return '5D';
      case StocksPeriodOption.oneMonth:
        return '1M';
      case StocksPeriodOption.sixMonths:
        return '6M';
      case StocksPeriodOption.oneYear:
        return '1Y';
      case StocksPeriodOption.fiveYears:
        return '5Y';
      case StocksPeriodOption.max:
        return 'max';
    }
  }
}
