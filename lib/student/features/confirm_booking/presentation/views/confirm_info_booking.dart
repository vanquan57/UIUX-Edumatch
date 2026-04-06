import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/student/data/models/booking_model.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConfirmInfoBookingPage extends StatefulWidget {
  const ConfirmInfoBookingPage({super.key});

  @override
  State<ConfirmInfoBookingPage> createState() => _ConfirmInfoBookingPageState();
}

class _ConfirmInfoBookingPageState extends State<ConfirmInfoBookingPage> {
  late BookingModel booking;

  // Fake pricing data
  static const double pricePerSession = 250000; // VND

  @override
  void initState() {
    super.initState();
    // Use mock booking data for prototype
    final mockTutor = TutorModel.mockTutors().first;
    booking = BookingModel(
      tutorId: mockTutor.id,
      tutorName: mockTutor.name,
      tutorAvatar: mockTutor.avatar,
      tutorSubjects: mockTutor.subjects,
      type: 'online',
      selectedTimeSlot: '09:00 - 10:00',
      subject: 'Toán',
      sessionDuration: 60,
    );
  }

  void _onPaymentPressed() {
    context.pushNamed('bookingPayment');
  }

  String _formatPrice(double price) {
    final int priceInt = price.toInt();
    final String priceStr = priceInt.toString();
    
    // Add thousand separators
    String result = '';
    for (int i = 0; i < priceStr.length; i++) {
      if (i > 0 && (priceStr.length - i) % 3 == 0) {
        result += '.';
      }
      result += priceStr[i];
    }
    return '$result₫';
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(colors)
        : _buildFullLayout();
  }

