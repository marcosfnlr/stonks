import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/stocks/stocks_listing_bloc.dart';
import '/models/spacing.dart';

class SearchHeader extends StatelessWidget {
  final bool enabled;
  const SearchHeader({required this.enabled, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(Spacing.medium),
        child: TextFormField(
          cursorColor: Theme.of(context).colorScheme.tertiaryContainer,
          enabled: enabled,
          onChanged: (value) {
            final event = StocksListFiltered(filter: value);
            BlocProvider.of<StocksListingBloc>(context).add(event);
          },
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
}
