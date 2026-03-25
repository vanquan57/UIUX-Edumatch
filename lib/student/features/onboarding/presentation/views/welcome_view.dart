import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingWelcomePage extends StatefulWidget {
  final String role;
  const OnboardingWelcomePage({super.key, required this.role});

  @override
  State<OnboardingWelcomePage> createState() => _OnboardingWelcomePageState();
}

class _OnboardingWelcomePageState extends State<OnboardingWelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      icon: Icons.school_rounded,
      gradientColors: [Color(0xFF1C8659), Color(0xFF2DB87F)],
      title: 'Tìm gia sư phù hợp',
      description:
          'Kết nối với hàng ngàn gia sư chất lượng cao, phù hợp với nhu cầu và ngân sách của bạn.',
    ),
    _OnboardingSlide(
      icon: Icons.laptop_mac_rounded,
      gradientColors: [Color(0xFF2DB87F), Color(0xFF7AC043)],
      title: 'Học online mọi lúc mọi nơi',
      description:
          'Linh hoạt học tập theo lịch trình của bạn, bất cứ đâu chỉ với một chiếc điện thoại.',
    ),
    _OnboardingSlide(
      icon: Icons.menu_book_rounded,
      gradientColors: [Color(0xFF0D5A3F), Color(0xFF1C8659)],
      title: 'Nhiều hình thức học đa dạng',
      description:
          'Chọn học 1-1, học nhóm, học online hoặc tại nhà — tất cả trong một ứng dụng.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRouter.onboardingSubjectInterest, extra: widget.role);
    }
  }

  void _skip() {
    context.go(AppRouter.onboardingSubjectInterest, extra: widget.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skip,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        side: const BorderSide(color: AppColors.borderColor),
                      ),
                    ),
                    child: Text(
                      'Bỏ qua',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (context, index) =>
                    _SlideWidget(slide: _slides[index]),
              ),
            ),

            // Dot indicators + button
            Padding(
              padding:
                  EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 16.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (i) {
                      final isActive = _currentPage == i;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: isActive ? 24.w : 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryGreen
                              : AppColors.disabledGray,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryGreen,
                            AppColors.accentGreen,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14.r),
                        child: InkWell(
                          onTap: _goNext,
                          borderRadius: BorderRadius.circular(14.r),
                          child: Center(
                            child: Text(
                              _currentPage == _slides.length - 1
                                  ? 'Bắt đầu'
                                  : 'Tiếp theo',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideWidget extends StatelessWidget {
  final _OnboardingSlide slide;
  const _SlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration circle
          Container(
            width: 220.w,
            height: 220.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  slide.gradientColors[0].withOpacity(0.12),
                  slide.gradientColors[1].withOpacity(0.04),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: slide.gradientColors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: slide.gradientColors[0].withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  slide.icon,
                  size: 72.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 48.h),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGray,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  final IconData icon;
  final List<Color> gradientColors;
  final String title;
  final String description;

  const _OnboardingSlide({
    required this.icon,
    required this.gradientColors,
    required this.title,
    required this.description,
  });
}
