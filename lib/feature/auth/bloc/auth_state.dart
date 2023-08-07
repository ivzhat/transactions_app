part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthUnauthorized extends AuthState {}

class AuthAuthorized extends AuthState {}

class AuthFailure extends AuthState {
  final String message = 'Неверный логин или пароль';
}
