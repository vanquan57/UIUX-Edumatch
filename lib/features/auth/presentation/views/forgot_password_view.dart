import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _emailSent = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.go(AppRouter.login),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16.sp,
                            color: colors.primaryGreen,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Quay lại',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: colors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Quên mật khẩu',
                      style: GoogleFonts.poppins(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.textDark,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _emailSent
                          ? 'Email đã được gửi, kiểm tra hộp thư của bạn'
                          : 'Nhập email để nhận hướng dẫn đặt lại mật khẩu',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Logo - Low-fi version
              AppThemeConfig.isLowFidelityMode
                  ? LowFiImagePlaceholder(
                      width: 60.w,
                      height: 60.h,
                      icon: Icons.school_outlined,
                      text: 'LOGO',
                    )
                  : Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: colors.primaryGreen.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ],
          ),

          SizedBox(height: 40.h),

          if (!_emailSent) ...[
            // Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email Input
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: colors.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nhập email của bạn',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: colors.textLightGray,
                      ),
                      prefixIcon: AppThemeConfig.isLowFidelityMode 
                          ? null 
                          : Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Icon(
                                Icons.email_outlined,
                                color: colors.primaryGreen,
                                size: 20.sp,
                              ),
                            ),
                      filled: true,
                      fillColor: colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: BorderSide(
                          color: colors.borderColor,
                          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: BorderSide(
                          color: colors.borderColor,
                          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: BorderSide(
                          color: AppThemeConfig.isLowFidelityMode 
                              ? colors.textDark 
                              : colors.primaryGreen,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: BorderSide(
                          color: colors.errorRed,
                          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: colors.textDark,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Submit Button
                  LowFiButton(
                    text: 'Gửi yêu cầu',
                    onTap: _isLoading ? null : _handleSubmit,
                    type: LowFiButtonType.primary,
                    size: LowFiButtonSize.large,
                    width: double.infinity,
                    isLoading: _isLoading,
                    isEnabled: !_isLoading,
                  ),
                ],
              ),
            ),
          ] else ...[
            // Success state
            Center(
              child: Column(
                children: [
                  AppThemeConfig.isLowFidelityMode
                      ? LowFiImagePlaceholder(
                          width: 96.w,
                          height: 96.h,
                          icon: Icons.mark_email_read_outlined,
                          text: 'EMAIL',
                          borderRadius: BorderRadius.circular(48.r),
                        )
                      : Container(
                          width: 96.w,
                          height: 96.h,
                          decoration: BoxDecoration(
                            color: colors.lightGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mark_email_read_outlined,
                            size: 48.sp,
                            color: colors.primaryGreen,
                          ),
                        ),
                  SizedBox(height: 24.h),
                  Text(
                    'Kiểm tra email!',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.textDark,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Chúng tôi đã gửi hướng dẫn đặt lại mật khẩu\nđến ${_emailController.text}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: colors.textGray,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  LowFiButton(
                    text: 'Về trang đăng nhập',
                    onTap: () => context.go(AppRouter.login),
                    type: LowFiButtonType.primary,
                    size: LowFiButtonSize.large,
                    width: double.infinity,
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _emailSent = false;
                        _emailController.clear();
                      });
                    },
                    child: Text(
                      'Gửi lại email',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: colors.primaryGreen,
                        decoration: AppThemeConfig.isLowFidelityMode 
                            ? null 
                            : TextDecoration.underline,
                        decorationColor: colors.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
