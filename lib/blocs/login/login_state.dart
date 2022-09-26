class LoginState {
  static const standard = LoginState();
  static const waitingResponse = LoginState(inprogress: true);

  final bool invalidLogin;
  final bool inprogress;
  final bool requestError;
  final String message;

  const LoginState({
    this.invalidLogin = false,
    this.inprogress = false,
    this.requestError = false,
    this.message = "",
  });

  const LoginState.serverValidationFail({required message})
      : this(
          message: message,
          invalidLogin: true,
        );

  const LoginState.errorWithMessage({required message})
      : this(
          message: message,
          requestError: true,
        );
}
