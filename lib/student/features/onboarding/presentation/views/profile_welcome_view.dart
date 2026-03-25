import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupPage extends StatefulWidget {
  final String role;
  const ProfileSetupPage({super.key, required this.role});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _goalController = TextEditingController();
  final _areaController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _gradeController.dispose();
    _goalController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _handleComplete() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final role = widget.role;
      if (role == AppConstants.roleParent) {
        context.go(AppRouter.homeParent);
      } else if (role == AppConstants.roleTutor) {
        context.go(AppRouter.homeTutor);
      } else {
        context.go(AppRouter.homeStudent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress indicator
                    Row(
                      children: [
                        _ProgressDot(isActive: false, isDone: true),
                        _ProgressLine(),
                        _ProgressDot(isActive: false, isDone: true),
                        _ProgressLine(),
                        _ProgressDot(isActive: true, isDone: false),
                      ],
                    ),
                    SizedBox(height: 28.h),

                    // Header
                    Text(
                      'Thiết lập hồ sơ\nhọc tập',
                      style: GoogleFonts.poppins(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Thông tin này giúp chúng tôi tìm gia sư và khóa học phù hợp nhất cho bạn.',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: AppColors.textGray,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Họ và tên'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Nhập họ và tên của bạn',
                            icon: Icons.person_outline_rounded,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Vui lòng nhập họ tên'
                                : null,
                          ),
                          SizedBox(height: 20.h),

                          _buildFieldLabel('Lớp / Độ tuổi'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _gradeController,
                            hint: 'Ví dụ: Lớp 10, 15 tuổi...',
                            icon: Icons.school_outlined,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Vui lòng nhập lớp hoặc độ tuổi'
                                : null,
                          ),
                          SizedBox(height: 20.h),

                          _buildFieldLabel('Mục tiêu học tập'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _goalController,
                            hint:
                                'Ví dụ: Thi đại học, cải thiện điểm số, học IELTS...',
                            icon: Icons.flag_outlined,
                            maxLines: 3,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Vui lòng nhập mục tiêu học tập'
                                : null,
                          ),
                          SizedBox(height: 20.h),

                          _buildFieldLabel('Khu vực'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _areaController,
                            hint: 'Ví dụ: Quận 1, TP. Hồ Chí Minh',
                            icon: Icons.location_on_outlined,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Vui lòng nhập khu vực'
                                : null,
                          ),
                          SizedBox(height: 12.h),

                          // Info note
                          Container(
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: 18.sp,
                                  color: AppColors.primaryGreen,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    'Bạn có thể cập nhật thông tin này bất cứ lúc nào trong phần Hồ sơ.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: AppColors.primaryGreenDark,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Complete button — pinned at bottom
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24.w),
              child: SizedBox(
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
                      onTap: _isLoading ? null : _handleComplete,
                      borderRadius: BorderRadius.circular(14.r),
                      child: Center(
                        child: _isLoading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Hoàn tất',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(fontSize: 14.sp, color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            fontSize: 14.sp, color: AppColors.textLightGray),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: Icon(icon, color: AppColors.primaryGreen, size: 20.sp),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 44.w),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: AppColors.primaryGreen, width: 2),
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
    );
  }
}

class _ProgressDot extends StatelessWidget {
  final bool isActive;
  final bool isDone;

  const _ProgressDot({required this.isActive, required this.isDone});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (isDone || isActive) {
      color = AppColors.primaryGreen;
    } else {
      color = AppColors.disabledGray;
    }

    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (isActive || isDone) ? color : Colors.white,
        border: Border.all(color: color, width: 2),
      ),
      child: isDone
          ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
          : Center(
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.white : color,
                ),
              ),
            ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: AppColors.primaryGreen.withOpacity(0.3),
      ),
    );
  }
}
