import 'package:flutter/material.dart';
import 'package:stonks/stocks_period_options.dart';
import 'package:stonks/stonks_logo.dart';

import 'chart.dart';
import 'labeled_info.dart';
import 'spacing.dart';
import 'ticker.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({
    Key? key,
    required this.tickers,
  }) : super(key: key);

  final List<Ticker> tickers;

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  bool _isChartFocused = false;
  Ticker? _selectedTicker;
  StocksPeriodOption _selectedPeriod = StocksPeriodOption.oneDay;
  late List<Ticker> _shownTickers;

  @override
  void initState() {
    super.initState();
    _shownTickers = widget.tickers;
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = 150;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            _selectedTicker == null
                ? SizedBox(
                    height: _chartContainerHeight(constraints),
                    child: Center(
                      child: StonksLogo(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          size: _chartContainerHeight(constraints) / 2),
                    ),
                  )
                : GestureDetector(
                    onTapDown: _focusChart(true),
                    child: _buildStockInfo(animationDuration, constraints),
                  ),
            GestureDetector(
              onTapDown: _focusChart(false),
              child: _buildTickerList(animationDuration, constraints),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStockInfo(int animationDuration, BoxConstraints constraints) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      height: _chartContainerHeight(constraints),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Spacing.large,
              horizontal: Spacing.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentValueInfo(),
                _buildChangeInfo(),
                const SizedBox(
                  height: Spacing.large,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildPeriodsChips(),
                  ),
                ),
                const SizedBox(
                  height: Spacing.large,
                ),
                Container(
                  height: 250.0,
                  child: StackedAreaLineChart.withSampleData(
                    onSelectionChanged: _focusChart(true),
                  ),
                ),
                const SizedBox(
                  height: Spacing.large,
                ),
                LabeledInfo(
                  label: 'Symbol',
                  info: _selectedTicker!.symbol,
                ),
                const SizedBox(
                  height: Spacing.small,
                ),
                LabeledInfo(
                  label: 'Name',
                  info: _selectedTicker!.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ChoiceChip> _buildPeriodsChips() {
    return StocksPeriodOption.values
        .map(
          (period) => ChoiceChip(
            label: Text(
              period.buttonLabel,
              style: TextStyle(
                color: _selectedPeriod == period
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
            selected: _selectedPeriod == period,
            selectedColor: Theme.of(context).colorScheme.primary,
            onSelected: (selected) {
              setState(() {
                _selectedPeriod = period;
              });
            },
          ),
        )
        .toList();
  }

  RichText _buildCurrentValueInfo() {
    return RichText(
      text: TextSpan(
        text: _selectedTicker!.currentValue.toStringAsFixed(2),
        style: Theme.of(context).textTheme.headlineLarge,
        children: [
          TextSpan(
              text: ' BRL', style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }

  RichText _buildChangeInfo() {
    final isPositive = _selectedTicker!.change >= 0;
    final color = isPositive ? Colors.green[700] : Colors.red[700];
    final changeValue = _selectedTicker!.change;
    final changeRelative = changeValue + 0.07;
    return RichText(
      text: TextSpan(
        text:
            "${changeValue.toStringAsFixed(2)} (${changeRelative.toStringAsFixed(2)}%)",
        style: TextStyle(color: color),
        children: [
          WidgetSpan(
            child: Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: DefaultTextStyle.of(context).style.fontSize,
            ),
          ),
          TextSpan(text: _selectedPeriod.timeInterval),
        ],
      ),
    );
  }

  Widget _buildTickerList(
    int animationDuration,
    BoxConstraints constraints,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      color: Theme.of(context).colorScheme.secondaryContainer,
      height: _stocksContainerHeight(constraints),
      child: Column(children: [
        _buildSearchHeader(),
        Expanded(
          child: ListView(
            physics: _isChartFocused
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            children: _buildTickersTiles(),
          ),
        ),
      ]),
    );
  }

  Widget _buildSearchHeader() {
    return Material(
      elevation: 2,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(Spacing.medium),
        child: TextFormField(
          cursorColor: Theme.of(context).colorScheme.tertiaryContainer,
          enabled: !_isChartFocused,
          onChanged: (value) => _runFilter(value),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            hintText: 'Search symbol',
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTickersTiles() {
    var tiles = _shownTickers.map((ticker) => ListTile(
          title: Text(ticker.symbol),
          subtitle: Text(ticker.name),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.timeline,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                semanticLabel: 'Ticker chart',
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ticker.change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                color: ticker.change >= 0 ? Colors.green[700] : Colors.red[700],
                semanticLabel:
                    ticker.change >= 0 ? 'Positive change' : 'Negative change',
              ),
              Text(ticker.change.abs().toStringAsFixed(2) + "%",
                  style: TextStyle(
                      color: ticker.change >= 0
                          ? Colors.green[700]
                          : Colors.red[700])),
            ],
          ),
          onTap: () {
            setState(() {
              if (!_isChartFocused) {
                _selectedTicker = ticker;
              }
              _isChartFocused = !_isChartFocused;
            });
          },
        ));
    return ListTile.divideTiles(context: context, tiles: tiles).toList();
  }

  void _runFilter(String value) {
    setState(() {
      _shownTickers = widget.tickers.where((element) {
        value = value.replaceAll(RegExp(r'\s'), '').toLowerCase();
        return _filter(element.symbol.toLowerCase(), value) ||
            _filter(element.name.toLowerCase(), value);
      }).toList();
    });
  }

  bool _filter(String hayStack, String needle) {
    if (needle.isEmpty) return true;
    var index = hayStack.indexOf(needle[0]);
    if (index == -1) return false;
    return _filter(hayStack.substring(index + 1), needle.substring(1));
  }

  void Function(dynamic) _focusChart(bool focusChart) {
    return (_) {
      if (_isChartFocused != focusChart) {
        setState(() {
          _isChartFocused = focusChart;
        });
      }
    };
  }

  double _chartContainerHeight(BoxConstraints constraints) {
    return _isChartFocused
        ? constraints.maxHeight * 0.8
        : constraints.maxHeight * 0.3;
  }

  double _stocksContainerHeight(BoxConstraints constraints) {
    return constraints.maxHeight - _chartContainerHeight(constraints);
  }
}
