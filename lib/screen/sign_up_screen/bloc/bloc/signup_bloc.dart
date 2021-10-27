import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/firebase_auth.dart';
part 'SignUp_event.dart';
part 'SignUp_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AppFireBaseAuthService _auth = AppFireBaseAuthService();
  SignUpBloc() : super(const SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpUserEvent) {
      yield state.cloneWith(SignUpStatus.loading);
      final isSignUpSuccess = await _auth.signUp(event.email, event.password);
      if (isSignUpSuccess) {
        yield state.cloneWith(SignUpStatus.success);
      } else {
        yield state.cloneWith(SignUpStatus.failure);
      }
    }
  }
}
