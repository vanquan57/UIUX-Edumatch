class BookingModel {
  final String tutorId;
  final String? tutorName;
  final String? tutorAvatar;

  /// Danh sách môn học của gia sư (để học sinh chọn)
  final List<String>? tutorSubjects;

  /// Hình thức học: 'online' hoặc 'offline'
  final String type;

  final String? address;
  final double? latitude;
  final double? longitude;

  /// Loại lịch học: 'daily' (theo ngày) hoặc 'monthly' (theo tháng)
  final String? scheduleType;

  /// Ngày tham chiếu (ngày đầu tiên được chọn)
  final DateTime? selectedDate;

  /// Danh sách các ngày học (dùng khi scheduleType == 'daily')
  final List<DateTime>? selectedDates;

  /// Danh sách các thứ trong tuần (0=Thứ 2 … 6=Chủ nhật)
  /// Dùng khi scheduleType == 'monthly'
  final List<int>? selectedWeekdays;

  /// Ngày bắt đầu tháng học (dùng khi scheduleType == 'monthly')
  final DateTime? monthlyStartDate;

  final String? selectedTimeSlot;

  /// Môn học mà học sinh đã chọn
  final String? subject;

  final int? sessionDuration; // phút
  final Map<String, dynamic>? metadata; // { sessionType, level, note, ... }

  BookingModel({
    required this.tutorId,
    this.tutorName,
    this.tutorAvatar,
    this.tutorSubjects,
    required this.type,
    this.address,
    this.latitude,
    this.longitude,
    this.scheduleType,
    this.selectedDate,
    this.selectedDates,
    this.selectedWeekdays,
    this.monthlyStartDate,
    this.selectedTimeSlot,
    this.subject,
    this.sessionDuration,
    this.metadata,
  });

  BookingModel copyWith({
    String? tutorId,
    String? tutorName,
    String? tutorAvatar,
    List<String>? tutorSubjects,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    String? scheduleType,
    DateTime? selectedDate,
    List<DateTime>? selectedDates,
    List<int>? selectedWeekdays,
    DateTime? monthlyStartDate,
    String? selectedTimeSlot,
    String? subject,
    int? sessionDuration,
    Map<String, dynamic>? metadata,
  }) {
    return BookingModel(
      tutorId: tutorId ?? this.tutorId,
      tutorName: tutorName ?? this.tutorName,
      tutorAvatar: tutorAvatar ?? this.tutorAvatar,
      tutorSubjects: tutorSubjects ?? this.tutorSubjects,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      scheduleType: scheduleType ?? this.scheduleType,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDates: selectedDates ?? this.selectedDates,
      selectedWeekdays: selectedWeekdays ?? this.selectedWeekdays,
      monthlyStartDate: monthlyStartDate ?? this.monthlyStartDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      subject: subject ?? this.subject,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      metadata: metadata ?? this.metadata,
    );
  }
}
