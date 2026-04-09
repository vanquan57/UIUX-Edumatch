class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String classTime;
  final String createdAt;
  final bool isUnread;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.classTime,
    required this.createdAt,
    this.isUnread = false,
  });

  static List<NotificationModel> mockOnlineClassNotifications() {
    return const [
      NotificationModel(
        id: 'noti-1',
        title: 'Nhắc buổi học sau 15 phút',
        message: 'Buổi Toán 12 với thầy Nguyễn Văn A sắp bắt đầu.',
        classTime: '19:30 - 20:30, 09/04/2026',
        createdAt: '5 phút trước',
        isUnread: true,
      ),
      NotificationModel(
        id: 'noti-2',
        title: 'Lịch học đã được cập nhật',
        message: 'Buổi Tiếng Anh giao tiếp được dời sang 20:00.',
        classTime: '20:00 - 21:00, 10/04/2026',
        createdAt: '30 phút trước',
        isUnread: true,
      ),
      NotificationModel(
        id: 'noti-3',
        title: 'Link lớp học đã sẵn sàng',
        message: 'Bạn có thể vào phòng học online trước 10 phút.',
        classTime: '18:00 - 19:00, 11/04/2026',
        createdAt: '1 giờ trước',
        isUnread: true,
      ),
      NotificationModel(
        id: 'noti-4',
        title: 'Tài liệu buổi học mới',
        message: 'Gia sư đã gửi tài liệu ôn tập cho buổi học tiếp theo.',
        classTime: '08:00 - 09:00, 12/04/2026',
        createdAt: 'Hôm qua',
      ),
      NotificationModel(
        id: 'noti-5',
        title: 'Buổi học đã hoàn thành',
        message: 'Bạn vừa hoàn thành buổi Vật Lý. Hãy để lại đánh giá.',
        classTime: '17:30 - 18:30, 08/04/2026',
        createdAt: '2 ngày trước',
      ),
    ];
  }
}
