import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/config/app_theme_config.dart';
import '../../../student/data/models/tutor_model.dart';
import 'lowfi_card.dart';

/// Low-Fidelity Tutor Card Component
/// Ultra-simple wireframe version for sketching
class LowFiTutorCard extends StatelessWidget {
  const LowFiTutorCard({
    super.key,
    required this.tutor,
    this.onTap,
    this.showFullInfo = true,
  });

  final TutorModel tutor;
  final VoidCallback? onTap;
  final bool showFullInfo;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: colors.borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple avatar box
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor),
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: Icon(
                Icons.person_outline,
                size: 16.sp,
                color: colors.textLightGray,
              ),
            ),
            SizedBox(height: 6.h),
            
            // Name placeholder
            Text(
              '[Tên gia sư]',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: colors.textDark,
              ),
            ),
            SizedBox(height: 2.h),
            
            // Subject placeholder
            Text(
              '[Môn học]',
              style: TextStyle(
                fontSize: 10.sp,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            
            // Price placeholder
            Text(
              '[Giá/h]',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: colors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

/// Compact version for lists
class LowFiTutorListItem extends StatelessWidget {
  const LowFiTutorListItem({
    super.key,
    required this.tutor,
    this.onTap,
  });

  final TutorModel tutor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return LowFiCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          LowFiAvatar(
            size: 36.w,
            name: tutor.name,
            imageUrl: tutor.avatar,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tutor.name.isNotEmpty ? tutor.name : '[Tên gia sư]',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  tutor.subjects.isNotEmpty ? tutor.subjects.first : '[Môn học]',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(tutor.pricePerHour / 1000).toInt()}k/h',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.textDark,
                ),
              ),
              SizedBox(height: 2.h),
              LowFiRating(
                rating: tutor.rating,
                size: 10.sp,
                showNumber: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}