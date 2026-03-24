import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),
            TextButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}