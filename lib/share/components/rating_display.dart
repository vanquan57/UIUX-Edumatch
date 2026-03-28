import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingDisplay extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool compact;

  const RatingDisplay({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.warningOrange,
          size: compact ? 14.sp : 16.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          rating.toStringAsFixed(1),
          style: GoogleFonts.poppins(
            fontSize: compact ? 12.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '($reviewCount)',
          style: GoogleFonts.poppins(
            fontSize: compact ? 11.sp : 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }
}
