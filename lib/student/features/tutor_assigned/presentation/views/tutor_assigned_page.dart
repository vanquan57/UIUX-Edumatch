import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/tutor_assigned_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TutorAssignedPage extends StatefulWidget {
  const TutorAssignedPage({super.key});

  @override
  State<TutorAssignedPage> createState() => _TutorAssignedPageState();
}

class _TutorAssignedPageState extends State<TutorAssignedPage> {
  // Lấy fake data từ model
  late List<TutorAssignedModel> tutorAssignedList;

  @override
  void initState() {
    super.initState();
    tutorAssignedList = TutorAssignedModel.getFakeData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildTutorAssignedList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Lịch sử gia sư đã đặt',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorAssignedList() {
    if (tutorAssignedList.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: tutorAssignedList.length,
      itemBuilder: (context, index) {
        final tutorAssigned = tutorAssignedList[index];
        return _buildTutorAssignedCard(tutorAssigned);
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 80.sp,
              color: AppColors.textLightGray,
            ),
            SizedBox(height: 16.h),
            Text(
              'Chưa có gia sư nào được đặt',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textGray,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Hãy tìm kiếm và đặt gia sư phù hợp với bạn',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textLightGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorAssignedCard(TutorAssignedModel tutorAssigned) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          // Header với avatar và thông tin cơ bản
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image.asset(
                  tutorAssigned.tutorAvatar,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 24.sp,
                        color: AppColors.textGray,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorAssigned.tutorName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          tutorAssigned.tutorRating.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(tutorAssigned.status),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Thông tin tổng quan
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.book_outlined,
                  label: tutorAssigned.subject,
                  color: AppColors.primaryGreen,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSummaryItem(
                  icon: tutorAssigned.learningType == 'online' 
                      ? Icons.videocam_outlined 
                      : Icons.location_on_outlined,
                  label: tutorAssigned.learningType == 'online' ? 'Online' : 'Offline',
                  color: tutorAssigned.learningType == 'online' 
                      ? AppColors.accentGreen 
                      : AppColors.primaryGreen,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.attach_money_outlined,
                  label: _formatCurrency(tutorAssigned.totalAmount),
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Progress bar cho trạng thái ongoing
          if (tutorAssigned.status == 'ongoing') 
            _buildProgressSection(tutorAssigned)
          else
            // Hiển thị thông tin tóm tắt cho các trạng thái khác
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đã hoàn thành: ${tutorAssigned.completedSessions}/${tutorAssigned.totalSessions} buổi',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                  if (tutorAssigned.selectedTimeSlot != null)
                    Text(
                      tutorAssigned.selectedTimeSlot!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark,
                      ),
                    ),
                ],
              ),
            ),
          
          SizedBox(height: 16.h),
          
          // Button xem thêm
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _viewTutorDetails(tutorAssigned),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Xem thêm',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String text;
    
    switch (status) {
      case 'completed':
        backgroundColor = AppColors.successGreen.withOpacity(0.1);
        textColor = AppColors.successGreen;
        text = 'Hoàn thành';
        break;
      case 'ongoing':
        backgroundColor = AppColors.primaryGreen.withOpacity(0.1);
        textColor = AppColors.primaryGreen;
        text = 'Đang học';
        break;
      case 'cancelled':
        backgroundColor = AppColors.errorRed.withOpacity(0.1);
        textColor = AppColors.errorRed;
        text = 'Đã hủy';
        break;
      default:
        backgroundColor = AppColors.textGray.withOpacity(0.1);
        textColor = AppColors.textGray;
        text = 'Không xác định';
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: color,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(TutorAssignedModel tutorAssigned) {
    final progress = tutorAssigned.completionPercentage / 100;
    
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tiến độ học tập',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreen,
                  ),
                ),
                SizedBox(height: 4.h),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                  minHeight: 4.h,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '${tutorAssigned.completedSessions}/${tutorAssigned.totalSessions}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    final int amountInt = amount.toInt();
    final String amountStr = amountInt.toString();
    
    // Add thousand separators
    String result = '';
    for (int i = 0; i < amountStr.length; i++) {
      if (i > 0 && (amountStr.length - i) % 3 == 0) {
        result += '.';
      }
      result += amountStr[i];
    }
    return '${result}₫';
  }

  void _viewTutorDetails(TutorAssignedModel tutorAssigned) {
    context.pushNamed('tutorAssignedDetails', extra: tutorAssigned);
  }
}