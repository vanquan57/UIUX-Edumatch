import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessfulPage extends StatelessWidget {
  const PaymentSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(context, colors)
        : _buildFullLayout(context, colors);
  }

  Widget _buildLowFiLayout(BuildContext context, AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          
          // Success icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                '✓',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: colors.textDark,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          
          // Success message
          Text(
            'Thanh toán thành công',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          
          Text(
            'Bạn đã đặt lịch học thành công',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 32.h),
          
          // Action button
          GestureDetector(
            onTap: () => context.go(AppRouter.homeStudent),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.textDark, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
                color: colors.textDark,
              ),
              child: Center(
                child: Text(
                  'Quản lý lịch học',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullLayout(BuildContext context, AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          // Success Icon
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: colors.lightGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: colors.successGreen,
              size: 44.sp,
            ),
          ),
          SizedBox(height: 20.h),
          
          // Success Image/Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'assets/images/successful.jpg',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 180.h,
                alignment: Alignment.center,
                color: colors.bgLight,
                child: Icon(Icons.celebration,
                    size: 64.sp, color: colors.primaryGreen),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          
          // Success Message
          Text(
            'Bạn đã thanh toán thành công',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: colors.textDark,
              height: 1.35,
            ),
          ),
          SizedBox(height: 32.h),
          
          // CTA Button
          LowFiButton(
            text: 'Quản lý lịch học',
            onTap: () => context.go(AppRouter.homeStudent),
            type: LowFiButtonType.primary,
            size: LowFiButtonSize.large,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
