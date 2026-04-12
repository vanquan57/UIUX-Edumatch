import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/admin/features/home/presentation/views/admin_home_page.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/features/auth/presentation/views/forgot_password_view.dart';
import 'package:edu_match/features/auth/presentation/views/login_view.dart';
import 'package:edu_match/features/auth/presentation/views/register_view.dart';
import 'package:edu_match/parent/features/home/presentation/views/parent_home_page.dart';
import 'package:edu_match/share/layouts/main_layout.dart';
import 'package:edu_match/student/data/models/booking_model.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/choice_learning_method.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/confirm_info_booking.dart';
import 'package:edu_match/student/features/payment/presentation/views/payment_page.dart';
import 'package:edu_match/student/features/payment/presentation/views/payment_successful_page.dart';
import 'package:edu_match/student/features/payment course/presentation/views/payment_course_page.dart';
import 'package:edu_match/student/features/payment course/presentation/views/payment_course_successful_page.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/request_learning_requirement.dart';
import 'package:edu_match/student/features/confirm_booking/presentation/views/select_time_slot.dart';
import 'package:edu_match/student/features/home/presentation/views/student_home_page.dart';
import 'package:edu_match/student/features/list_tutor/presentation/views/tutor_list_page.dart';
import 'package:edu_match/student/features/messenger/presentation/views/chat_detail_page.dart';
import 'package:edu_match/student/features/messenger/presentation/views/chat_list_page.dart';
import 'package:edu_match/student/features/list_courses/presentation/views/list_course_page.dart';
import 'package:edu_match/student/features/course_details/presentation/views/course_details_page.dart';
import 'package:edu_match/student/features/feedback/presentation/views/list_feedback_course.dart';
import 'package:edu_match/student/features/feedback/presentation/views/list_feedback.dart';
import 'package:edu_match/student/features/notification/presentation/views/notification_page.dart';
import 'package:edu_match/student/features/tutor_details/presentation/views/tutor_details_page.dart';
import 'package:edu_match/student/features/play_video/presentation/views/play_video_page.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/profile_welcome_view.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/subject_interest_view.dart';
import 'package:edu_match/student/features/onboarding/presentation/views/welcome_view.dart';
import 'package:edu_match/student/features/about_us/presentation/views/about_us.dart';
import 'package:edu_match/student/features/blog/presentation/views/blog_page.dart';
import 'package:edu_match/student/features/account/presentation/views/account_page.dart';
import 'package:edu_match/student/features/my-course/presentation/views/my_course_page.dart';
import 'package:edu_match/student/features/my-course/presentation/views/course_content_page.dart';
import 'package:edu_match/student/features/my-course/presentation/views/certificate_page.dart';
import 'package:edu_match/student/features/my_schedule/presentation/views/my_schedule_page.dart';
import 'package:edu_match/student/features/tutor_assigned/presentation/views/tutor_assigned_page.dart';
import 'package:edu_match/student/features/tutor_assigned/presentation/views/tutor_assigned_details_page.dart';
import 'package:edu_match/student/data/models/tutor_assigned_model.dart';
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
  static const String courseDetails = '/courses/:courseId';
  static const String courseFeedbackList = '/courses/:courseId/feedback';
  static const String playVideo = '/play-video';
  static const String feedbackList = '/tutor/:tutorId/feedback';
  static const String bookingLearningMethod = '/booking/learning-method';
  static const String bookingSelectTimeSlot = '/booking/select-time-slot';
  static const String bookingRequestRequirement = '/booking/request-requirement';
  static const String bookingConfirmInfo = '/booking/confirm-info';
  static const String bookingPayment = '/booking/payment';
  static const String bookingPaymentSuccess = '/booking/payment-success';
  static const String coursePayment = '/course/payment';
  static const String coursePaymentSuccess = '/course/payment-success';
  static const String aboutUs = '/about-us';
  static const String blog = '/blog';
  static const String notificationList = '/notifications';
  static const String messengerChatList = '/messenger/chats';
  static const String messengerChatDetail = '/messenger/chat';
  static const String accountProfile = '/account/profile';
  static const String myCourses = '/my-courses';
  static const String mySchedule = '/my-schedule';
  static const String courseContent = '/course-content';
  static const String certificate = '/certificate';
  static const String tutorAssigned = '/tutor-assigned';
  static const String tutorAssignedDetails = '/tutor-assigned-details';

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
        path: courseDetails,
        name: 'courseDetails',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: CourseDetailsPage(courseId: courseId),
          );
        },
      ),
      GoRoute(
        path: courseFeedbackList,
        name: 'courseFeedbackList',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final courseName = extra['courseName'] as String? ?? 'Khóa học';
          final courseRating = extra['courseRating'] as double? ?? 0.0;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: CourseFeedbackListPage(
              courseId: courseId,
              courseName: courseName,
              courseRating: courseRating,
            ),
          );
        },
      ),
      GoRoute(
        path: playVideo,
        name: 'playVideo',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: PlayVideoPage(
              videoUrl: extra['videoUrl'] as String,
              title: extra['title'] as String,
              courseName: extra['courseName'] as String,
              instructorName: extra['instructorName'] as String,
              duration: extra['duration'] as String,
              isVideoPreview: extra['isVideoPreview'] as bool? ?? false,
            ),
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
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
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
          final tutor = state.extra as TutorModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: ChoiceLearningMethodPage(tutor: tutor),
          );
        },
      ),
      GoRoute(
        path: bookingSelectTimeSlot,
        name: 'bookingSelectTimeSlot',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            padding: EdgeInsets.zero,
            child: SelectTimeSlotPage(booking: booking),
          );
        },
      ),
      GoRoute(
        path: bookingRequestRequirement,
        name: 'bookingRequestRequirement',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: RequestLearningRequirementPage(booking: booking),
          );
        },
      ),
      GoRoute(
        path: bookingConfirmInfo,
        name: 'bookingConfirmInfo',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: ConfirmInfoBookingPage(booking: booking),
          );
        },
      ),
      GoRoute(
        path: bookingPayment,
        name: 'bookingPayment',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: PaymentPage(booking: booking),
          );
        },
      ),
      GoRoute(
        path: bookingPaymentSuccess,
        name: 'bookingPaymentSuccess',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: const PaymentSuccessfulPage(),
          );
        },
      ),
      GoRoute(
        path: coursePayment,
        name: 'coursePayment',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: PaymentCoursePage(
              courseId: extra['courseId'] as String,
              courseTitle: extra['courseTitle'] as String,
              coursePrice: extra['coursePrice'] as double,
              instructorName: extra['instructorName'] as String,
            ),
          );
        },
      ),
      GoRoute(
        path: coursePaymentSuccess,
        name: 'coursePaymentSuccess',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            padding: EdgeInsets.zero,
            child: PaymentCourseSuccessfulPage(courseTitle: extra['courseTitle'] as String),
          );
        },
      ),
      GoRoute(
        path: aboutUs,
        name: 'aboutUs',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.white,
            child: const AboutUsPage(),
          );
        },
      ),
      GoRoute(
        path: blog,
        name: 'blog',
        builder: (context, state) {
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.white,
            child: const BlogPage(),
          );
        },
      ),
      GoRoute(
        path: notificationList,
        name: 'notificationList',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            child: NotificationPage(),
          );
        },
      ),
      GoRoute(
        path: messengerChatList,
        name: 'messengerChatList',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: true,
            showFooter: true,
            backgroundColor: AppColors.bgLight,
            child: ChatListPage(),
          );
        },
      ),
      GoRoute(
        path: '$messengerChatDetail/:tutorId',
        name: 'messengerChatDetail',
        builder: (context, state) {
          final tutorId = state.pathParameters['tutorId']!;
          final tutorName = state.extra as String?;
          return MainLayout(
            layoutType: LayoutType.fullscreen,
            showHeader: false,
            showFooter: false,
            backgroundColor: AppColors.bgLight,
            child: ChatDetailPage(tutorId: tutorId, tutorName: tutorName),
          );
        },
      ),
      GoRoute(
        path: accountProfile,
        name: 'accountProfile',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: false,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: AccountPage(),
          );
        },
      ),
      GoRoute(
        path: myCourses,
        name: 'myCourses',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: MyCoursePage(),
          );
        },
      ),
      GoRoute(
        path: mySchedule,
        name: 'mySchedule',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: MySchedulePage(),
          );
        },
      ),
      GoRoute(
        path: courseContent,
        name: 'courseContent',
        builder: (context, state) {
          final course = state.extra as CourseModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: CourseContentPage(course: course),
          );
        },
      ),
      GoRoute(
        path: certificate,
        name: 'certificate',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: CertificatePage(
              studentName: extra['studentName'] as String,
              courseTitle: extra['courseTitle'] as String,
              instructorName: extra['instructorName'] as String,
              completionDate: extra['completionDate'] as DateTime,
            ),
          );
        },
      ),
      GoRoute(
        path: tutorAssigned,
        name: 'tutorAssigned',
        builder: (context, state) {
          return const MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: TutorAssignedPage(),
          );
        },
      ),
      GoRoute(
        path: tutorAssignedDetails,
        name: 'tutorAssignedDetails',
        builder: (context, state) {
          final tutorAssigned = state.extra as TutorAssignedModel;
          return MainLayout(
            layoutType: LayoutType.normal,
            showHeader: false,
            showFooter: true,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
            child: TutorAssignedDetailsPage(tutorAssigned: tutorAssigned),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => AppRouter.buildErrorPage(),
  );
}

