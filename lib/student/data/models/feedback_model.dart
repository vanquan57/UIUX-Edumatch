enum SentimentLabel {
  positive,
  negative,
  neutral,
}

class FeedbackModel {
  final String id;
  final String tutorId;
  final String studentName;
  final String studentAvatar;
  final int rating;
  final String comment;
  final String date;
  final SentimentLabel sentiment;

  FeedbackModel({
    required this.id,
    required this.tutorId,
    required this.studentName,
    required this.studentAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.sentiment,
  });

  // Mock data for testing
  static List<FeedbackModel> mockFeedbacksByTutorId(String tutorId) {
    final allFeedback = [
      // Tutor 1 feedback
      FeedbackModel(
        id: 'fb1',
        tutorId: '1',
        studentName: 'Nguyễn Văn A',
        studentAvatar: 'assets/images/student1.png',
        rating: 5,
        comment: 'Thầy dạy rất tốt, tôi hiểu bài ngay. Cách giải thích rất rõ ràng.',
        date: '2 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      FeedbackModel(
        id: 'fb2',
        tutorId: '1',
        studentName: 'Trần Thị B',
        studentAvatar: 'assets/images/student2.png',
        rating: 4,
        comment: 'Nội dung hay nhưng muốn có thêm bài tập luyện tập.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.neutral,
      ),
      FeedbackModel(
        id: 'fb3',
        tutorId: '1',
        studentName: 'Lê Văn C',
        studentAvatar: 'assets/images/student3.png',
        rating: 5,
        comment: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh sau 2 tháng học.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.positive,
      ),
      FeedbackModel(
        id: 'fb4',
        tutorId: '1',
        studentName: 'Phạm Minh D',
        studentAvatar: 'assets/images/student4.png',
        rating: 5,
        comment: 'Rất hài lòng với khóa học. Thầy rất nhiệt tình và chu đáo.',
        date: '3 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      FeedbackModel(
        id: 'fb5',
        tutorId: '1',
        studentName: 'Hoàng Thu E',
        studentAvatar: 'assets/images/student5.png',
        rating: 4,
        comment: 'Tốt, nhưng tôi mong muốn có lịch linh hoạt hơn.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.neutral,
      ),
      FeedbackModel(
        id: 'fb6',
        tutorId: '1',
        studentName: 'Đặng Hữu F',
        studentAvatar: 'assets/images/student1.png',
        rating: 5,
        comment: 'Excellent tutor! Đã giúp tôi đặc biệt nhiều trong học tập.',
        date: '2 tháng trước',
        sentiment: SentimentLabel.positive,
      ),
      FeedbackModel(
        id: 'fb7',
        tutorId: '1',
        studentName: 'Các Ngọc G',
        studentAvatar: 'assets/images/student2.png',
        rating: 3,
        comment: 'Bình thường, có thể cải thiện thêm về phương pháp dạy.',
        date: '2 tháng trước',
        sentiment: SentimentLabel.neutral,
      ),
      FeedbackModel(
        id: 'fb8',
        tutorId: '1',
        studentName: 'Trần Hà H',
        studentAvatar: 'assets/images/student3.png',
        rating: 5,
        comment: 'Thầy rất giỏi và dạy dễ hiểu. Tôi sẽ giới thiệu cho bạn bè.',
        date: '2 tháng trước',
        sentiment: SentimentLabel.positive,
      ),
      // Tutor 2 feedback
      FeedbackModel(
        id: 'fb9',
        tutorId: '2',
        studentName: 'Nguyễn Văn A',
        studentAvatar: 'assets/images/student1.png',
        rating: 5,
        comment: 'Cô dạy Tiếng Anh rất hay, giúp tôi cải thiện kỹ năng nói.',
        date: '1 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      FeedbackModel(
        id: 'fb10',
        tutorId: '2',
        studentName: 'Trần Thị B',
        studentAvatar: 'assets/images/student2.png',
        rating: 5,
        comment: 'Tuyệt vời! Tôi đã đạt 7.0 IELTS sau khóa học.',
        date: '2 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      // Tutor 3 feedback
      FeedbackModel(
        id: 'fb11',
        tutorId: '3',
        studentName: 'Lê Văn C',
        studentAvatar: 'assets/images/student3.png',
        rating: 4,
        comment: 'Thầy dạy Hóa tốt nhưng muốn trực tiếp online.',
        date: '2 tuần trước',
        sentiment: SentimentLabel.neutral,
      ),
      FeedbackModel(
        id: 'fb12',
        tutorId: '3',
        studentName: 'Phạm Minh D',
        studentAvatar: 'assets/images/student4.png',
        rating: 5,
        comment: 'Rất sâu sắc, thầy giải thích chi tiết mọi khái niệm.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.positive,
      ),
    ];

    return allFeedback.where((fb) => fb.tutorId == tutorId).toList();
  }

  // Calculate average rating for a tutor
  static double calculateAverageRating(List<FeedbackModel> feedbacks) {
    if (feedbacks.isEmpty) return 0.0;
    final sum = feedbacks.fold<int>(0, (prev, fb) => prev + fb.rating);
    return sum / feedbacks.length;
  }

  // Count rating distribution
  static Map<int, int> getRatingDistribution(List<FeedbackModel> feedbacks) {
    final distribution = <int, int>{};
    for (int i = 1; i <= 5; i++) {
      distribution[i] = feedbacks.where((fb) => fb.rating == i).length;
    }
    return distribution;
  }
}
