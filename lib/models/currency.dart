enum Currency {
  usd,
  brl,
}

extension CurrencyExtension on Currency {
  String get label {
    switch (this) {
      case Currency.usd:
        return 'USD';
      case Currency.brl:
        return 'BRL';
    }
  }

  String get symbol {
    switch (this) {
      case Currency.usd:
        return '\$';
      case Currency.brl:
        return 'R\$';
    }
  }
}
