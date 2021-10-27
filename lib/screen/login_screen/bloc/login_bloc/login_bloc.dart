import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppFireBaseAuthService _auth = AppFireBaseAuthService();
  LoginBloc() : super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield state.cloneWith(LoginStatus.loading);
      final isLoginSuccess = await _auth.login(event.email, event.password);
      if (isLoginSuccess) {
        yield state.cloneWith(LoginStatus.success);
      } else {
        yield state.cloneWith(LoginStatus.failure);
      }
    }
  }
}
