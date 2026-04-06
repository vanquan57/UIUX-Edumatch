import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _roleListenable = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _roleListenable.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Tạo tài khoản thành công!',
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
              backgroundColor: AppThemeConfig.colors.primaryGreen,
            ),
          );
          context.go(AppRouter.login);
        }
      });
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    final colors = AppThemeConfig.colors;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: colors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: colors.textLightGray,
            ),
            prefixIcon: AppThemeConfig.isLowFidelityMode 
                ? null 
                : Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Icon(
                      prefixIcon,
                      color: colors.primaryGreen,
                      size: 20.sp,
                    ),
                  ),
            suffixIcon: suffixIcon,
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
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
              ),
              borderSide: BorderSide(
                color: colors.errorRed, 
                width: 2,
              ),
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: colors.textDark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tạo tài khoản',
                      style: GoogleFonts.poppins(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.textDark,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Đăng ký để bắt đầu hành trình học tập',
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

          SizedBox(height: 32.h),

          Form(
            key: _formKey,
            child: Column(
              children: [
                // Full Name
                _buildInputField(
                  controller: _fullNameController,
                  label: 'Họ và tên',
                  hint: 'Nhập họ và tên của bạn',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ và tên';
                    }
                    if (value.trim().length < 2) {
                      return 'Họ tên phải có ít nhất 2 ký tự';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Email
                _buildInputField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Nhập email của bạn',
                  prefixIcon: Icons.email_outlined,
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
                ),
                SizedBox(height: 20.h),

                // Password
                _buildInputField(
                  controller: _passwordController,
                  label: 'Mật khẩu',
                  hint: 'Nhập mật khẩu của bạn',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: AppThemeConfig.isLowFidelityMode 
                      ? null 
                      : Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _obscurePassword = !_obscurePassword),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: colors.textLightGray,
                              size: 20.sp,
                            ),
                          ),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Confirm Password
                _buildInputField(
                  controller: _confirmPasswordController,
                  label: 'Xác nhận mật khẩu',
                  hint: 'Nhập lại mật khẩu',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: AppThemeConfig.isLowFidelityMode 
                      ? null 
                      : Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: GestureDetector(
                            onTap: () => setState(
                              () =>
                                  _obscureConfirmPassword = !_obscureConfirmPassword,
                            ),
                            child: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: colors.textLightGray,
                              size: 20.sp,
                            ),
                          ),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng xác nhận mật khẩu';
                    }
                    if (value != _passwordController.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Role Dropdown
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
                          child: Text(
                            'Admin',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleStudent,
                          child: Text(
                            'Học sinh',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleParent,
                          child: Text(
                            'Phụ huynh',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleTutor,
                          child: Text(
                            'Gia sư',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textDark,
                            ),
                          ),
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
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Register Button
                LowFiButton(
                  text: 'Tạo tài khoản',
                  onTap: _isLoading ? null : _handleRegister,
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

                // Google Sign Up Button
                LowFiButton(
                  text: 'Đăng ký với Google',
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

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản? ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textGray,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRouter.login),
                      child: Text(
                        'Đăng nhập',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
