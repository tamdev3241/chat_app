part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthenticationApp extends AuthEvent {}
