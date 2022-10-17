import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/login/login_bloc.dart';
import '/blocs/login/login_state.dart';
import '/components/inprogress_indicator.dart';
import '/components/stonks_logo.dart';
import '/models/spacing.dart';
import '/themes/style.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Style.loginThemeData();
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            navigator: Navigator.of(context),
          );
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Stack(
              children: [
                Center(
                  child: Theme(
                    data: theme,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          StonksLogo(
                              color: theme.colorScheme.primary, size: 100),
                          const SizedBox(height: Spacing.large),
                          if (state.invalidLogin)
                            Text(state.message,
                                style: TextStyle(
                                  color: theme.colorScheme.onError,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center),
                          const LoginForm(),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.inprogress) const InprogressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
