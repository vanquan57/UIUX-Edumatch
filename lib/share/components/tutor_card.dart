import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/share/components/rating_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorCard extends StatelessWidget {
  final String id;
  final String name;
  final String avatar;
  final double rating;
  final int reviewCount;
  final double pricePerHour;
  final List<String> subjects;
  final bool isOnline;
  final VoidCallback onViewProfile;
  final VoidCallback? onTap;

  const TutorCard({
    super.key,
    required this.id,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    required this.subjects,
    required this.isOnline,
    required this.onViewProfile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? onViewProfile,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar section with online indicator
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: Container(
                    height: 120.h,
                    color: AppColors.bgLight,
                    child: Image.asset(
                      avatar,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE8F5E9),
                          child: Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 48.sp,
                              color: const Color(0xFF1C8659),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Online indicator
                if (isOnline)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Đang online',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Name
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    // Rating
                    RatingDisplay(
                      rating: rating,
                      reviewCount: reviewCount,
                      compact: true,
                    ),
                    SizedBox(height: 6.h),
                    // Price
                    Text(
                      '${(pricePerHour / 1000).toStringAsFixed(0)}K/h',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1C8659),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    // Subjects tags
                    Expanded(
                      child: Wrap(
                        spacing: 3.w,
                        runSpacing: 3.h,
                        children: subjects.take(2).map((subject) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              subject,
                              style: GoogleFonts.poppins(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1C8659),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 32.h,
                      child: ElevatedButton(
                        onPressed: onViewProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C8659),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Xem hồ sơ',
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
