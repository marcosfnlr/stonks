import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/userdata/user_data_bloc.dart';
import '/components/labeled_info.dart';
import '/models/spacing.dart';
import 'security_panel.dart';
import 'wallet_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

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
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) => WalletCard(
                          prefix: state.user.currencySymbol,
                          mainText: state.user.balance.toStringAsFixed(2),
                          label: '(${state.user.currencyLabel})',
                          alignment: MainAxisAlignment.end,
                        ),
                      ),
                      const VerticalDivider(),
                      WalletCard(
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
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) => Text(
                          state.user.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
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
                                BlocBuilder<UserDataBloc, UserDataState>(
                                  builder: (context, state) => LabeledInfo(
                                    label: 'Email',
                                    info: state.user.email,
                                  ),
                                ),
                                const SizedBox(height: Spacing.small),
                                BlocBuilder<UserDataBloc, UserDataState>(
                                  builder: (context, state) => LabeledInfo(
                                    label: 'Language',
                                    info: state.user.preferredLanguage,
                                  ),
                                ),
                                const SizedBox(height: Spacing.small),
                                BlocBuilder<UserDataBloc, UserDataState>(
                                  builder: (context, state) => LabeledInfo(
                                    label: 'Currency',
                                    info: state.user.currencyString,
                                  ),
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
}
