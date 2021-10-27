import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppFireBaseAuthService _auth = AppFireBaseAuthService();
  AuthBloc() : super(const AuthState());
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthenticationApp) {
      yield state.cloneWith(status: AuthStatus.loading);
      try {
        final user = _auth.getCurrenUser();
        if (user != null) {
          yield state.cloneWith(status: AuthStatus.success, user: user);
        } else {
          yield state.cloneWith(status: AuthStatus.failure);
        }
      } catch (e) {
        yield state.cloneWith(status: AuthStatus.failure);
      }
    }
  }
}
