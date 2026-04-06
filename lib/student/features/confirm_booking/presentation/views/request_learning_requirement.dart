import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/student/data/models/booking_model.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestLearningRequirementPage extends StatefulWidget {
  const RequestLearningRequirementPage({super.key});

  @override
  State<RequestLearningRequirementPage> createState() =>
      _RequestLearningRequirementPageState();
}

class _RequestLearningRequirementPageState
    extends State<RequestLearningRequirementPage> {
  late BookingModel booking;
  late TextEditingController _noteController;
  String? selectedSubject;
  String? selectedLevel;
  String? selectedSessionType;
  bool isLoading = false;

  List<String> uploadedFiles = [];
  bool? hasHomework;
  bool? teachInEnglish;

  final List<String> levelOptions = [
    'Lớp 1',
    'Lớp 2',
    'Lớp 3',
    'Lớp 4',
    'Lớp 5',
    'Lớp 6',
    'Lớp 7',
    'Lớp 8',
    'Lớp 9',
    'Lớp 10',
    'Lớp 11',
    'Lớp 12',
    'Đại học',
    'Khác',
  ];

  final List<String> sessionTypeOptions = [
    'Buổi học thông thường',
    'Ôn tập giữa kì',
    'Ôn tập cuối kì',
    'Luyện thi đầu vào',
    'Nâng cao kiến thức',
    'Hỗ trợ bài tập',
    'Khác'
  ];

  @override
  void initState() {
    super.initState();
    // Use mock booking data for prototype
    final mockTutor = TutorModel.mockTutors().first;
    booking = BookingModel(
      tutorId: mockTutor.id,
      tutorName: mockTutor.name,
      tutorAvatar: mockTutor.avatar,
      tutorSubjects: mockTutor.subjects,
      type: 'online',
      selectedTimeSlot: '09:00 - 10:00',
      subject: 'Toán',
      sessionDuration: 60,
    );
    // Auto-select subject if tutor only teaches one subject
    final subjects = booking.tutorSubjects ?? [];
    if (subjects.length == 1) {
      selectedSubject = subjects.first;
    }
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final subjects = booking.tutorSubjects ?? [];
    if (subjects.isNotEmpty && (selectedSubject == null || selectedSubject!.isEmpty)) {
      _showErrorSnackBar('Vui lòng chọn môn học');
      return false;
    }

    if (selectedSessionType == null || selectedSessionType!.isEmpty) {
      _showErrorSnackBar('Vui lòng chọn loại buổi học');
      return false;
    }

    if (selectedLevel == null || selectedLevel!.isEmpty) {
      _showErrorSnackBar('Vui lòng chọn trình độ');
      return false;
    }

    if (hasHomework == null) {
      _showErrorSnackBar('Vui lòng chọn có bài tập về nhà');
      return false;
    }

    if (teachInEnglish == null) {
      _showErrorSnackBar('Vui lòng chọn dạy bằng tiếng Anh');
      return false;
    }

    return true;
  }

  bool _isFormValid() {
    final subjects = booking.tutorSubjects ?? [];
    if (subjects.isNotEmpty && (selectedSubject == null || selectedSubject!.isEmpty)) {
      return false;
    }

    if (selectedSessionType == null || selectedSessionType!.isEmpty) {
      return false;
    }

    if (selectedLevel == null || selectedLevel!.isEmpty) {
      return false;
    }

    if (hasHomework == null) {
      return false;
    }

    if (teachInEnglish == null) {
      return false;
    }

    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppThemeConfig.colors.errorRed,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _onContinuePressed() {
    if (!_validateForm()) return;

    setState(() => isLoading = true);

    try {
      booking = booking.copyWith(
        subject: selectedSubject,
        metadata: {
          'sessionType': selectedSessionType,
          'level': selectedLevel,
          'note': _noteController.text.trim(),
          'uploadedFiles': uploadedFiles,
          'hasHomework': hasHomework,
          'teachInEnglish': teachInEnglish,
        },
      );

      // Navigate to next step (or summary/confirmation)
      if (mounted) {
        context.pushNamed('bookingConfirmInfo');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Có lỗi xảy ra, vui lòng thử lại');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(colors)
        : _buildFullLayout();
  }

  Widget _buildLowFiLayout(AppColorScheme colors) {
    final subjects = booking.tutorSubjects ?? [];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Yêu cầu học tập',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 16.h),

          // Tutor info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[TUTOR INFO]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.tutorName ?? 'Gia sư',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Subject selection (if multiple subjects)
          if (subjects.isNotEmpty) ...[
            Text(
              'Môn học *',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                selectedSubject ?? '[CHỌN MÔN HỌC]',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: selectedSubject != null ? colors.textDark : colors.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Session type
          Text(
            'Loại buổi học *',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              selectedSessionType ?? '[CHỌN LOẠI BUỔI HỌC]',
              style: TextStyle(
                fontSize: 12.sp,
                color: selectedSessionType != null ? colors.textDark : colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Level
          Text(
            'Trình độ *',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              selectedLevel ?? '[CHỌN TRÌNH ĐỘ]',
              style: TextStyle(
                fontSize: 12.sp,
                color: selectedLevel != null ? colors.textDark : colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Note
          Text(
            'Ghi chú thêm',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 80.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              _noteController.text.isEmpty ? '[GHI CHÚ THÊM]' : _noteController.text,
              style: TextStyle(
                fontSize: 12.sp,
                color: _noteController.text.isEmpty ? colors.textSecondary : colors.textDark,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // File upload
          Text(
            'Tải lên file',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              uploadedFiles.isEmpty ? '[CHỌN FILE]' : '${uploadedFiles.length} file đã chọn',
              style: TextStyle(
                fontSize: 12.sp,
                color: uploadedFiles.isEmpty ? colors.textSecondary : colors.textDark,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Homework option
          Text(
            'Có bài tập về nhà *',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => hasHomework = true),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hasHomework == true ? colors.textDark : colors.borderColor,
                        width: hasHomework == true ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: hasHomework == true ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Có',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => hasHomework = false),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hasHomework == false ? colors.textDark : colors.borderColor,
                        width: hasHomework == false ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: hasHomework == false ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Không',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // English teaching option
          Text(
            'Dạy bằng tiếng Anh *',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => teachInEnglish = true),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: teachInEnglish == true ? colors.textDark : colors.borderColor,
                        width: teachInEnglish == true ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: teachInEnglish == true ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Có',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => teachInEnglish = false),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: teachInEnglish == false ? colors.textDark : colors.borderColor,
                        width: teachInEnglish == false ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: teachInEnglish == false ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Không',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),

          // Continue button
          GestureDetector(
            onTap: _isFormValid() ? _onContinuePressed : null,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.textDark, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
                color: _isFormValid() ? colors.textDark : colors.disabledGray,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 16.h,
                        width: 16.h,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Tiếp tục',
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

  Widget _buildFullLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildTutorInfoCard(),
                SizedBox(height: 32.h),
                _buildTitle(),
                SizedBox(height: 24.h),
                _buildForm(),
                SizedBox(height: 120.h), // Space for sticky button
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildStickyButton(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Yêu cầu học tập',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppThemeConfig.colors.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTutorInfoCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.bgLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppThemeConfig.colors.primaryGreen,
            ),
            child: ClipOval(
              child: Image.asset(
                booking.tutorAvatar ?? 'assets/images/default_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.person,
                      color: AppThemeConfig.colors.white,
                      size: 28.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.tutorName ?? 'Gia sư',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppThemeConfig.colors.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.subject ?? 'Chưa chọn môn',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppThemeConfig.colors.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin yêu cầu',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Cung cấp thông tin để gia sư hiểu rõ hơn về nhu cầu học tập của bạn',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppThemeConfig.colors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    final subjects = booking.tutorSubjects ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subjects.isNotEmpty) ...[
          _buildFormField(
            label: 'Môn học',
            required: true,
            child: _buildSubjectSelector(subjects),
          ),
          SizedBox(height: 20.h),
        ],
        _buildFormField(
          label: 'Loại buổi học',
          required: true,
          child: _buildSessionTypeDropdown(),
        ),
        SizedBox(height: 20.h),
        _buildFormField(
          label: 'Trình độ',
          required: true,
          child: _buildLevelDropdown(),
        ),
        SizedBox(height: 20.h),
        _buildFormField(
          label: 'Ghi chú thêm',
          required: false,
          child: _buildNoteTextarea(),
        ),
        SizedBox(height: 24.h),
        _buildFileUploadSection(),
        SizedBox(height: 24.h),
        _buildRadioButtonSection(
          title: 'Có bài tập về nhà',
          value: hasHomework,
          onChanged: (value) => setState(() => hasHomework = value),
        ),
        SizedBox(height: 20.h),
        _buildRadioButtonSection(
          title: 'Dạy bằng tiếng Anh',
          value: teachInEnglish,
          onChanged: (value) => setState(() => teachInEnglish = value),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required bool required,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeConfig.colors.errorRed,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }

  Widget _buildSubjectSelector(List<String> subjects) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: subjects.map((subject) {
        final isSelected = selectedSubject == subject;
        return GestureDetector(
          onTap: () => setState(() => selectedSubject = subject),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.borderColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              subject,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppThemeConfig.colors.white : AppThemeConfig.colors.textDark,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSessionTypeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: selectedSessionType != null
              ? AppThemeConfig.colors.primaryGreen
              : AppThemeConfig.colors.borderColor,
          width: selectedSessionType != null ? 2 : 1,
        ),
        color: AppThemeConfig.colors.white,
      ),
      child: DropdownButton<String>(
        value: selectedSessionType,
        hint: Text(
          'Chọn loại buổi học',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppThemeConfig.colors.textLightGray,
          ),
        ),
        isExpanded: true,
        underline: SizedBox.shrink(),
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppThemeConfig.colors.textDark,
        ),
        dropdownColor: AppThemeConfig.colors.white,
        items: sessionTypeOptions.map((type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => selectedSessionType = value);
        },
      ),
    );
  }

  Widget _buildLevelDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: selectedLevel != null
              ? AppThemeConfig.colors.primaryGreen
              : AppThemeConfig.colors.borderColor,
          width: selectedLevel != null ? 2 : 1,
        ),
        color: AppThemeConfig.colors.white,
      ),
      child: DropdownButton<String>(
        value: selectedLevel,
        hint: Text(
          'Chọn trình độ',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppThemeConfig.colors.textLightGray,
          ),
        ),
        isExpanded: true,
        underline: SizedBox.shrink(),
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppThemeConfig.colors.textDark,
        ),
        dropdownColor: AppThemeConfig.colors.white,
        items: levelOptions.map((level) {
          return DropdownMenuItem<String>(
            value: level,
            child: Text(
              level,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => selectedLevel = value);
        },
      ),
    );
  }

  Widget _buildNoteTextarea() {
    return TextField(
      controller: _noteController,
      maxLines: 3,
      minLines: 2,
      decoration: InputDecoration(
        hintText:
            'Ví dụ: Tôi thích học vào buổi tối, có sẵn kiến thức cơ bản...',
        hintStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: AppThemeConfig.colors.textLightGray,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppThemeConfig.colors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppThemeConfig.colors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
              BorderSide(color: AppThemeConfig.colors.primaryGreen, width: 2),
        ),
        contentPadding: EdgeInsets.all(12.w),
        filled: true,
        fillColor: AppThemeConfig.colors.white,
      ),
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppThemeConfig.colors.textDark,
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tải lên file (tuỳ chọn)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Upload đề bài, tài liệu cần chữa (Hình ảnh, PDF, Doc)',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppThemeConfig.colors.textGray,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _onAddFilePressed,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppThemeConfig.colors.borderColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.r),
              color: AppThemeConfig.colors.bgLight,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 32.sp,
                  color: AppThemeConfig.colors.primaryGreen,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Nhấn để chọn file',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppThemeConfig.colors.primaryGreen,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'hoặc kéo thả file vào đây',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppThemeConfig.colors.textGray,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (uploadedFiles.isNotEmpty) ...[
          SizedBox(height: 12.h),
          _buildFileList(),
        ],
      ],
    );
  }

  Widget _buildFileList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Các file đã chọn (${uploadedFiles.length})',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        ...uploadedFiles.asMap().entries.map((entry) {
          int index = entry.key;
          String file = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppThemeConfig.colors.bgLight,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppThemeConfig.colors.borderColor),
              ),
              child: Row(
                children: [
                  Icon(
                    _getFileIcon(file),
                    size: 20.sp,
                    color: AppThemeConfig.colors.primaryGreen,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      file,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppThemeConfig.colors.textDark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => uploadedFiles.removeAt(index));
                    },
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                      color: AppThemeConfig.colors.errorRed,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  IconData _getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (fileName.endsWith('.doc') ||
        fileName.endsWith('.docx')) {
      return Icons.description;
    } else if (fileName.endsWith('.jpg') ||
        fileName.endsWith('.png') ||
        fileName.endsWith('.jpeg')) {
      return Icons.image;
    }
    return Icons.attach_file;
  }

  void _onAddFilePressed() {
    // Fake file picker - in real app would use file_picker package
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn tệp',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
            SizedBox(height: 12.h),
            ListTile(
              leading: Icon(Icons.image, color: AppThemeConfig.colors.primaryGreen),
              title: Text('Hình ảnh (JPG, PNG)'),
              onTap: () {
                setState(() {
                  uploadedFiles.add('Hình ảnh_${DateTime.now().millisecond}.jpg');
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: AppThemeConfig.colors.primaryGreen),
              title: Text('PDF'),
              onTap: () {
                setState(() {
                  uploadedFiles.add('Tài liệu_${DateTime.now().millisecond}.pdf');
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.description, color: AppThemeConfig.colors.primaryGreen),
              title: Text('Word (DOC, DOCX)'),
              onTap: () {
                setState(() {
                  uploadedFiles.add('Đề bài_${DateTime.now().millisecond}.docx');
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButtonSection({
    required String title,
    required bool? value,
    required Function(bool?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildRadioOption(
                label: 'Có',
                value: true,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildRadioOption(
                label: 'Không',
                value: false,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption({
    required String label,
    required bool value,
    required bool? groupValue,
    required Function(bool?) onChanged,
  }) {
    final isSelected = groupValue == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color:
                isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.borderColor,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? AppThemeConfig.colors.lightGreen : AppThemeConfig.colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppThemeConfig.colors.primaryGreen
                      : AppThemeConfig.colors.borderColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppThemeConfig.colors.primaryGreen,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppThemeConfig.colors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyButton() {
    final subjects = booking.tutorSubjects ?? [];
    final isDisabled = (subjects.isNotEmpty && selectedSubject == null) ||
        selectedSessionType == null ||
        selectedLevel == null ||
        hasHomework == null ||
        teachInEnglish == null ||
        isLoading;

    return Container(
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        border: Border(
          top: BorderSide(color: AppThemeConfig.colors.borderColor, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GestureDetector(
        onTap: isDisabled ? null : _onContinuePressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isDisabled ? AppThemeConfig.colors.disabledGray : AppThemeConfig.colors.primaryGreen,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDisabled ? AppThemeConfig.colors.textGray : AppThemeConfig.colors.white,
                      ),
                    ),
                  )
                : Text(
                    'Tiếp tục',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppThemeConfig.colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
