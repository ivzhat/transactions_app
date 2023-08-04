part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUnauthorized extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthAuthorized extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  final String message = 'Неверный логин или пароль';
  @override
  List<Object> get props => [];
}
