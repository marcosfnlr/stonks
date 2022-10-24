import 'package:flutter/material.dart';

import '/models/spacing.dart';

class WalletCard extends StatelessWidget {
  final String mainText;
  final String? prefix;
  final String? label;
  final IconData? icon;
  final bool? succed;
  final MainAxisAlignment alignment;

  const WalletCard({
    Key? key,
    required this.mainText,
    this.prefix,
    this.label,
    this.icon,
    this.succed,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainStyle = Theme.of(context).textTheme.headlineMedium!;
    var prefixStyle = Theme.of(context).textTheme.titleLarge!;
    var labelStyle = Theme.of(context).textTheme.labelMedium!;
    if (succed != null) {
      mainStyle = mainStyle.copyWith(
        color: succed! ? Colors.green[700] : Colors.red[700],
      );
      prefixStyle = prefixStyle.copyWith(
        color: succed! ? Colors.green[700] : Colors.red[700],
      );
      labelStyle = labelStyle.copyWith(
        color: succed! ? Colors.green : Colors.red,
      );
    }
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(Spacing.medium),
        child: Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '$prefix ',
                    style: prefixStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: mainText,
                        style: mainStyle,
                      ),
                    ],
                  ),
                ),
                if (label != null)
                  Text(
                    label!,
                    style: labelStyle,
                  ),
              ],
            ),
            if (icon != null)
              Icon(
                icon,
                color: mainStyle.color,
                size: mainStyle.fontSize,
              ),
          ],
        ),
      ),
    );
  }
}
