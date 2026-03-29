import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/admin/features/home/presentation/views/admin_home_page.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/features/auth/presentation/views/forgot_password_view.dart';
import 'package:edu_match/features/auth/presentation/views/login_view.dart';
import 'package:edu_match/features/auth/presentation/views/register_view.dart';
import 'package:edu_match/parent/features/home/presentation/views/parent_home_page.dart';
import 'package:edu_match/share/layouts/main_layout.dart';
import 'package:edu_match/student/features/home/presentation/views/student_home_page.dart';
import 'package:edu_match/student/features/marketplace/presentation/views/tutor_list_page.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/profile_welcome_view.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/subject_interest_view.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/welcome_view.dart';
import 'package:edu_match/tutor/features/home/presentation/views/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String homeAdmin = '/home/admin';
  static const String homeTutor = '/home/tutor';
  static const String homeParent = '/home/parent';
  static const String homeStudent = '/home/student';
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingSubjectInterest = '/onboarding/subject-interest';
  static const String onboardingProfileSetup = '/onboarding/profile-setup';
  static const String marketplaceTutorList = '/marketplace/tutors';

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
          return const MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            child: RegisterPage(),
          );
        },
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            child: ForgotPasswordPage(),
          );
        },
      ),
      GoRoute(
        path: homeAdmin,
        name: 'homeAdmin',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const AdminHomePage(),
          );
        },
      ),
      GoRoute(
        path: homeTutor,
        name: 'homeTutor',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const TutorHomePage(),
          );
        },
      ),
      GoRoute(
        path: homeParent,
        name: 'homeParent',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const ParentHomePage(),
          );
        },
      ),
      GoRoute(
        path: homeStudent,
        name: 'homeStudent',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const StudentHomePage(),
          );
        },
      ),
      GoRoute(
        path: onboardingWelcome,
        name: 'onboardingWelcome',
        builder: (context, state) {
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            useSafeArea: false,
            child: OnboardingWelcomePage(role: role),
          );
        },
      ),
      GoRoute(
        path: onboardingSubjectInterest,
        name: 'onboardingSubjectInterest',
        builder: (context, state) {
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            useSafeArea: false,
            child: SubjectInterestPage(role: role),
          );
        },
      ),
      GoRoute(
        path: onboardingProfileSetup,
        name: 'onboardingProfileSetup',
        builder: (context, state) {
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            useSafeArea: false,
            child: ProfileSetupPage(role: role),
          );
        },
      ),
      GoRoute(
        path: marketplaceTutorList,
        name: 'marketplaceTutorList',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const TutorListPage(),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => AppRouter.buildErrorPage(),
  );
}

