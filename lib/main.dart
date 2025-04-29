import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'modules/auth/pages/splash_page.dart';
import 'modules/auth/pages/login_page.dart';
import 'modules/auth/pages/forgot_password_page.dart';

void main() {
  runApp(const MeuBarbeiroApp());
}

class MeuBarbeiroApp extends StatelessWidget {
  const MeuBarbeiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Barbeiro',
      theme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
      },
    );
  }
}
