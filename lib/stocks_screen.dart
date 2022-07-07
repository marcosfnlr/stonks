import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chart.dart';
import 'labeled_info.dart';
import 'spacing.dart';
import 'stocks_period_options.dart';
import 'stonks_logo.dart';
import 'tick_data.dart';
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
  bool _isStockInfoFocused = false;
  Ticker? _selectedTicker;
  List<TickData>? _chartData;
  StocksPeriodOption _shownPeriod = StocksPeriodOption.oneMonth;
  StocksPeriodOption _selectedPeriodBtn = StocksPeriodOption.oneMonth;
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
        final hasInfo = _selectedTicker != null;
        return Column(
          children: [
            GestureDetector(
              onTapDown: hasInfo ? _focusStockInfo(true) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: animationDuration),
                height: _stockInfoContainerHeight(constraints),
                child: hasInfo
                    ? _buildStockInfo(constraints)
                    : Center(
                        child: StonksLogo(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            size: _stockInfoContainerHeight(constraints) / 2),
                      ),
              ),
            ),
            GestureDetector(
              onTapDown: _focusStockInfo(false),
              child: _buildTickerList(animationDuration, constraints),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStockInfo(BoxConstraints constraints) {
    return ListView(
      physics: _isStockInfoFocused
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
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
              SizedBox(
                height: 250.0,
                child: StackedAreaLineChart(
                  _chartData!,
                  dateFormater: _shownPeriod.dateFormatter,
                  onSelectionChanged: _focusStockInfo(true),
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
    );
  }

  List<ChoiceChip> _buildPeriodsChips() {
    return StocksPeriodOption.values
        .map(
          (period) => ChoiceChip(
            label: Text(
              period.buttonLabel,
              style: TextStyle(
                color: _selectedPeriodBtn == period
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
            selected: _selectedPeriodBtn == period,
            selectedColor: Theme.of(context).colorScheme.primary,
            onSelected: (selected) {
              setState(() {
                _selectedPeriodBtn = period;
                _getTickerHistory(_selectedTicker!, period);
              });
            },
          ),
        )
        .toList();
  }

  RichText _buildCurrentValueInfo() {
    final currentValue = _chartData!.last.value;
    return RichText(
      text: TextSpan(
        text: currentValue.toStringAsFixed(2),
        style: Theme.of(context).textTheme.headlineLarge,
        children: [
          TextSpan(
            text: ' BRL',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  RichText _buildChangeInfo() {
    final firstValue = _chartData!.first.value;
    final lastValue = _chartData!.last.value;
    final changeValue = lastValue - firstValue;
    final isPositive = changeValue >= 0;
    final color = isPositive ? Colors.green[700] : Colors.red[700];
    final percentageRelative = (lastValue / firstValue - 1) * 100;
    return RichText(
      text: TextSpan(
        text:
            "${changeValue.toStringAsFixed(2)} (${percentageRelative.toStringAsFixed(2)}%)",
        style: TextStyle(color: color),
        children: [
          WidgetSpan(
            child: Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: DefaultTextStyle.of(context).style.fontSize,
            ),
          ),
          TextSpan(text: _shownPeriod.timeInterval),
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
      child: Column(
        children: [
          _buildSearchHeader(),
          Expanded(
            child: ListView(
              physics: _isStockInfoFocused
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              children: _buildTickersTiles(),
            ),
          ),
        ],
      ),
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
          enabled: !_isStockInfoFocused,
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
    final change = Random().nextDouble() * 10 - 5;
    final isPositive = change >= 0;
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
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green[700] : Colors.red[700],
                semanticLabel:
                    isPositive ? 'Positive change' : 'Negative change',
              ),
              Text(change.abs().toStringAsFixed(2) + "%",
                  style: TextStyle(
                    color: isPositive ? Colors.green[700] : Colors.red[700],
                  )),
            ],
          ),
          onTap: () {
            if (_isStockInfoFocused) {
              setState(() {
                _isStockInfoFocused = false;
              });
            } else {
              _getTickerHistory(ticker);
            }
          },
        ));
    return ListTile.divideTiles(context: context, tiles: tiles).toList();
  }

  void _getTickerHistory(Ticker ticker, [StocksPeriodOption? period]) {
    //TODO unordered responses
    const pseudoToday = "2014-02-12";
    http
        .post(
          Uri.parse('http://localhost:5000/stocks/history'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "ticker": ticker.symbol,
            "start": (period ?? _shownPeriod).startFromEnd(pseudoToday),
            "end": pseudoToday
          }),
        )
        .then((response) => _stocksResponse(response, ticker, period));
  }

  void _stocksResponse(response, ticker, [StocksPeriodOption? period]) {
    switch (response.statusCode) {
      case 200:
        setState(() {
          _chartData = List.from(
            Map<String, double>.from(jsonDecode(response.body)['Close'])
                .entries
                .map((entry) =>
                    TickData(DateTime.parse(entry.key), entry.value)),
          );
          _selectedTicker = ticker;
          _isStockInfoFocused = true;
          if (period != null) {
            _shownPeriod = period;
          }
        });
        break;
      case 401:
        //TODO
        break;
      default:
      //TODO
    }
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

  void Function(dynamic) _focusStockInfo(bool focusChart) {
    return (_) {
      if (_isStockInfoFocused != focusChart) {
        setState(() {
          _isStockInfoFocused = focusChart;
        });
      }
    };
  }

  double _stockInfoContainerHeight(BoxConstraints constraints) {
    return _isStockInfoFocused
        ? constraints.maxHeight * 0.8
        : constraints.maxHeight * 0.3;
  }

  double _stocksContainerHeight(BoxConstraints constraints) {
    return constraints.maxHeight - _stockInfoContainerHeight(constraints);
  }
}
