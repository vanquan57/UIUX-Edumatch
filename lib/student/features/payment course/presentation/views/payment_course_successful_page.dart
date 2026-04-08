import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentCourseSuccessfulPage extends StatelessWidget {
  final String courseTitle;
  
  const PaymentCourseSuccessfulPage({
    super.key,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: AppColors.successGreen,
              size: 44.sp,
            ),
          ),
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'assets/images/successful.jpg',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 180.h,
                alignment: Alignment.center,
                color: AppColors.bgLight,
                child: Icon(Icons.celebration,
                    size: 64.sp, color: AppColors.primaryGreen),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Thanh toán thành công!',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.35,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Bạn đã mua thành công khóa học',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: AppColors.textGray,
              height: 1.35,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '"$courseTitle"',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
              height: 1.35,
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () => context.go(AppRouter.homeStudent),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryGreen, AppColors.accentGreen],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Quản lý khóa học',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
