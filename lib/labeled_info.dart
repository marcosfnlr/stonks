import 'package:flutter/material.dart';

import 'spacing.dart';

class LabeledInfo extends StatelessWidget {
  const LabeledInfo({
    Key? key,
    required this.label,
    required this.info,
  }) : super(key: key);

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: Spacing.small,
              top: Spacing.small,
            ),
            child: Text(info),
          ),
        ],
      ),
    );
  }
}