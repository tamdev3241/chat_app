part of 'signup_bloc.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState {
  final SignUpStatus status;
  const SignUpState({this.status = SignUpStatus.initial});

  SignUpState cloneWith(SignUpStatus? status) =>
      SignUpState(status: status ?? this.status);
}
