import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/admin/features/home/presentation/views/admin_home_page.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/features/auth/presentation/views/forgot_password_view.dart';
import 'package:edu_match/features/auth/presentation/views/login_view.dart';
import 'package:edu_match/features/auth/presentation/views/register_view.dart';
import 'package:edu_match/parent/features/home/presentation/views/parent_home_page.dart';
import 'package:edu_match/share/layouts/main_layout.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/choice_learning_method.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/confirm_info_booking.dart';
import 'package:edu_match/student/features/payment/presentation/views/payment_page.dart';
import 'package:edu_match/student/features/payment/presentation/views/payment_successful_page.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/request_learning_requirement.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/select_time_slot.dart';
import 'package:edu_match/student/features/home/presentation/views/student_home_page.dart';
import 'package:edu_match/student/features/list_tutor/presentation/views/tutor_list_page.dart';
import 'package:edu_match/student/features/list_courses/presentation/views/list_course_page.dart';
import 'package:edu_match/student/features/feedback/presentation/views/list_feedback.dart';
import 'package:edu_match/student/features/tutor_details/presentation/views/tutor_details_page.dart';
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
  static const String marketplaceTutorDetails = '/marketplace/tutor-details/:tutorId';
  static const String courseList = '/courses';
  static const String feedbackList = '/tutor/:tutorId/feedback';
  static const String bookingLearningMethod = '/booking/learning-method';
  static const String bookingSelectTimeSlot = '/booking/select-time-slot';
  static const String bookingRequestRequirement = '/booking/request-requirement';
  static const String bookingConfirmInfo = '/booking/confirm-info';
  static const String bookingPayment = '/booking/payment';
  static const String bookingPaymentSuccess = '/booking/payment-success';

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
    initialLocation: bookingPaymentSuccess, // ✅ Screen default 
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
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
            statusBarIconBrightness: Brightness.dark,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
            statusBarIconBrightness: Brightness.dark,
            child: const RegisterPage(),
          );
        },
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
            statusBarIconBrightness: Brightness.dark,
            child: const ForgotPasswordPage(),
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
          final colors = AppThemeConfig.colors;
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
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
          final colors = AppThemeConfig.colors;
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
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
          final colors = AppThemeConfig.colors;
          final role = state.extra as String? ?? AppConstants.roleStudent;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            backgroundColor: colors.white,
            statusBarColor: colors.white,
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
      GoRoute(
        path: courseList,
        name: 'courseList',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            child: const CourseListPage(),
          );
        },
      ),
      GoRoute(
        path: marketplaceTutorDetails,
        name: 'marketplaceTutorDetails',
        builder: (context, state) {
          final tutorId = state.pathParameters['tutorId']!;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: TutorDetailsPage(tutorId: tutorId),
          );
        },
      ),
      GoRoute(
        path: feedbackList,
        name: 'feedbackList',
        builder: (context, state) {
          final tutorId = state.pathParameters['tutorId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final tutorName = extra['tutorName'] as String? ?? 'Gia sư';
          final tutorRating = extra['tutorRating'] as double? ?? 0.0;
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: colors.bgLight,
            padding: EdgeInsets.zero,
            child: FeedbackListPage(
              tutorId: tutorId,
              tutorName: tutorName,
              tutorRating: tutorRating,
            ),
          );
        },
      ),
      GoRoute(
        path: bookingLearningMethod,
        name: 'bookingLearningMethod',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: const ChoiceLearningMethodPage(),
          );
        },
      ),
      GoRoute(
        path: bookingSelectTimeSlot,
        name: 'bookingSelectTimeSlot',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: const SelectTimeSlotPage(),
          );
        },
      ),
      GoRoute(
        path: bookingRequestRequirement,
        name: 'bookingRequestRequirement',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: colors.white,
            padding: EdgeInsets.zero,
            child: const RequestLearningRequirementPage(),
          );
        },
      ),
      GoRoute(
        path: bookingConfirmInfo,
        name: 'bookingConfirmInfo',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: colors.white,
            padding: EdgeInsets.zero,
            child: const ConfirmInfoBookingPage(),
          );
        },
      ),
      GoRoute(
        path: bookingPayment,
        name: 'bookingPayment',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: colors.bgLight,
            padding: EdgeInsets.zero,
            child: const PaymentPage(),
          );
        },
      ),
      GoRoute(
        path: bookingPaymentSuccess,
        name: 'bookingPaymentSuccess',
        builder: (context, state) {
          final colors = AppThemeConfig.colors;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: colors.bgLight,
            padding: EdgeInsets.zero,
            child: const PaymentSuccessfulPage(),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => AppRouter.buildErrorPage(),
  );
}

