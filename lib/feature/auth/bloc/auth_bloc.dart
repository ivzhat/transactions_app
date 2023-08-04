import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    late SharedPreferences prefs;

    on<AuthAppInitialized>((event, emit) async {
      emit(AuthInitial());
       prefs = await event.prefs;
      if(prefs.get('auth') == 'SKo102IGuK1))r') {
        emit(AuthAuthorized());
      } else {
        emit(AuthUnauthorized());
      }
    });

    on<AuthLoginTapped>((event, emit) async {
      const login = 'user123';
      const password = '12345678';
      if(login == event.login && password == event.password) {
        prefs.setString('auth', 'SKo102IGuK1))r');
        emit(AuthAuthorized());
      } else {
        emit(AuthFailure());
        emit(AuthUnauthorized());
      }
    });

    on<AuthLogoutTapped>((event, emit) async {
      prefs.remove('auth');
      emit(AuthUnauthorized());
    });
  }
}
