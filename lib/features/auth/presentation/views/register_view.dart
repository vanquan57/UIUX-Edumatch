import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/core/router/app_router.dart';
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
              backgroundColor: AppColors.primaryGreen,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
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
              color: AppColors.textLightGray,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Icon(
                prefixIcon,
                color: AppColors.primaryGreen,
                size: 20.sp,
              ),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.primaryGreen,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.errorRed, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Đăng ký để bắt đầu hành trình học tập',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withOpacity(0.15),
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
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textLightGray,
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
                  suffixIcon: Padding(
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
                        color: AppColors.textLightGray,
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
                        color: AppColors.textDark,
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
                          color: AppColors.textLightGray,
                        ),
                      ),
                      items: [
                        DropdownItem(
                          value: AppConstants.roleTutor,
                          child: Text(
                            'Admin',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleStudent,
                          child: Text(
                            'Học sinh',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleParent,
                          child: Text(
                            'Phụ huynh',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        DropdownItem(
                          value: AppConstants.roleTutor,
                          child: Text(
                            'Gia sư',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                      dropdownStyleData: DropdownStyleData(
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
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
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.primaryGreen,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.errorRed,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: Material(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      onTap: _isLoading ? null : _handleRegister,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Center(
                        child: _isLoading
                            ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Tạo tài khoản',
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
                SizedBox(height: 20.h),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(height: 1, color: AppColors.borderColor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'hoặc',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(height: 1, color: AppColors.borderColor),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Google Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đang kết nối với Google...'),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.g_mobiledata,
                            color: AppColors.primaryGreen,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Đăng ký với Google',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        color: AppColors.textGray,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRouter.login),
                      child: Text(
                        'Đăng nhập',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
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
