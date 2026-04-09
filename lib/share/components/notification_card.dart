import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final bool compact;
  final EdgeInsetsGeometry? margin;

  const NotificationCard({
    super.key,
    required this.notification,
    this.compact = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(compact ? 10.w : 14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: notification.isUnread
              ? AppColors.primaryGreenLight
              : AppColors.borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: compact ? 30.w : 36.w,
            height: compact ? 30.w : 36.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.videocam_rounded,
              color: AppColors.primaryGreen,
              size: compact ? 16.sp : 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: compact ? 12.sp : 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      notification.createdAt,
                      style: GoogleFonts.poppins(
                        fontSize: compact ? 10.sp : 11.sp,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  notification.message,
                  maxLines: compact ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: compact ? 11.sp : 12.sp,
                    color: AppColors.textGray,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: compact ? 12.sp : 13.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        notification.classTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: compact ? 10.sp : 11.sp,
                          color: AppColors.primaryGreenDark,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
