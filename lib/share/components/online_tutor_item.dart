import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineTutorItem extends StatelessWidget {
  final String id;
  final String name;
  final String avatar;
  final VoidCallback onChatPressed;

  const OnlineTutorItem({
    super.key,
    required this.id,
    required this.name,
    required this.avatar,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with online indicator
        Stack(
          children: [
            CircleAvatar(radius: 40.r, backgroundImage: AssetImage(avatar)),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Name
        SizedBox(
          width: 100.w,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Chat button
        SizedBox(
          width: 100.w,
          height: 32.h,
          child: Material(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: onChatPressed,
              borderRadius: BorderRadius.circular(8.r),
              child: Center(
                child: Text(
                  'Chat ngay',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
