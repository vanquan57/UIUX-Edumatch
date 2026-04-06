import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';
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
      title: 'Tìm gia sư phù hợp',
      description:
          'Kết nối với hàng ngàn gia sư chất lượng cao, phù hợp với nhu cầu và ngân sách của bạn.',
    ),
    _OnboardingSlide(
      icon: Icons.laptop_mac_rounded,
      title: 'Học online mọi lúc mọi nơi',
      description:
          'Linh hoạt học tập theo lịch trình của bạn, bất cứ đâu chỉ với một chiếc điện thoại.',
    ),
    _OnboardingSlide(
      icon: Icons.menu_book_rounded,
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
    final colors = AppThemeConfig.colors;
    
    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LowFiButton(
                    text: 'Bỏ qua',
                    onTap: _skip,
                    type: LowFiButtonType.secondary,
                    size: LowFiButtonSize.small,
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
                              ? colors.primaryGreen
                              : colors.disabledGray,
                          borderRadius: BorderRadius.circular(
                            AppThemeConfig.isLowFidelityMode ? 2.r : 4.r,
                          ),
                          border: AppThemeConfig.isLowFidelityMode 
                              ? Border.all(
                                  color: colors.borderColor,
                                  width: 1,
                                )
                              : null,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 28.h),
                  LowFiButton(
                    text: _currentPage == _slides.length - 1
                        ? 'Bắt đầu'
                        : 'Tiếp theo',
                    onTap: _goNext,
                    type: LowFiButtonType.primary,
                    size: LowFiButtonSize.large,
                    width: double.infinity,
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
    final colors = AppThemeConfig.colors;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration - Low-fi version
          AppThemeConfig.isLowFidelityMode
              ? LowFiImagePlaceholder(
                  width: 220.w,
                  height: 220.w,
                  icon: slide.icon,
                  text: 'ILLUSTRATION',
                  borderRadius: BorderRadius.circular(110.r),
                )
              : Container(
                  width: 220.w,
                  height: 220.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.bgLight,
                  ),
                  child: Center(
                    child: Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primaryGreen,
                      ),
                      child: Icon(
                        slide.icon,
                        size: 72.sp,
                        color: colors.white,
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
              color: colors.textDark,
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
              color: colors.textGray,
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
  final String title;
  final String description;

  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });
}
