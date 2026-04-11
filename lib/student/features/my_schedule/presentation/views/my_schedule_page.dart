import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/my_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MySchedulePage extends StatefulWidget {
  const MySchedulePage({super.key});

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  late DateTime currentWeekStart;
  late List<MyScheduleModel> currentWeekSchedules;
  final PageController _pageController = PageController();
  int currentWeekIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCurrentWeek();
    _loadSchedulesForCurrentWeek();
  }

  void _initializeCurrentWeek() {
    final now = DateTime.now();
    // Tìm thứ 2 của tuần hiện tại
    final daysFromMonday = now.weekday - 1;
    currentWeekStart = now.subtract(Duration(days: daysFromMonday));
    // Reset time to start of day
    currentWeekStart = DateTime(
      currentWeekStart.year,
      currentWeekStart.month,
      currentWeekStart.day,
    );
  }

  void _loadSchedulesForCurrentWeek() {
    final weekStart = currentWeekStart.add(Duration(days: currentWeekIndex * 7));
    currentWeekSchedules = MyScheduleModel.getSchedulesForWeek(weekStart);
    setState(() {});
  }

  void _navigateToWeek(int direction) {
    setState(() {
      currentWeekIndex += direction;
    });
    _loadSchedulesForCurrentWeek();
    
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        currentWeekIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _getWeekTitle() {
    final weekStart = currentWeekStart.add(Duration(days: currentWeekIndex * 7));
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    if (currentWeekIndex == 0) {
      return 'Tuần này';
    } else if (currentWeekIndex == 1) {
      return 'Tuần sau';
    } else if (currentWeekIndex == -1) {
      return 'Tuần trước';
    } else {
      return '${DateFormat('dd/MM').format(weekStart)} - ${DateFormat('dd/MM').format(weekEnd)}';
    }
  }

  List<DateTime> _getWeekDates() {
    final weekStart = currentWeekStart.add(Duration(days: currentWeekIndex * 7));
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  List<MyScheduleModel> _getSchedulesForDate(DateTime date) {
    return currentWeekSchedules.where((schedule) {
      return schedule.date.year == date.year &&
             schedule.date.month == date.month &&
             schedule.date.day == date.day;
    }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 16.h),
        _buildWeekNavigator(),
        SizedBox(height: 24.h),
        _buildWeeklySchedule(),
        SizedBox(height: 24.h),
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
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home/student');
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Thời khóa biểu của tôi',
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

  Widget _buildWeekNavigator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _navigateToWeek(-1),
            icon: const Icon(Icons.chevron_left_rounded),
            color: AppColors.primaryGreen,
            iconSize: 28.sp,
          ),
          Expanded(
            child: Text(
              _getWeekTitle(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _navigateToWeek(1),
            icon: const Icon(Icons.chevron_right_rounded),
            color: AppColors.primaryGreen,
            iconSize: 28.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySchedule() {
    final weekDates = _getWeekDates();
    final vietnameseDays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
        children: [
          // Header với các ngày trong tuần
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: List.generate(7, (index) {
                final date = weekDates[index];
                final isToday = _isToday(date);
                
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        vietnameseDays[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isToday ? AppColors.primaryGreen : AppColors.textGray,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: isToday ? AppColors.primaryGreen : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: isToday ? AppColors.white : AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          
          // Lịch học trong tuần
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: List.generate(7, (dayIndex) {
                final date = weekDates[dayIndex];
                final daySchedules = _getSchedulesForDate(date);
                
                if (daySchedules.isEmpty) {
                  return const SizedBox.shrink();
                }
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dayIndex > 0) SizedBox(height: 16.h),
                    
                    // Ngày
                    Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${vietnameseDays[dayIndex]}, ${DateFormat('dd/MM/yyyy').format(date)}',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 12.h),
                    
                    // Các buổi học trong ngày
                    ...daySchedules.map((schedule) => 
                      _buildScheduleItem(schedule, dayIndex < daySchedules.length - 1)
                    ),
                  ],
                );
              }),
            ),
          ),
          
          // Thông báo nếu không có lịch học
          if (currentWeekSchedules.isEmpty)
            Container(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 48.sp,
                    color: AppColors.textLightGray,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Không có lịch học trong tuần này',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGray,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Hãy đặt lịch học với gia sư để bắt đầu học tập',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textLightGray,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(MyScheduleModel schedule, bool showDivider) {
    final isOnline = schedule.isOnline;
    final isUpcoming = schedule.isUpcoming;
    
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: showDivider ? 12.h : 0),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isUpcoming ? AppColors.lightGreen : AppColors.bgLight,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isUpcoming ? AppColors.primaryGreen.withOpacity(0.3) : AppColors.borderColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar gia sư
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryGreen,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        schedule.tutorAvatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 20.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 12.w),
                  
                  // Thông tin buổi học
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.subject,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          schedule.tutorName,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Loại học và thời gian
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isOnline ? AppColors.primaryGreen : AppColors.warningOrange,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          isOnline ? 'Online' : 'Offline',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        schedule.timeRange,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Notes nếu có
              if (schedule.notes != null && schedule.notes!.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  schedule.notes!,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
              ],
              
              // Địa chỉ hoặc link meeting
              if (!isOnline && schedule.address != null) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: AppColors.textGray,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        schedule.address!,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              
              // Nút hành động cho lịch sắp tới
              if (isUpcoming && isOnline) ...[
                SizedBox(height: 12.h),
                _buildJoinClassButton(schedule),
              ],
            ],
          ),
        ),
        
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.dividerColor,
            indent: 52.w,
          ),
      ],
    );
  }

  Widget _buildJoinClassButton(MyScheduleModel schedule) {
    final now = DateTime.now();
    final classDateTime = DateTime(
      schedule.date.year,
      schedule.date.month,
      schedule.date.day,
      int.parse(schedule.startTime.split(':')[0]),
      int.parse(schedule.startTime.split(':')[1]),
    );
    
    // Cho phép vào lớp 15 phút trước giờ học
    final canJoin = now.isAfter(classDateTime.subtract(const Duration(minutes: 15)));
    
    return GestureDetector(
      onTap: canJoin ? () => _showJoinClassDialog(schedule) : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: canJoin ? AppColors.primaryGreen : AppColors.disabledGray,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            canJoin ? 'Vào buổi học' : 'Chưa đến giờ học',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showJoinClassDialog(MyScheduleModel schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Tham gia buổi học',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bgLight,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Môn: ${schedule.subject}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bgLight,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Gia sư: ${schedule.tutorName}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bgLight,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Thời gian: ${schedule.timeRange}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bgLight,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Bạn có muốn tham gia buổi học trực tuyến không?',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bgLight,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Hủy',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _joinClass(schedule);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Tham gia',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _joinClass(MyScheduleModel schedule) {
    // TODO: Điều hướng tới màn call video nội bộ trong app
    // Tạm thời hiển thị thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang tham gia buổi học ${schedule.subject} với ${schedule.tutorName}'),
        backgroundColor: AppColors.primaryGreen,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Sau này sẽ thay thế bằng:
    // context.push('/video-call', extra: schedule);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
}