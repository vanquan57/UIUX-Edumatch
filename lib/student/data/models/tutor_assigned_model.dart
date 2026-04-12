class TutorAssignedModel {
  final String id;
  final String tutorId;
  final String tutorName;
  final String tutorAvatar;
  final String subject;
  final String learningType; // 'online' hoặc 'offline'
  final String learningLocation;
  final double totalAmount;
  final DateTime bookingDate;
  final String status; // 'completed', 'ongoing', 'cancelled'
  final int totalSessions;
  final int completedSessions;
  final double tutorRating; // Rating của gia sư
  final String? note;
  
  // Thông tin chi tiết cho màn detail
  final String? scheduleType; // 'daily' hoặc 'monthly'
  final List<DateTime>? selectedDates; // Cho daily
  final List<int>? selectedWeekdays; // Cho monthly (0=Thứ 2, 6=Chủ nhật)
  final DateTime? monthlyStartDate;
  final String? selectedTimeSlot;
  final int? sessionDuration; // phút
  final String? sessionType; // Loại buổi học
  final String? level; // Trình độ
  final bool? hasHomework;
  final bool? teachInEnglish;
  final List<String>? uploadedFiles;
  final String? address; // Địa chỉ chi tiết cho offline
  final double? latitude;
  final double? longitude;
  final double? pricePerSession;

  TutorAssignedModel({
    required this.id,
    required this.tutorId,
    required this.tutorName,
    required this.tutorAvatar,
    required this.subject,
    required this.learningType,
    required this.learningLocation,
    required this.totalAmount,
    required this.bookingDate,
    required this.status,
    required this.totalSessions,
    required this.completedSessions,
    required this.tutorRating,
    this.note,
    this.scheduleType,
    this.selectedDates,
    this.selectedWeekdays,
    this.monthlyStartDate,
    this.selectedTimeSlot,
    this.sessionDuration,
    this.sessionType,
    this.level,
    this.hasHomework,
    this.teachInEnglish,
    this.uploadedFiles,
    this.address,
    this.latitude,
    this.longitude,
    this.pricePerSession,
  });

  TutorAssignedModel copyWith({
    String? id,
    String? tutorId,
    String? tutorName,
    String? tutorAvatar,
    String? subject,
    String? learningType,
    String? learningLocation,
    double? totalAmount,
    DateTime? bookingDate,
    String? status,
    int? totalSessions,
    int? completedSessions,
    double? tutorRating,
    String? note,
    String? scheduleType,
    List<DateTime>? selectedDates,
    List<int>? selectedWeekdays,
    DateTime? monthlyStartDate,
    String? selectedTimeSlot,
    int? sessionDuration,
    String? sessionType,
    String? level,
    bool? hasHomework,
    bool? teachInEnglish,
    List<String>? uploadedFiles,
    String? address,
    double? latitude,
    double? longitude,
    double? pricePerSession,
  }) {
    return TutorAssignedModel(
      id: id ?? this.id,
      tutorId: tutorId ?? this.tutorId,
      tutorName: tutorName ?? this.tutorName,
      tutorAvatar: tutorAvatar ?? this.tutorAvatar,
      subject: subject ?? this.subject,
      learningType: learningType ?? this.learningType,
      learningLocation: learningLocation ?? this.learningLocation,
      totalAmount: totalAmount ?? this.totalAmount,
      bookingDate: bookingDate ?? this.bookingDate,
      status: status ?? this.status,
      totalSessions: totalSessions ?? this.totalSessions,
      completedSessions: completedSessions ?? this.completedSessions,
      tutorRating: tutorRating ?? this.tutorRating,
      note: note ?? this.note,
      scheduleType: scheduleType ?? this.scheduleType,
      selectedDates: selectedDates ?? this.selectedDates,
      selectedWeekdays: selectedWeekdays ?? this.selectedWeekdays,
      monthlyStartDate: monthlyStartDate ?? this.monthlyStartDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      sessionType: sessionType ?? this.sessionType,
      level: level ?? this.level,
      hasHomework: hasHomework ?? this.hasHomework,
      teachInEnglish: teachInEnglish ?? this.teachInEnglish,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pricePerSession: pricePerSession ?? this.pricePerSession,
    );
  }

  // Tính phần trăm hoàn thành
  double get completionPercentage {
    if (totalSessions == 0) return 0.0;
    return (completedSessions / totalSessions) * 100;
  }

  // Trạng thái hiển thị
  String get statusText {
    switch (status) {
      case 'completed':
        return 'Hoàn thành';
      case 'ongoing':
        return 'Đang học';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  // Màu sắc theo trạng thái
  String get statusColor {
    switch (status) {
      case 'completed':
        return 'success';
      case 'ongoing':
        return 'primary';
      case 'cancelled':
        return 'error';
      default:
        return 'gray';
    }
  }

  // Fake data cho demo
  static List<TutorAssignedModel> getFakeData() {
    return [
      TutorAssignedModel(
        id: '1',
        tutorId: 'tutor_001',
        tutorName: 'Nguyễn Văn An',
        tutorAvatar: 'assets/images/tutor1.png',
        subject: 'Toán học',
        learningType: 'online',
        learningLocation: 'Học trực tuyến',
        totalAmount: 1500000,
        bookingDate: DateTime.now().subtract(const Duration(days: 30)),
        status: 'completed',
        totalSessions: 20,
        completedSessions: 20,
        tutorRating: 4.8,
        note: 'Gia sư dạy rất tốt, con em tiến bộ nhiều',
        scheduleType: 'monthly',
        selectedWeekdays: [0, 2, 4], // Thứ 2, 4, 6
        monthlyStartDate: DateTime.now().subtract(const Duration(days: 30)),
        selectedTimeSlot: '19:00 - 21:00',
        sessionDuration: 120,
        sessionType: 'Ôn tập và làm bài tập',
        level: 'Lớp 12',
        hasHomework: true,
        teachInEnglish: false,
        pricePerSession: 250000,
      ),
      TutorAssignedModel(
        id: '2',
        tutorId: 'tutor_002',
        tutorName: 'Trần Thị Bình',
        tutorAvatar: 'assets/images/tutor2.png',
        subject: 'Tiếng Anh',
        learningType: 'offline',
        learningLocation: 'Quận 1, TP.HCM',
        totalAmount: 2400000,
        bookingDate: DateTime.now().subtract(const Duration(days: 15)),
        status: 'ongoing',
        totalSessions: 24,
        completedSessions: 16,
        tutorRating: 4.9,
        scheduleType: 'monthly',
        selectedWeekdays: [1, 3, 5], // Thứ 3, 5, 7
        monthlyStartDate: DateTime.now().subtract(const Duration(days: 15)),
        selectedTimeSlot: '18:30 - 20:30',
        sessionDuration: 120,
        sessionType: 'Luyện speaking và grammar',
        level: 'Trung cấp',
        hasHomework: true,
        teachInEnglish: true,
        address: '123 Nguyễn Trãi, Quận 1, TP.HCM',
        pricePerSession: 300000,
      ),
      TutorAssignedModel(
        id: '3',
        tutorId: 'tutor_003',
        tutorName: 'Lê Minh Cường',
        tutorAvatar: 'assets/images/tutor3.png',
        subject: 'Vật lý',
        learningType: 'online',
        learningLocation: 'Học trực tuyến',
        totalAmount: 1800000,
        bookingDate: DateTime.now().subtract(const Duration(days: 60)),
        status: 'completed',
        totalSessions: 18,
        completedSessions: 18,
        tutorRating: 4.6,
        scheduleType: 'daily',
        selectedDates: [
          DateTime.now().subtract(const Duration(days: 60)),
          DateTime.now().subtract(const Duration(days: 58)),
          DateTime.now().subtract(const Duration(days: 56)),
        ],
        selectedTimeSlot: '20:00 - 22:00',
        sessionDuration: 120,
        sessionType: 'Giải bài tập và lý thuyết',
        level: 'Lớp 11',
        hasHomework: false,
        teachInEnglish: false,
        pricePerSession: 280000,
      ),
      TutorAssignedModel(
        id: '4',
        tutorId: 'tutor_004',
        tutorName: 'Phạm Thu Hương',
        tutorAvatar: 'assets/images/tutor4.png',
        subject: 'Hóa học',
        learningType: 'offline',
        learningLocation: 'Quận 3, TP.HCM',
        totalAmount: 2100000,
        bookingDate: DateTime.now().subtract(const Duration(days: 45)),
        status: 'cancelled',
        totalSessions: 21,
        completedSessions: 8,
        tutorRating: 4.2,
        note: 'Hủy do lịch học không phù hợp',
        scheduleType: 'monthly',
        selectedWeekdays: [0, 2], // Thứ 2, 4
        monthlyStartDate: DateTime.now().subtract(const Duration(days: 45)),
        selectedTimeSlot: '19:30 - 21:30',
        sessionDuration: 120,
        sessionType: 'Thí nghiệm và lý thuyết',
        level: 'Lớp 10',
        hasHomework: true,
        teachInEnglish: false,
        address: '456 Lê Lợi, Quận 3, TP.HCM',
        pricePerSession: 270000,
      ),
      TutorAssignedModel(
        id: '5',
        tutorId: 'tutor_005',
        tutorName: 'Hoàng Đức Minh',
        tutorAvatar: 'assets/images/tutor5.png',
        subject: 'Sinh học',
        learningType: 'online',
        learningLocation: 'Học trực tuyến',
        totalAmount: 1650000,
        bookingDate: DateTime.now().subtract(const Duration(days: 10)),
        status: 'ongoing',
        totalSessions: 15,
        completedSessions: 5,
        tutorRating: 4.7,
        scheduleType: 'monthly',
        selectedWeekdays: [1, 4], // Thứ 3, 6
        monthlyStartDate: DateTime.now().subtract(const Duration(days: 10)),
        selectedTimeSlot: '17:00 - 19:00',
        sessionDuration: 120,
        sessionType: 'Ôn thi đại học',
        level: 'Lớp 12',
        hasHomework: true,
        teachInEnglish: false,
        pricePerSession: 260000,
      ),
    ];
  }
}