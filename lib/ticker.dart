class Ticker {
  final String symbol;
  final String name;
  final double change;
  final double currentValue;

  Ticker(this.symbol, this.name, this.change, [this.currentValue = 29.73]);
}
