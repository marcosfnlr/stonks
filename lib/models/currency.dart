enum Currency {
  usd(label: 'USD', symbol: '\$'),
  brl(label: 'BRL', symbol: 'R\$');

  final String label;
  final String symbol;

  const Currency({required this.label, required this.symbol});
}
