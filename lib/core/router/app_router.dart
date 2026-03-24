import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/features/auth/presentation/views/login_view.dart';
import 'package:edu_match/features/home/presentation/views/home_view.dart';
import 'package:edu_match/share/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String login = '/login';
  static const String home = '/home';

  /// Build error page widget
  /// Can be reused for different error scenarios
  static Widget buildErrorPage({String? message}) {
    return Scaffold(
      body: Center(
        child: Text(message ?? 'Page not found'),
      ),
    );
  }

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: login, // ✅ Screen default 
    debugLogDiagnostics: true, // Debug mode

    redirect: (BuildContext context, GoRouterState state) {
      // TODO: Check if user is logged in
      // final isLoggedIn = ... get from storage or provider
      // if (!isLoggedIn && state.location != login) {
      //   return login;
      // }
      return null; // No redirect
    },

    routes: [
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const HomePage(),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => AppRouter.buildErrorPage(),
  );
}

