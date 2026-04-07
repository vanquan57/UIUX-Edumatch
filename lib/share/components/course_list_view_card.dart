import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edu_match/core/config/app_colors.dart';

class CourseListViewCard extends StatelessWidget {
  final String id;
  final String title;
  final String instructorName;
  final String thumbnail;
  final double rating;
  final int reviewCount;
  final double price;
  final String badge;
  final DateTime lastUpdated;
  final int totalHours;
  final int totalLectures;
  final VoidCallback? onTap;
  final VoidCallback? onViewDetails;

  const CourseListViewCard({
    super.key,
    required this.id,
    required this.title,
    required this.instructorName,
    required this.thumbnail,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.badge,
    required this.lastUpdated,
    required this.totalHours,
    required this.totalLectures,
    this.onTap,
    this.onViewDetails,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Hôm nay';
    } else if (difference == 1) {
      return 'Hôm qua';
    } else if (difference < 7) {
      return '$difference ngày trước';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '$weeks tuần trước';
    } else {
      final months = (difference / 30).floor();
      return '$months tháng trước';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Thumbnail
            _buildThumbnail(),
            SizedBox(width: 12.w),
            // Course Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Badge
                    _buildTitleWithBadge(),
                    SizedBox(height: 6.h),
                    // Instructor
                    _buildInstructor(),
                    SizedBox(height: 6.h),
                    // Last Updated
                    _buildLastUpdated(),
                    SizedBox(height: 6.h),
                    // Duration and Lectures
                    _buildDurationInfo(),
                    SizedBox(height: 6.h),
                    // Rating
                    _buildRating(),
                    SizedBox(height: 8.h),
                    // Price and Action Button
                    _buildPriceAndAction(),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        bottomLeft: Radius.circular(12.r),
      ),
      child: Container(
        width: 120.w,
        height: 160.h,
        color: AppColors.bgLight,
        child: Image.asset(
          thumbnail,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.lightGreen,
              child: Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 40.sp,
                  color: AppColors.primaryGreen,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleWithBadge() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (badge.isNotEmpty) ...[
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 2.h,
            ),
            decoration: BoxDecoration(
              color: badge == 'Hot' ? AppColors.errorRed : AppColors.warningOrange,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              badge,
              style: GoogleFonts.poppins(
                fontSize: 8.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInstructor() {
    return Row(
      children: [
        Icon(
          Icons.person_outline,
          size: 14.sp,
          color: AppColors.textGray,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            instructorName,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textGray,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLastUpdated() {
    return Row(
      children: [
        Icon(
          Icons.update,
          size: 14.sp,
          color: AppColors.textGray,
        ),
        SizedBox(width: 4.w),
        Text(
          'Cập nhật ${_formatDate(lastUpdated)}',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildDurationInfo() {
    return Row(
      children: [
        // Total Hours
        Icon(
          Icons.access_time,
          size: 14.sp,
          color: AppColors.textGray,
        ),
        SizedBox(width: 4.w),
        Text(
          '${totalHours}h',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(width: 12.w),
        // Total Lectures
        Icon(
          Icons.play_circle_outline,
          size: 14.sp,
          color: AppColors.textGray,
        ),
        SizedBox(width: 4.w),
        Text(
          '$totalLectures bài',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.warningOrange,
          size: 14.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          rating.toString(),
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '($reviewCount đánh giá)',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        Text(
          '₫${(price / 1000).toStringAsFixed(0)}k',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGreen,
          ),
        ),
        // View Details Button
        GestureDetector(
          onTap: onViewDetails ?? onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'Xem chi tiết',
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}