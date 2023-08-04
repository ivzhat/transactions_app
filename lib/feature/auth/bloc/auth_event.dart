part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthAppInitialized extends AuthEvent {
  const AuthAppInitialized(this.prefs);

  final Future<dynamic> prefs;
  @override
  List<Object?> get props => [];
}

class AuthLoginTapped extends AuthEvent{
  const AuthLoginTapped(this.login, this.password);

  final String login;
  final String password;
  @override
  List<Object?> get props => [];
}

class AuthLogoutTapped extends AuthEvent{
  @override
  List<Object?> get props => [];
}
