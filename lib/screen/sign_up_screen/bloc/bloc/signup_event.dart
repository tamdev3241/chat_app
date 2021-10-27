part of 'signup_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpUserEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpUserEvent(this.email, this.password);
}
