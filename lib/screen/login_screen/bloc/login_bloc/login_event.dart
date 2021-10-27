part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);
}
