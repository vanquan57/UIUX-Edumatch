import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectInterestPage extends StatefulWidget {
  final String role;
  const SubjectInterestPage({super.key, required this.role});

  @override
  State<SubjectInterestPage> createState() => _SubjectInterestPageState();
}

class _SubjectInterestPageState extends State<SubjectInterestPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedSubjects = {};
  String _searchQuery = '';

  static const List<Map<String, dynamic>> _allSubjects = [
    {'name': 'Toán học', 'icon': Icons.calculate_rounded},
    {'name': 'Ngữ văn', 'icon': Icons.menu_book_rounded},
    {'name': 'Tiếng Anh', 'icon': Icons.language_rounded},
    {'name': 'Vật lý', 'icon': Icons.science_rounded},
    {'name': 'Hóa học', 'icon': Icons.biotech_rounded},
    {'name': 'Sinh học', 'icon': Icons.eco_rounded},
    {'name': 'Lịch sử', 'icon': Icons.history_edu_rounded},
    {'name': 'Địa lý', 'icon': Icons.public_rounded},
    {'name': 'GDCD', 'icon': Icons.gavel_rounded},
    {'name': 'Tin học', 'icon': Icons.computer_rounded},
    {'name': 'Âm nhạc', 'icon': Icons.music_note_rounded},
    {'name': 'Mỹ thuật', 'icon': Icons.palette_rounded},
    {'name': 'Thể dục', 'icon': Icons.sports_basketball_rounded},
    {'name': 'Tiếng Nhật', 'icon': Icons.g_translate_rounded},
    {'name': 'Tiếng Trung', 'icon': Icons.g_translate_rounded},
    {'name': 'Tiếng Pháp', 'icon': Icons.g_translate_rounded},
  ];

  List<Map<String, dynamic>> get _filteredSubjects {
    if (_searchQuery.isEmpty) return _allSubjects;
    return _allSubjects
        .where((s) =>
            (s['name'] as String)
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _continue() {
    if (_selectedSubjects.isEmpty) return;
    context.go(AppRouter.onboardingProfileSetup, extra: widget.role);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    final filtered = _filteredSubjects;
    final canContinue = _selectedSubjects.isNotEmpty;

    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  Row(
                    children: [
                      _ProgressDot(isActive: false, isDone: true),
                      _ProgressLine(),
                      _ProgressDot(isActive: true, isDone: false),
                      _ProgressLine(),
                      _ProgressDot(isActive: false, isDone: false),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Bạn quan tâm\nmôn học nào?',
                    style: GoogleFonts.poppins(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.textDark,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Chọn ít nhất 1 môn để nhận gợi ý gia sư phù hợp.',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: colors.textGray,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Search bar
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, color: colors.textDark),
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm môn học...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: colors.textLightGray,
                      ),
                      prefixIcon: AppThemeConfig.isLowFidelityMode 
                          ? null 
                          : Icon(
                              Icons.search_rounded,
                              color: colors.primaryGreen,
                              size: 22.sp,
                            ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: colors.textGray,
                                size: 18.sp,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: AppThemeConfig.isLowFidelityMode 
                          ? colors.white 
                          : colors.bgLight,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: AppThemeConfig.isLowFidelityMode 
                            ? BorderSide(color: colors.borderColor, width: 1.5)
                            : BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: AppThemeConfig.isLowFidelityMode 
                            ? BorderSide(color: colors.borderColor, width: 1.5)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConfig.isLowFidelityMode ? 4.r : 12.r,
                        ),
                        borderSide: BorderSide(
                          color: AppThemeConfig.isLowFidelityMode 
                              ? colors.textDark 
                              : colors.primaryGreen, 
                          width: AppThemeConfig.isLowFidelityMode ? 2 : 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Subject chips
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 48.sp, color: colors.textLightGray),
                          SizedBox(height: 12.h),
                          Text(
                            'Không tìm thấy môn học',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: colors.textGray,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: filtered.map((subject) {
                          final name = subject['name'] as String;
                          final icon = subject['icon'] as IconData;
                          final isSelected = _selectedSubjects.contains(name);
                          return _SubjectChip(
                            name: name,
                            icon: icon,
                            isSelected: isSelected,
                            onTap: () => setState(() {
                              isSelected
                                  ? _selectedSubjects.remove(name)
                                  : _selectedSubjects.add(name);
                            }),
                          );
                        }).toList(),
                      ),
                    ),
            ),

            // Bottom area
            Container(
              decoration: BoxDecoration(
                color: colors.white,
                border: AppThemeConfig.isLowFidelityMode 
                    ? Border(top: BorderSide(color: colors.borderColor, width: 1.5))
                    : null,
                boxShadow: AppThemeConfig.isLowFidelityMode 
                    ? null 
                    : [
                        BoxShadow(
                          color: colors.shadowColor,
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (canContinue)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppThemeConfig.isLowFidelityMode 
                                  ? colors.bgLight 
                                  : colors.lightGreen,
                              borderRadius: BorderRadius.circular(
                                AppThemeConfig.isLowFidelityMode ? 4.r : 20.r,
                              ),
                              border: AppThemeConfig.isLowFidelityMode 
                                  ? Border.all(color: colors.borderColor, width: 1)
                                  : null,
                            ),
                            child: Text(
                              'Đã chọn ${_selectedSubjects.length} môn học',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: colors.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  LowFiButton(
                    text: 'Tiếp tục',
                    onTap: canContinue ? _continue : null,
                    type: LowFiButtonType.primary,
                    size: LowFiButtonSize.large,
                    width: double.infinity,
                    isEnabled: canContinue,
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

class _SubjectChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SubjectChip({
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected 
              ? (AppThemeConfig.isLowFidelityMode ? colors.textDark : colors.primaryGreen)
              : colors.white,
          borderRadius: BorderRadius.circular(
            AppThemeConfig.isLowFidelityMode ? 4.r : 40.r,
          ),
          border: Border.all(
            color: isSelected 
                ? (AppThemeConfig.isLowFidelityMode ? colors.textDark : colors.primaryGreen)
                : colors.borderColor,
            width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1.5,
          ),
          boxShadow: AppThemeConfig.isLowFidelityMode 
              ? null 
              : isSelected
                  ? [
                      BoxShadow(
                        color: colors.primaryGreen.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!AppThemeConfig.isLowFidelityMode)
              Icon(
                isSelected ? Icons.check_circle_rounded : icon,
                size: 16.sp,
                color: isSelected ? colors.white : colors.textGray,
              ),
            if (!AppThemeConfig.isLowFidelityMode) SizedBox(width: 6.w),
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? colors.white : colors.textDark,
              ),
            ),
          ],
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
    final colors = AppThemeConfig.colors;
    
    Color color;
    if (isDone) {
      color = colors.primaryGreen;
    } else if (isActive) {
      color = colors.primaryGreen;
    } else {
      color = colors.disabledGray;
    }

    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        shape: AppThemeConfig.isLowFidelityMode ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: AppThemeConfig.isLowFidelityMode ? BorderRadius.circular(4.r) : null,
        color: (isActive || isDone) ? color : colors.white,
        border: Border.all(
          color: color, 
          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 2,
        ),
      ),
      child: isDone
          ? Icon(
              AppThemeConfig.isLowFidelityMode ? Icons.check : Icons.check_rounded, 
              color: colors.white, 
              size: 14.sp,
            )
          : Center(
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: AppThemeConfig.isLowFidelityMode ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: AppThemeConfig.isLowFidelityMode ? BorderRadius.circular(2.r) : null,
                  color: isActive ? colors.white : color,
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
    final colors = AppThemeConfig.colors;
    
    return Expanded(
      child: Container(
        height: AppThemeConfig.isLowFidelityMode ? 1.5 : 2,
        color: colors.primaryGreen.withOpacity(0.3),
      ),
    );
  }
}
