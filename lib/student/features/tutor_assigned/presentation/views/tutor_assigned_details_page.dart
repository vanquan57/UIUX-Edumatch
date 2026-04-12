import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/tutor_assigned_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TutorAssignedDetailsPage extends StatefulWidget {
  final TutorAssignedModel tutorAssigned;

  const TutorAssignedDetailsPage({super.key, required this.tutorAssigned});

  @override
  State<TutorAssignedDetailsPage> createState() => _TutorAssignedDetailsPageState();
}

class _TutorAssignedDetailsPageState extends State<TutorAssignedDetailsPage> {
  late TutorAssignedModel tutorAssigned;
  
  // Form đánh giá tutor
  double _selectedRating = 5.0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmittingReview = false;
  bool _isCancelling = false;

  @override
  void initState() {
    super.initState();
    tutorAssigned = widget.tutorAssigned;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTutorInfoSection(),
          _buildScheduleInfoSection(),
          _buildLearningDetailsSection(),
          _buildProgressSection(),
          if (tutorAssigned.status == 'completed') _buildReviewSection(),
          if (tutorAssigned.status == 'ongoing') _buildCancelSection(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: MediaQuery.of(context).padding.top + 12.h,
        bottom: 12.h,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.textDark,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Chi tiết gia sư đã đặt',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          _buildStatusBadge(tutorAssigned.status),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTutorInfoSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35.r),
                child: Image.asset(
                  tutorAssigned.tutorAvatar,
                  width: 70.w,
                  height: 70.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(35.r),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 32.sp,
                        color: AppColors.textGray,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorAssigned.tutorName,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          tutorAssigned.tutorRating.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            tutorAssigned.subject,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          tutorAssigned.learningType == 'online' 
                              ? Icons.videocam_outlined 
                              : Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppColors.textGray,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          tutorAssigned.learningType == 'online' ? 'Học Online' : 'Học Offline',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (tutorAssigned.note != null && tutorAssigned.note!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.primaryGreen.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ghi chú',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    tutorAssigned.note!,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScheduleInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Text(
            'Thông tin lịch học',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 16.h),
          _buildScheduleDetails(),
        ],
      ),
    );
  }

  Widget _buildScheduleDetails() {
    final isMonthly = tutorAssigned.scheduleType == 'monthly';
    final weekdayNames = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];

    if (isMonthly) {
      final weekdays = tutorAssigned.selectedWeekdays ?? [];
      final weekdayLabel = weekdays.isEmpty
          ? 'Chưa chọn'
          : weekdays.map((d) => weekdayNames[d]).join(', ');
      final startDate = tutorAssigned.monthlyStartDate;
      final startDateLabel = startDate != null
          ? DateFormat('dd/MM/yyyy').format(startDate)
          : 'Chưa chọn';

      return Column(
        children: [
          _buildInfoRow(
            icon: Icons.calendar_month_outlined,
            label: 'Loại lịch học',
            value: 'Hàng tuần',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.date_range,
            label: 'Các ngày trong tuần',
            value: weekdayLabel,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.event,
            label: 'Ngày bắt đầu',
            value: startDateLabel,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.access_time,
            label: 'Thời gian',
            value: tutorAssigned.selectedTimeSlot ?? 'Chưa chọn',
          ),
          if (tutorAssigned.sessionDuration != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.timer_outlined,
              label: 'Thời lượng mỗi buổi',
              value: '${tutorAssigned.sessionDuration} phút',
            ),
          ],
        ],
      );
    } else {
      final dates = tutorAssigned.selectedDates ?? [];
      return Column(
        children: [
          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Loại lịch học',
            value: 'Theo ngày cụ thể',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.event_available,
            label: 'Số buổi học',
            value: '${dates.length} buổi',
          ),
          if (dates.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_view_day,
                  color: AppColors.primaryGreen,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Các ngày học',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textGray,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 6.h,
                        children: dates.map((date) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primaryGreen.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(date),
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.access_time,
            label: 'Thời gian',
            value: tutorAssigned.selectedTimeSlot ?? 'Chưa chọn',
          ),
        ],
      );
    }
  }

  Widget _buildLearningDetailsSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
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
          Text(
            'Chi tiết học tập',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 16.h),
          if (tutorAssigned.sessionType != null)
            _buildInfoRow(
              icon: Icons.school_outlined,
              label: 'Loại buổi học',
              value: tutorAssigned.sessionType!,
            ),
          if (tutorAssigned.level != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.grade_outlined,
              label: 'Trình độ',
              value: tutorAssigned.level!,
            ),
          ],
          if (tutorAssigned.hasHomework != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.assignment_outlined,
              label: 'Bài tập về nhà',
              value: tutorAssigned.hasHomework! ? 'Có' : 'Không',
            ),
          ],
          if (tutorAssigned.teachInEnglish != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.language_outlined,
              label: 'Dạy bằng tiếng Anh',
              value: tutorAssigned.teachInEnglish! ? 'Có' : 'Không',
            ),
          ],
          if (tutorAssigned.learningType == 'offline' && tutorAssigned.address != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.location_on_outlined,
              label: 'Địa chỉ học',
              value: tutorAssigned.address!,
            ),
          ],
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.attach_money_outlined,
            label: 'Giá mỗi buổi',
            value: _formatCurrency(tutorAssigned.pricePerSession ?? 0),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Ngày đặt',
            value: DateFormat('dd/MM/yyyy').format(tutorAssigned.bookingDate),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tiến độ học tập',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '${tutorAssigned.completedSessions}/${tutorAssigned.totalSessions} buổi',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: tutorAssigned.completionPercentage / 100,
            backgroundColor: AppColors.bgLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            minHeight: 8.h,
          ),
          SizedBox(height: 8.h),
          Text(
            '${tutorAssigned.completionPercentage.toStringAsFixed(1)}% hoàn thành',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textGray,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
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
                Icon(
                  Icons.payments_outlined,
                  color: AppColors.primaryGreen,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tổng chi phí',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      Text(
                        _formatCurrency(tutorAssigned.totalAmount),
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
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
          Row(
            children: [
              Icon(
                Icons.rate_review_outlined,
                color: AppColors.primaryGreen,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Đánh giá gia sư',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildRatingSelector(),
          SizedBox(height: 20.h),
          _buildCommentInput(),
          SizedBox(height: 20.h),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đánh giá chất lượng giảng dạy',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starValue = index + 1.0;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRating = starValue;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  starValue <= _selectedRating ? Icons.star : Icons.star_border,
                  size: 32.sp,
                  color: starValue <= _selectedRating ? Colors.amber : AppColors.textLightGray,
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            _getRatingText(_selectedRating),
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nhận xét về gia sư',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          child: TextField(
            controller: _commentController,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: 'Chia sẻ trải nghiệm học tập của bạn với gia sư này...',
              hintStyle: GoogleFonts.inter(
                fontSize: 13.sp,
                color: AppColors.textLightGray,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.w),
              counterStyle: GoogleFonts.inter(
                fontSize: 11.sp,
                color: AppColors.textLightGray,
              ),
            ),
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSubmittingReview ? null : _submitReview,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: _isSubmittingReview
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Đang gửi...',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                'Gửi đánh giá',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  String _getRatingText(double rating) {
    switch (rating.toInt()) {
      case 1:
        return 'Rất không hài lòng';
      case 2:
        return 'Không hài lòng';
      case 3:
        return 'Bình thường';
      case 4:
        return 'Hài lòng';
      case 5:
        return 'Rất hài lòng';
      default:
        return 'Chọn đánh giá';
    }
  }

  void _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập nhận xét về gia sư'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingReview = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubmittingReview = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đánh giá đã được gửi thành công!'),
        backgroundColor: AppColors.successGreen,
      ),
    );

    // Clear form
    _commentController.clear();
    setState(() {
      _selectedRating = 5.0;
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.primaryGreen,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancelSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
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
          Row(
            children: [
              Icon(
                Icons.cancel_outlined,
                color: AppColors.errorRed,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Hủy khóa học',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.errorRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.errorRed.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_outlined,
                      color: AppColors.errorRed,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Lưu ý khi hủy khóa học',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.errorRed,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  '• Bạn sẽ chỉ được hoàn lại tiền cho các buổi học chưa diễn ra\n'
                  '• Các buổi học đã hoàn thành sẽ không được hoàn tiền\n'
                  '• Quá trình hoàn tiền có thể mất 3-5 ngày làm việc',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _buildRefundInfo(),
          SizedBox(height: 16.h),
          _buildCancelButton(),
        ],
      ),
    );
  }

  Widget _buildRefundInfo() {
    final remainingSessions = tutorAssigned.totalSessions - tutorAssigned.completedSessions;
    final refundAmount = remainingSessions * (tutorAssigned.pricePerSession ?? 0.0);
    
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số buổi còn lại',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '$remainingSessions buổi',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số tiền được hoàn lại',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                _formatCurrency(refundAmount),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isCancelling ? null : _showCancelConfirmation,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.errorRed,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: _isCancelling
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Đang xử lý...',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                'Hủy khóa học',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _showCancelConfirmation() {
    final remainingSessions = tutorAssigned.totalSessions - tutorAssigned.completedSessions;
    final refundAmount = remainingSessions * (tutorAssigned.pricePerSession ?? 0.0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_outlined,
                color: AppColors.errorRed,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Xác nhận hủy',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bạn có chắc chắn muốn hủy khóa học với gia sư ${tutorAssigned.tutorName}?',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.primaryGreen.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Buổi còn lại:',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          '$remainingSessions buổi',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hoàn lại:',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          _formatCurrency(refundAmount),
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Không',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelCourse();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorRed,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Xác nhận hủy',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _cancelCourse() async {
    setState(() {
      _isCancelling = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isCancelling = false;
      // Update status to cancelled
      tutorAssigned = tutorAssigned.copyWith(status: 'cancelled');
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Khóa học đã được hủy thành công. Tiền sẽ được hoàn lại trong 3-5 ngày làm việc.'),
        backgroundColor: AppColors.successGreen,
        duration: const Duration(seconds: 4),
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
}