class MyScheduleModel {
  final String id;
  final String tutorId;
  final String tutorName;
  final String tutorAvatar;
  final String subject;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String type; // 'online' or 'offline'
  final String status; // 'upcoming', 'completed', 'cancelled'
  final String? address;
  final String? notes;

  const MyScheduleModel({
    required this.id,
    required this.tutorId,
    required this.tutorName,
    required this.tutorAvatar,
    required this.subject,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.status,
    this.address,
    this.notes,
  });

  String get timeRange => '$startTime - $endTime';

  bool get isOnline => type == 'online';
  bool get isUpcoming => status == 'upcoming';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  MyScheduleModel copyWith({
    String? id,
    String? tutorId,
    String? tutorName,
    String? tutorAvatar,
    String? subject,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? type,
    String? status,
    String? address,
    String? notes,
  }) {
    return MyScheduleModel(
      id: id ?? this.id,
      tutorId: tutorId ?? this.tutorId,
      tutorName: tutorName ?? this.tutorName,
      tutorAvatar: tutorAvatar ?? this.tutorAvatar,
      subject: subject ?? this.subject,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      status: status ?? this.status,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }

  // Mock data for demo
  static List<MyScheduleModel> getMockSchedules() {
    final now = DateTime.now();
    final nowPlus15Min = now.add(const Duration(minutes: 15));
    
    return [
      // Current time + 15 minutes - for testing join class feature
      MyScheduleModel(
        id: '0',
        tutorId: 'tutor_current',
        tutorName: 'Cô Phạm Thị Linh',
        tutorAvatar: 'assets/images/tutor1.png',
        subject: 'Tiếng Anh',
        date: now,
        startTime: '${nowPlus15Min.hour.toString().padLeft(2, '0')}:${nowPlus15Min.minute.toString().padLeft(2, '0')}',
        endTime: '${(nowPlus15Min.hour + 1).toString().padLeft(2, '0')}:${(nowPlus15Min.minute + 30).toString().padLeft(2, '0')}',
        type: 'online',
        status: 'upcoming',
        notes: 'Luyện thi IELTS Speaking - Buổi học sắp bắt đầu',
      ),
      
      // This week schedules
      MyScheduleModel(
        id: '1',
        tutorId: 'tutor1',
        tutorName: 'Cô Nguyễn Thị Hoa',
        tutorAvatar: 'assets/images/tutor1.png',
        subject: 'Toán học',
        date: now.add(const Duration(days: 1)),
        startTime: '08:00',
        endTime: '09:30',
        type: 'online',
        status: 'upcoming',
        notes: 'Ôn tập chương hàm số',
      ),
      MyScheduleModel(
        id: '2',
        tutorId: 'tutor2',
        tutorName: 'Thầy Trần Văn Nam',
        tutorAvatar: 'assets/images/tutor2.png',
        subject: 'Vật lý',
        date: now.add(const Duration(days: 2)),
        startTime: '14:00',
        endTime: '15:30',
        type: 'offline',
        status: 'upcoming',
        address: '123 Đường ABC, Quận 1, TP.HCM',
        notes: 'Học chương điện học',
      ),
      MyScheduleModel(
        id: '3',
        tutorId: 'tutor3',
        tutorName: 'Cô Lê Thị Mai',
        tutorAvatar: 'assets/images/tutor3.png',
        subject: 'Tiếng Anh',
        date: now.add(const Duration(days: 3)),
        startTime: '16:00',
        endTime: '17:30',
        type: 'online',
        status: 'upcoming',
        notes: 'Luyện thi IELTS Speaking',
      ),
      MyScheduleModel(
        id: '4',
        tutorId: 'tutor1',
        tutorName: 'Cô Nguyễn Thị Hoa',
        tutorAvatar: 'assets/images/tutor1.png',
        subject: 'Toán học',
        date: now.add(const Duration(days: 4)),
        startTime: '10:00',
        endTime: '11:30',
        type: 'online',
        status: 'upcoming',
        notes: 'Giải bài tập về đạo hàm',
      ),
      MyScheduleModel(
        id: '5',
        tutorId: 'tutor4',
        tutorName: 'Thầy Phạm Minh Tuấn',
        tutorAvatar: 'assets/images/tutor4.png',
        subject: 'Hóa học',
        date: now.add(const Duration(days: 5)),
        startTime: '09:00',
        endTime: '10:30',
        type: 'offline',
        status: 'upcoming',
        address: '456 Đường XYZ, Quận 3, TP.HCM',
        notes: 'Thực hành thí nghiệm hóa học',
      ),
      
      // Next week schedules
      MyScheduleModel(
        id: '6',
        tutorId: 'tutor2',
        tutorName: 'Thầy Trần Văn Nam',
        tutorAvatar: 'assets/images/tutor2.png',
        subject: 'Vật lý',
        date: now.add(const Duration(days: 8)),
        startTime: '14:00',
        endTime: '15:30',
        type: 'online',
        status: 'upcoming',
        notes: 'Ôn tập chương quang học',
      ),
      MyScheduleModel(
        id: '7',
        tutorId: 'tutor3',
        tutorName: 'Cô Lê Thị Mai',
        tutorAvatar: 'assets/images/tutor3.png',
        subject: 'Tiếng Anh',
        date: now.add(const Duration(days: 10)),
        startTime: '16:00',
        endTime: '17:30',
        type: 'offline',
        status: 'upcoming',
        address: '789 Đường DEF, Quận 7, TP.HCM',
        notes: 'Luyện thi IELTS Writing',
      ),
      
      // Past schedules (completed)
      MyScheduleModel(
        id: '8',
        tutorId: 'tutor1',
        tutorName: 'Cô Nguyễn Thị Hoa',
        tutorAvatar: 'assets/images/tutor1.png',
        subject: 'Toán học',
        date: now.subtract(const Duration(days: 2)),
        startTime: '08:00',
        endTime: '09:30',
        type: 'online',
        status: 'completed',
        notes: 'Đã hoàn thành bài học về giới hạn',
      ),
      MyScheduleModel(
        id: '9',
        tutorId: 'tutor5',
        tutorName: 'Cô Hoàng Thị Lan',
        tutorAvatar: 'assets/images/tutor5.png',
        subject: 'Văn học',
        date: now.subtract(const Duration(days: 5)),
        startTime: '15:00',
        endTime: '16:30',
        type: 'offline',
        status: 'completed',
        address: '321 Đường GHI, Quận 5, TP.HCM',
        notes: 'Đã học xong bài thơ Tràng Giang',
      ),
    ];
  }

  // Get schedules for a specific week
  static List<MyScheduleModel> getSchedulesForWeek(DateTime weekStart) {
    final allSchedules = getMockSchedules();
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    return allSchedules.where((schedule) {
      return schedule.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
             schedule.date.isBefore(weekEnd.add(const Duration(days: 1)));
    }).toList();
  }

  // Get schedules for a specific date
  static List<MyScheduleModel> getSchedulesForDate(DateTime date) {
    final allSchedules = getMockSchedules();
    
    return allSchedules.where((schedule) {
      return schedule.date.year == date.year &&
             schedule.date.month == date.month &&
             schedule.date.day == date.day;
    }).toList();
  }
}