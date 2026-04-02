import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/booking_model.dart';
import 'package:edu_match/student/data/models/time_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SelectTimeSlotPage extends StatefulWidget {
  final BookingModel booking;

  const SelectTimeSlotPage({super.key, required this.booking});

  @override
  State<SelectTimeSlotPage> createState() => _SelectTimeSlotPageState();
}

class _SelectTimeSlotPageState extends State<SelectTimeSlotPage> {
  late BookingModel booking;
  late List<DayAvailabilityModel> availableSlots;
  late DateTime selectedDate;
  late DayAvailabilityModel currentDaySlots;
  TimeSlotModel? selectedSlot;
  bool isLoading = false;
  bool isLocking = false;
  String? expiredSlotId;

  // For monthly learning - selected weekdays (0=Mon, 6=Sun)
  List<int> selectedWeekdays = [];
  // For monthly learning - start date of the month plan
  DateTime? monthlyStartDate;
  // For daily learning - selected dates
  List<DateTime> selectedDates = [];

  @override
  void initState() {
    super.initState();
    booking = widget.booking;
    availableSlots = DayAvailabilityModel.mockAvailability();
    selectedDate = availableSlots.first.date;
    currentDaySlots = availableSlots.first;
    selectedDates = [selectedDate];
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      final index = selectedDates.indexWhere(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );

      if (index >= 0) {
        // Remove if already selected
        selectedDates.removeAt(index);
      } else {
        // Add if not selected
        selectedDates.add(date);
      }

      // Sort dates
      selectedDates.sort();

      // Update currentDaySlots to first selected date for single slot display
      if (selectedDates.isNotEmpty) {
        selectedDate = selectedDates.first;
        _updateCurrentDaySlots(selectedDate);
      }

      selectedSlot = null; // Reset selected slot when changing dates
    });
  }

  void _updateCurrentDaySlots(DateTime date) {
    try {
      currentDaySlots = availableSlots.firstWhere(
        (slot) =>
            slot.date.year == date.year &&
            slot.date.month == date.month &&
            slot.date.day == date.day,
      );
    } catch (e) {
      // If date not found in availableSlots, create a mock one
      currentDaySlots = DayAvailabilityModel(
        date: date,
        slots: _generateMockSlotsForDate(date),
      );
    }
  }

  void _onWeekdayToggled(int weekday) {
    setState(() {
      if (selectedWeekdays.contains(weekday)) {
        selectedWeekdays.remove(weekday);
      } else {
        selectedWeekdays.add(weekday);
        selectedWeekdays.sort();
      }
      selectedSlot = null; // Reset selected slot when changing weekdays
    });
  }

  List<TimeSlotModel> _generateMockSlotsForDate(DateTime date) {
    // Generate default time slots for any date
    final slots = [
      TimeSlotModel(
        id: '1',
        startTime: '08:00',
        endTime: '09:30',
        isAvailable: true,
        isBooked: false,
      ),
      TimeSlotModel(
        id: '2',
        startTime: '10:00',
        endTime: '11:30',
        isAvailable: true,
        isBooked: false,
      ),
      TimeSlotModel(
        id: '3',
        startTime: '13:00',
        endTime: '14:30',
        isAvailable: true,
        isBooked: false,
      ),
      TimeSlotModel(
        id: '4',
        startTime: '15:00',
        endTime: '16:30',
        isAvailable: true,
        isBooked: false,
      ),
    ];
    return slots;
  }

  void _onSlotSelected(TimeSlotModel slot) {
    if (!slot.isAvailable || slot.isBooked) return;

    setState(() {
      selectedSlot = slot;
      booking = booking.copyWith(
        selectedTimeSlot: slot.label,
        selectedDate: selectedDates.isNotEmpty ? selectedDates.first : selectedDate,
      );
    });
  }

  Future<void> _onContinuePressed() async {
    if (selectedSlot == null) return;

    setState(() => isLocking = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        final isMonthly = booking.scheduleType == 'monthly';
        final updatedBooking = booking.copyWith(
          selectedDate: isMonthly
              ? monthlyStartDate
              : (selectedDates.isNotEmpty ? selectedDates.first : null),
          selectedDates: isMonthly ? [] : selectedDates,
          selectedWeekdays: isMonthly ? selectedWeekdays : [],
          monthlyStartDate: isMonthly ? monthlyStartDate : null,
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.pushNamed('bookingRequestRequirement', extra: updatedBooking);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLocking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          SizedBox(height: 24.h),

          // Tutor Info Card
          _buildTutorInfoCard(),
          SizedBox(height: 24.h),

          // Date Selector
          _buildDateSelector(),
          SizedBox(height: 24.h),

          // Available Slots Title
          Text(
            'Chọn thời gian học',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 12.h),

          // Time Slot Grid
          if (isLoading)
            SizedBox(
              height: 200.h,
              child: const Center(child: CircularProgressIndicator()),
            )
          else
            _buildTimeSlotGrid(),

          SizedBox(height: 24.h),

          // Continue Button (will be scrollable with content)
          _buildStickyButton(),

          SizedBox(height: 16.h), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 24.sp,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Chọn thời gian',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorInfoCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryGreen,
            ),
            child: ClipOval(
              child: Image.asset(
                booking.tutorAvatar ?? 'assets/images/default_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 28.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.tutorName ?? 'Gia sư',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.type == 'online'
                      ? 'Học trực tuyến'
                      : 'Học trực tiếp',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    final isMonthly = booking.scheduleType == 'monthly';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loại học',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: _buildTypeButton('Học theo ngày', false)),
            SizedBox(width: 12.w),
            Expanded(child: _buildTypeButton('Học theo tháng', true)),
          ],
        ),
        SizedBox(height: 24.h),

        // Show different UI based on type
        if (isMonthly) _buildWeekdaySelector() else _buildDailyDateSelector(),
      ],
    );
  }

  Widget _buildDailyDateSelector() {
    final selectedDateFormatted = selectedDates.isEmpty
        ? 'Chưa chọn'
        : selectedDates.length == 1
        ? DateFormat('dd/MM/yyyy').format(selectedDates.first)
        : '${selectedDates.length} ngày được chọn';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chọn ngày học (có thể chọn nhiều ngày)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),

        // Date Picker Button
        GestureDetector(
          onTap: _showDatePicker,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.primaryGreen,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    selectedDateFormatted,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.textGray,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),

        // Selected dates chips
        if (selectedDates.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: selectedDates.map((date) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('dd/MM').format(date),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () => _onDateSelected(date),
                          child: Icon(
                            Icons.close,
                            color: AppColors.white,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildWeekdaySelector() {
    final weekdays = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật',
    ];

    final startDateText = monthlyStartDate != null
        ? DateFormat('dd/MM/yyyy').format(monthlyStartDate!)
        : 'Chọn ngày bắt đầu';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 8-session info note
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.primaryGreen.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.primaryGreen,
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Mỗi tháng học 8 buổi. Hệ thống sẽ tự động đánh dấu hoàn thành khi bạn học đủ 8 buổi trong tháng.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Weekday selector
        Text(
          'Chọn các thứ học trong tuần (có thể chọn nhiều)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(7, (index) {
            final isSelected = selectedWeekdays.contains(index);
            return GestureDetector(
              onTap: () => _onWeekdayToggled(index),
              child: Container(
                width: 60.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryGreen : AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    weekdays[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.white : AppColors.textDark,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20.h),

        // Start date picker
        Text(
          'Ngày bắt đầu *',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Không thể chọn ngày trước ngày hôm nay',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _showMonthlyStartDatePicker,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: monthlyStartDate != null
                    ? AppColors.primaryGreen
                    : AppColors.borderColor,
                width: monthlyStartDate != null ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: monthlyStartDate != null
                      ? AppColors.primaryGreen
                      : AppColors.textGray,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    startDateText,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: monthlyStartDate != null
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: monthlyStartDate != null
                          ? AppColors.textDark
                          : AppColors.textLightGray,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.textGray,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeButton(String label, bool isMonthly) {
    final isSelected =
        (isMonthly && booking.scheduleType == 'monthly') ||
        (!isMonthly && booking.scheduleType != 'monthly');

    return GestureDetector(
      onTap: () {
        setState(() {
          booking = booking.copyWith(scheduleType: isMonthly ? 'monthly' : 'daily');
          selectedSlot = null;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final initialDate = selectedDate.isBefore(now) ? now : selectedDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _onDateSelected(picked);
    }
  }

  Future<void> _showMonthlyStartDatePicker() async {
    final now = DateTime.now();
    final initialDate = monthlyStartDate != null && !monthlyStartDate!.isBefore(now)
        ? monthlyStartDate!
        : now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Chọn ngày bắt đầu tháng học',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => monthlyStartDate = picked);
    }
  }

  Widget _buildTimeSlotGrid() {
    final slots = currentDaySlots.slots;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = selectedSlot?.id == slot.id;

        return _buildTimeSlotItem(slot, isSelected);
      },
    );
  }

  Widget _buildTimeSlotItem(TimeSlotModel slot, bool isSelected) {
    final isDisabled = slot.isBooked || !slot.isAvailable;

    return GestureDetector(
      onTap: isDisabled ? null : () => _onSlotSelected(slot),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen
              : isDisabled
              ? AppColors.disabledGray
              : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : isDisabled
                ? AppColors.borderColor
                : AppColors.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Time slot label
            Text(
              slot.label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textDark,
              ),
            ),
            SizedBox(height: 8.h),

            // Status badge
            if (isDisabled)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: slot.isBooked
                      ? AppColors.errorRed
                      : AppColors.warningOrange,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  slot.isBooked ? 'Đã đặt' : 'Không khả dụng',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              )
            else if (isSelected)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Đã chọn',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Sẵn sàng',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyButton() {
    final isDisabled =
        selectedSlot == null ||
        isLocking ||
        (booking.scheduleType == 'monthly' && selectedWeekdays.isEmpty) ||
        (booking.scheduleType == 'monthly' && monthlyStartDate == null) ||
        (booking.scheduleType != 'monthly' && selectedDates.isEmpty);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: isDisabled ? null : _onContinuePressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isDisabled ? AppColors.disabledGray : AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: isLocking
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Tiếp tục',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDisabled ? AppColors.textGray : AppColors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
