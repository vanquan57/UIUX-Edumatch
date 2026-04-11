import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CertificatePage extends StatelessWidget {
  final String studentName;
  final String courseTitle;
  final String instructorName;
  final DateTime completionDate;

  const CertificatePage({
    super.key,
    required this.studentName,
    required this.courseTitle,
    required this.instructorName,
    required this.completionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        // Certificate content
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              
              // Certificate card
              _buildCertificateCard(),
              
              SizedBox(height: 30.h),
              
              // Action buttons
              _buildActionButtons(context),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
                return;
              }
              context.go(AppRouter.myCourses);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Chứng chỉ hoàn thành',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Certificate icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium,
              size: 40.sp,
              color: AppColors.primaryGreen,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Congratulations title
          Text(
            '🎉 Chúc mừng! 🎉',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryGreen,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16.h),
          
          // Student name
          Text(
            studentName,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 12.h),
          
          // Completion message
          Text(
            'Bạn đã hoàn thành xuất sắc khóa học',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGray,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16.h),
          
          // Course title
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primaryGreen.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              courseTitle,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Certificate details
          _buildCertificateDetails(),
          
          SizedBox(height: 20.h),
          
          // Certificate badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'CHỨNG CHỈ HOÀN THÀNH',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateDetails() {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Column(
      children: [
        // Instructor
        _buildDetailRow(
          icon: Icons.person_outline,
          label: 'Giảng viên',
          value: instructorName,
        ),
        
        SizedBox(height: 12.h),
        
        // Completion date
        _buildDetailRow(
          icon: Icons.calendar_today_outlined,
          label: 'Ngày hoàn thành',
          value: dateFormat.format(completionDate),
        ),
        
        SizedBox(height: 12.h),
        
        // Certificate ID (fake)
        _buildDetailRow(
          icon: Icons.confirmation_number_outlined,
          label: 'Mã chứng chỉ',
          value: 'EDU${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: AppColors.textGray,
        ),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Back to my courses button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              context.go(AppRouter.myCourses);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Về trang khóa học của tôi',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Action buttons row
        Row(
          children: [
            // Save image button
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showSaveImageDialog(context);
                  },
                  icon: Icon(
                    Icons.download_outlined,
                    size: 18.sp,
                  ),
                  label: Text(
                    'Lưu ảnh',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryGreen,
                    side: BorderSide(color: AppColors.primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Share button
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showShareDialog(context);
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    size: 18.sp,
                  ),
                  label: Text(
                    'Chia sẻ',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryGreen,
                    side: BorderSide(color: AppColors.primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSaveImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.download_outlined,
                color: AppColors.primaryGreen,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Lưu chứng chỉ',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            'Chứng chỉ đã được lưu vào thư viện ảnh của bạn.',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: AppColors.textGray,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Đóng',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.share_outlined,
                color: AppColors.primaryGreen,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Chia sẻ chứng chỉ',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chọn cách thức chia sẻ chứng chỉ của bạn:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.textGray,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: Implement Facebook sharing
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.link,
                    label: 'Copy Link',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: Implement link copying
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.more_horiz,
                    label: 'Khác',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: Implement other sharing options
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Hủy',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGray,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: AppColors.primaryGreen,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}