  Widget _buildLowFiLayout(AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Xác Nhận Thông Tin',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 16.h),

          // Tutor info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[TUTOR INFO]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.tutorName ?? 'Gia sư',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                ),
                if (booking.subject != null && booking.subject!.isNotEmpty)
                  Text(
                    booking.subject!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Learning type
          Text(
            'Loại Buổi Học',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              booking.type == 'online' ? 'Học Online (Video Call)' : 'Học Offline (Tại Địa Điểm)',
              style: TextStyle(
                fontSize: 12.sp,
                color: colors.textDark,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Location (if offline)
          if (booking.type == 'offline') ...[
            Text(
              'Địa Điểm',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                booking.address ?? 'Chưa cập nhật',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colors.textDark,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Schedule
          Text(
            'Lịch Học',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[SCHEDULE INFO]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.selectedTimeSlot ?? 'Chưa chọn',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colors.textDark,
                  ),
                ),
                if (booking.sessionDuration != null)
                  Text(
                    'Thời lượng: ${booking.sessionDuration} phút',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: colors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Requirements
          Text(
            'Yêu Cầu Học Tập',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[REQUIREMENTS]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                if (booking.subject != null && booking.subject!.isNotEmpty)
                  Text(
                    'Môn: ${booking.subject!}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textDark,
                    ),
                  ),
                if (booking.metadata?['level'] != null)
                  Text(
                    'Trình độ: ${booking.metadata!['level']}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textDark,
                    ),
                  ),
                if (booking.metadata?['note'] != null && booking.metadata!['note'].toString().isNotEmpty)
                  Text(
                    'Ghi chú: ${booking.metadata!['note']}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textDark,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Pricing
          Text(
            'Chi Phí',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[PRICING]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền:',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                    Text(
                      _formatPrice(pricePerSession),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          // Payment button
          GestureDetector(
            onTap: _onPaymentPressed,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.textDark, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
                color: colors.textDark,
              ),
              child: Center(
                child: Text(
                  'Tiến Hành Thanh Toán',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildTutorInfoCard(),
              SizedBox(height: 20.h),
              _buildSectionTitle('Loại Buổi Học'),
              SizedBox(height: 5.h),
              _buildLearningTypeCard(),
              SizedBox(height: 20.h),
              if (booking.type == 'offline') ...[
                _buildSectionTitle('Địa Điểm'),
                SizedBox(height: 5.h),
                _buildLocationCard(),
                SizedBox(height: 20.h),
              ],
              _buildSectionTitle('Lịch Học'),
              SizedBox(height: 5.h),
              _buildScheduleCard(),
              SizedBox(height: 20.h),
              _buildSectionTitle('Yêu Cầu Học Tập'),
              SizedBox(height: 5.h),
              _buildRequirementsCard(),
              SizedBox(height: 20.h),
              _buildSectionTitle('Chi Phí'),
              SizedBox(height: 5.h),
              _buildPricingCard(),
              SizedBox(height: 100.h), // Extra space for sticky button
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildStickyButton(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppThemeConfig.colors.bgLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.arrow_back,
              color: AppThemeConfig.colors.textDark,
              size: 24.sp,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Xác Nhận Thông Tin',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppThemeConfig.colors.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppThemeConfig.colors.textDark,
      ),
    );
  }

  Widget _buildTutorInfoCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.bgLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppThemeConfig.colors.primaryGreen,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: booking.tutorAvatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      booking.tutorAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.person,
                            color: AppThemeConfig.colors.white,
                            size: 32.sp,
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.person,
                      color: AppThemeConfig.colors.white,
                      size: 32.sp,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.tutorName ?? 'Gia sư',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppThemeConfig.colors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 12.sp,
                      color: AppThemeConfig.colors.primaryGreen,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      booking.subject != null && booking.subject!.isNotEmpty
                          ? booking.subject!
                          : 'Gia sư dạy kèm',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: booking.subject != null
                            ? AppThemeConfig.colors.primaryGreen
                            : AppThemeConfig.colors.textGray,
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

  Widget _buildLearningTypeCard() {
    final isOnline = booking.type == 'online';
    final icon = isOnline ? Icons.videocam : Icons.location_on;
    final methodLabel = isOnline ? 'Học Online (Video Call)' : 'Học Offline (Tại Địa Điểm)';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppThemeConfig.colors.primaryGreen, size: 22.sp),
          SizedBox(width: 12.w),
          Text(
            methodLabel,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppThemeConfig.colors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppThemeConfig.colors.primaryGreen, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  booking.address ?? 'Chưa cập nhật',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppThemeConfig.colors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (booking.latitude != null && booking.longitude != null) ...[
            SizedBox(height: 8.h),
            Text(
              'Tọa độ: ${booking.latitude?.toStringAsFixed(4)}, ${booking.longitude?.toStringAsFixed(4)}',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppThemeConfig.colors.textLightGray,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildScheduleCard() {
    final isMonthly = booking.scheduleType == 'monthly';
    final weekdayNames = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];

    Widget dateSection;
    if (isMonthly) {
      final weekdays = booking.selectedWeekdays ?? [];
      final weekdayLabel = weekdays.isEmpty
          ? 'Chưa chọn'
          : weekdays.map((d) => weekdayNames[d]).join(', ');
      final startDate = booking.monthlyStartDate;
      final startDateLabel = startDate != null
          ? DateFormat('dd/MM/yyyy').format(startDate)
          : 'Chưa chọn';

      dateSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 8-session info banner
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppThemeConfig.colors.lightGreen,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: AppThemeConfig.colors.primaryGreen.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppThemeConfig.colors.primaryGreen,
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '8 buổi/tháng • Hoàn thành khi học đủ 8 buổi',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppThemeConfig.colors.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // Weekdays row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.date_range,
                color: AppThemeConfig.colors.primaryGreen,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Học hàng tuần',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppThemeConfig.colors.textLightGray,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      weekdayLabel,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppThemeConfig.colors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Start date row
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppThemeConfig.colors.primaryGreen,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày bắt đầu',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppThemeConfig.colors.textLightGray,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      startDateLabel,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppThemeConfig.colors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      final dates = booking.selectedDates ?? [];
      Widget datesWidget;
      if (dates.isEmpty) {
        datesWidget = Text(
          'Chưa chọn',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppThemeConfig.colors.textDark,
          ),
        );
      } else if (dates.length == 1) {
        datesWidget = Text(
          DateFormat('dd/MM/yyyy').format(dates.first),
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppThemeConfig.colors.textDark,
          ),
        );
      } else {
        datesWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dates.length} ngày học',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppThemeConfig.colors.textLightGray,
              ),
            ),
            SizedBox(height: 4.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: dates.map((d) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppThemeConfig.colors.lightGreen,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppThemeConfig.colors.primaryGreen, width: 1),
                  ),
                  child: Text(
                    DateFormat('dd/MM').format(d),
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppThemeConfig.colors.primaryGreen,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }

      dateSection = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.calendar_today, color: AppThemeConfig.colors.primaryGreen, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(child: datesWidget),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dateSection,
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.access_time, color: AppThemeConfig.colors.primaryGreen, size: 20.sp),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.selectedTimeSlot ?? 'Chưa chọn',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppThemeConfig.colors.textDark,
                    ),
                  ),
                  if (booking.sessionDuration != null)
                    Text(
                      'Thời lượng: ${booking.sessionDuration} phút',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppThemeConfig.colors.textLightGray,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsCard() {
    final metadata = booking.metadata ?? {};
    final sessionType = metadata['sessionType'] ?? 'Chưa chọn';
    final level = metadata['level'] ?? 'Chưa chọn';
    final note = metadata['note'] ?? '';
    final uploadedFiles = (metadata['uploadedFiles'] as List<dynamic>?) ?? [];
    final hasHomework = metadata['hasHomework'];
    final teachInEnglish = metadata['teachInEnglish'];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject
          if (booking.subject != null && booking.subject!.isNotEmpty) ...[
            _buildRequirementRow('Môn Học', booking.subject!),
            SizedBox(height: 12.h),
          ],
          // Session Type
          _buildRequirementRow('Loại Buổi Học', sessionType),
          SizedBox(height: 12.h),
          // Level
          _buildRequirementRow('Trình Độ', level),
          SizedBox(height: 12.h),
          // Homework
          _buildRequirementRow(
            'Có Bài Tập Về Nhà',
            hasHomework == true ? 'Có' : hasHomework == false ? 'Không' : 'Chưa chọn',
          ),
          SizedBox(height: 12.h),
          // English Teaching
          _buildRequirementRow(
            'Dạy Bằng Tiếng Anh',
            teachInEnglish == true ? 'Có' : teachInEnglish == false ? 'Không' : 'Chưa chọn',
          ),
          if (note.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildRequirementRow('Ghi Chú', note, isMultiline: true),
          ],
          if (uploadedFiles.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tệp Đính Kèm',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppThemeConfig.colors.textGray,
                  ),
                ),
                SizedBox(height: 6.h),
                Column(
                  children: List.generate(
                    uploadedFiles.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        children: [
                          Icon(
                            _getFileIcon(uploadedFiles[index]),
                            color: AppThemeConfig.colors.primaryGreen,
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              uploadedFiles[index],
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppThemeConfig.colors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String label, String value, {bool isMultiline = false}) {
    return Row(
      crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppThemeConfig.colors.textGray,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppThemeConfig.colors.textDark,
            ),
            maxLines: isMultiline ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData _getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
      return Icons.description;
    } else if (fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg') ||
        fileName.endsWith('.png') ||
        fileName.endsWith('.gif')) {
      return Icons.image;
    }
    return Icons.attach_file;
  }

  Widget _buildPricingCard() {
    // Calculate total price (1 session for now)
    final totalPrice = pricePerSession;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.lightGreen,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppThemeConfig.colors.primaryGreen, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giá Mỗi Buổi',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeConfig.colors.textDark,
                ),
              ),
              Text(
                _formatPrice(pricePerSession),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeConfig.colors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: AppThemeConfig.colors.textGray, height: 1),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng Tiền',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppThemeConfig.colors.primaryGreen,
                ),
              ),
              Text(
                _formatPrice(totalPrice),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppThemeConfig.colors.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStickyButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        border: Border(
          top: BorderSide(color: AppThemeConfig.colors.dividerColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppThemeConfig.colors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: GestureDetector(
        onTap: _onPaymentPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: AppThemeConfig.colors.primaryGreen,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              'Tiến Hành Thanh Toán',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppThemeConfig.colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
