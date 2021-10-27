part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  const LoginState({this.status = LoginStatus.initial});

  LoginState cloneWith(LoginStatus? status) =>
      LoginState(status: status ?? this.status);
}
