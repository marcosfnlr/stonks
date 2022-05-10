import 'dart:math';

import 'package:flutter/material.dart';

import 'labeled_info.dart';
import 'security_panel.dart';
import 'spacing.dart';
import 'user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    var isPos = Random().nextBool();
    const avatarRadius = 70.0;
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.fromLTRB(
            Spacing.large,
            Spacing.large,
            Spacing.large,
            Spacing.large + avatarRadius,
          ),
          child: Card(
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Spacing.small),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _walletCard(
                        context,
                        prefix: user.currencySymbol,
                        mainText: user.balance.toStringAsFixed(2),
                        label: '(${user.currencyLabel})',
                        alignment: MainAxisAlignment.end,
                      ),
                      const VerticalDivider(),
                      _walletCard(
                        context,
                        prefix: isPos ? '+' : '-',
                        mainText: '4.71',
                        label: 'past month',
                        icon: isPos ? Icons.arrow_upward : Icons.arrow_downward,
                        succed: isPos,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    Spacing.large,
                    Spacing.medium + avatarRadius,
                    Spacing.large,
                    Spacing.large,
                  ),
                  child: Column(
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabeledInfo(
                                  label: 'Email',
                                  info: user.email,
                                ),
                                const SizedBox(height: Spacing.small),
                                LabeledInfo(
                                  label: 'Language',
                                  info: user.preferredLanguage,
                                ),
                                const SizedBox(height: Spacing.small),
                                LabeledInfo(
                                  label: 'Currency',
                                  info: user.currencyString,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Spacing.large),
                          Ink(
                            decoration: ShapeDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SecurityPanel(),
              ],
            ),
            const Positioned(
              top: -avatarRadius,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage:
                    NetworkImage('https://picsum.photos/250?image=2'),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _walletCard(
    BuildContext context, {
    String mainText = '',
    String? prefix,
    String? label,
    IconData? icon,
    bool? succed,
    MainAxisAlignment alignment = MainAxisAlignment.start,
  }) {
    var mainStyle = Theme.of(context).textTheme.headlineMedium!;
    var prefixStyle = Theme.of(context).textTheme.titleLarge!;
    var labelStyle = Theme.of(context).textTheme.labelMedium!;
    if (succed != null) {
      mainStyle = mainStyle.copyWith(
        color: succed ? Colors.green[700] : Colors.red[700],
      );
      prefixStyle = prefixStyle.copyWith(
        color: succed ? Colors.green[700] : Colors.red[700],
      );
      labelStyle = labelStyle.copyWith(
        color: succed ? Colors.green : Colors.red,
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
                    label,
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
