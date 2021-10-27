part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
  });

  AuthState cloneWith({AuthStatus? status, User? user}) => AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [status, user];
}
