import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/core/services/user_session.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _roleListenable = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _roleListenable.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final role = _roleListenable.value;
      if (role == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn vai trò')),
        );
        return;
      }

      print('=== LOGIN DATA ===');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Role: $role');
      print('==================');

      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        if (mounted) {
          UserSession.login(role);
          if (role == AppConstants.roleAdmin) {
            context.go(AppRouter.homeAdmin);
          } else {
            // student, parent, tutor → onboarding flow on first launch
            context.go(AppRouter.onboardingWelcome, extra: role);
          }
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đăng nhập',
                          style: GoogleFonts.poppins(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: colors.textDark,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Chào mừng bạn quay lại',
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
              SizedBox(height: 28.h),
              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
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
                                width: AppThemeConfig.isLowFidelityMode ? 2 : 2,
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
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Password Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mật khẩu',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: colors.textDark,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (value.length < 6) {
                              return 'Mật khẩu phải ít nhất 6 ký tự';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu của bạn',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textLightGray,
                            ),
                            prefixIcon: AppThemeConfig.isLowFidelityMode 
                                ? null 
                                : Padding(
                                    padding: EdgeInsets.only(left: 12.w),
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: colors.primaryGreen,
                                      size: 20.sp,
                                    ),
                                  ),
                            suffixIcon: AppThemeConfig.isLowFidelityMode 
                                ? null 
                                : Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Icon(
                                      Icons.visibility_off,
                                      color: colors.textLightGray,
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
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Role Select
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vai trò',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: colors.textDark,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          valueListenable: _roleListenable,
                          hint: Text(
                            'Chọn vai trò của bạn',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textLightGray,
                            ),
                          ),
                          items: [
                            DropdownItem(
                              value: 'admin',
                              child: Text('Admin',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: colors.textDark)),
                            ),
                            DropdownItem(
                              value: 'student',
                              child: Text('Student',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: colors.textDark)),
                            ),
                            DropdownItem(
                              value: 'parent',
                              child: Text('Parent',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: colors.textDark)),
                            ),
                            DropdownItem(
                              value: 'tutor',
                              child: Text('Tutor',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: colors.textDark)),
                            ),
                          ],
                          dropdownStyleData: DropdownStyleData(
                            width: 200.w,
                            decoration: BoxDecoration(
                              color: colors.white,
                              border: AppThemeConfig.isLowFidelityMode 
                                  ? Border.all(color: colors.borderColor, width: 1.5)
                                  : null,
                              borderRadius: BorderRadius.circular(
                                AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                              ),
                            ),
                          ),
                          onChanged: (value) => _roleListenable.value = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng chọn vai trò';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Handle forgot password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Chuyến hướng đến trang quên mật khẩu',
                              ),
                            ),
                          );
                        },
                        child: TextButton(
                          onPressed: () => context.go(AppRouter.forgotPassword),
                          child: Text(
                            'Quên mật khẩu?',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: colors.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    // Login Button
                    LowFiButton(
                      text: 'Đăng nhập',
                      onTap: _isLoading ? null : _handleLogin,
                      type: LowFiButtonType.primary,
                      size: LowFiButtonSize.large,
                      width: double.infinity,
                      isLoading: _isLoading,
                      isEnabled: !_isLoading,
                    ),
                    SizedBox(height: 20.h),
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
                            color: colors.borderColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'hoặc',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: colors.textGray,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
                            color: colors.borderColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Google Sign In Button
                    LowFiButton(
                      text: 'Tiếp tục với Google',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đang kết nối với Google...'),
                          ),
                        );
                      },
                      type: LowFiButtonType.secondary,
                      size: LowFiButtonSize.large,
                      width: double.infinity,
                      icon: AppThemeConfig.isLowFidelityMode ? null : Icons.g_mobiledata,
                    ),
                    SizedBox(height: 24.h),
                    // Create Account Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có tài khoản? ',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: colors.textGray,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to signup page
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Chuyển hướng đến trang đăng ký'),
                              ),
                            );
                          },
                          child: TextButton(
                            onPressed: () => context.go(AppRouter.register),
                            child: Text(
                              'Tạo tài khoản',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: colors.primaryGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
