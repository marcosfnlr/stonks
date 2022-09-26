import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_state.dart';
import '../../components/inprogress_indicator.dart';
import '../../components/stonks_logo.dart';
import '../../models/spacing.dart';
import '../../themes/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Style.loginThemeData();
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            loginController: _loginController,
            passController: _passController,
            formKey: _formKey,
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
                          LoginForm(
                            emailController: _loginController,
                            passController: _passController,
                            formKey: _formKey,
                          ),
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
