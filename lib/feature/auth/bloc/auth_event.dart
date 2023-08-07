part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthAppInitialized extends AuthEvent {
  const AuthAppInitialized(this.prefs);

  final Future<dynamic> prefs;
}

class AuthLoginTapped extends AuthEvent{
  const AuthLoginTapped(this.login, this.password);

  final String login;
  final String password;
}

class AuthLogoutTapped extends AuthEvent{}
