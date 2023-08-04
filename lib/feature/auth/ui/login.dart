import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  getAuthToken() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthAppInitialized(getAuthToken()));
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message)
              )
            );
          } else if(state is AuthAuthorized) {
            _loginController.clear();
            _passwordController.clear();
            GoRouter.of(context).go('/transactions');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _loginController,
                      decoration: const InputDecoration(labelText: 'Логин'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Пароль'),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40), // NEW
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(AuthLoginTapped(
                            _loginController.text, _passwordController.text)
                          );
                        },
                        child: const Text('Войти'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}