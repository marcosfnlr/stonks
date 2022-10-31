class Ticker {
  final String symbol;
  final String name;

  const Ticker(this.symbol, this.name);

  factory Ticker.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final formatedName = name.splitMapJoin(
      RegExp(r'\s+'),
      onMatch: (_) => ' ',
      onNonMatch: (w) => w.length > 3 &&
              w.contains(
                RegExp(
                  '[aeiou]',
                  caseSensitive: false,
                ),
              )
          ? "${w[0]}${w.substring(1).toLowerCase()}"
          : w,
    );
    return Ticker(json['symbol'], formatedName);
  }
}
