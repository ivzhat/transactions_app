import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(labelText: 'Логин'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform login logic here
                  // If login is successful, navigate to shell route
                  GoRouter.of(context).go('/transactions');
                },
                child: const Text('Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}