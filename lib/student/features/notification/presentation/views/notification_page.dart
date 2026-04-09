import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/share/components/notification_card.dart';
import 'package:edu_match/student/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationModel.mockOnlineClassNotifications();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông báo buổi học online',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Tất cả thông báo liên quan đến lịch học và lớp học online của bạn.',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 16.h),
        if (notifications.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              'Không có thông báo nào cả',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: AppColors.textGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ListView.separated(
            itemCount: notifications.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              return NotificationCard(notification: notifications[index]);
            },
          ),
      ],
    );
  }
}
