enum SentimentLabel {
  positive,
  negative,
  neutral,
}

class CourseFeedbackModel {
  final String id;
  final String courseId;
  final String studentName;
  final String studentAvatar;
  final int rating;
  final String comment;
  final String date;
  final SentimentLabel sentiment;

  CourseFeedbackModel({
    required this.id,
    required this.courseId,
    required this.studentName,
    required this.studentAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.sentiment,
  });

  // Mock data for testing
  static List<CourseFeedbackModel> mockFeedbacksByCourseId(String courseId) {
    final allFeedback = [
      // Course 1 (AWS) feedback
      CourseFeedbackModel(
        id: 'cfb1',
        courseId: '1',
        studentName: 'Nguyễn Minh Tuấn',
        studentAvatar: 'assets/images/student1.png',
        rating: 5,
        comment: 'Khóa học rất chi tiết và dễ hiểu. Giảng viên có kinh nghiệm thực tế, các lab hands-on rất hữu ích. Tôi đã hiểu rõ về AWS sau khóa học này.',
        date: '2 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      CourseFeedbackModel(
        id: 'cfb2',
        courseId: '1',
        studentName: 'Trần Thị Lan',
        studentAvatar: 'assets/images/student2.png',
        rating: 5,
        comment: 'Khóa học tuyệt vời! Nội dung cập nhật, giảng viên nhiệt tình. Final assignment giúp tôi áp dụng kiến thức vào thực tế.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.positive,
      ),
      CourseFeedbackModel(
        id: 'cfb3',
        courseId: '1',
        studentName: 'Lê Văn Hùng',
        studentAvatar: 'assets/images/student3.png',
        rating: 4,
        comment: 'Nội dung hay, nhưng một số phần hơi nhanh. Mong có thêm thời gian thực hành.',
        date: '3 tuần trước',
        sentiment: SentimentLabel.neutral,
      ),
      CourseFeedbackModel(
        id: 'cfb4',
        courseId: '1',
        studentName: 'Phạm Thị Mai',
        studentAvatar: 'assets/images/student4.png',
        rating: 5,
        comment: 'Giảng viên rất chuyên nghiệp, có chứng chỉ AWS cao cấp. Khóa học giúp tôi chuẩn bị tốt cho kỳ thi SAA.',
        date: '1 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      CourseFeedbackModel(
        id: 'cfb5',
        courseId: '1',
        studentName: 'Hoàng Văn Nam',
        studentAvatar: 'assets/images/student5.png',
        rating: 4,
        comment: 'Khóa học chất lượng, slide đẹp, code mẫu đầy đủ. Tuy nhiên giá hơi cao so với thị trường.',
        date: '2 tháng trước',
        sentiment: SentimentLabel.neutral,
      ),
      CourseFeedbackModel(
        id: 'cfb6',
        courseId: '1',
        studentName: 'Vũ Thị Hoa',
        studentAvatar: 'assets/images/student6.png',
        rating: 5,
        comment: 'Tôi là người mới bắt đầu với cloud computing, nhưng sau khóa học này tôi đã tự tin triển khai ứng dụng lên AWS.',
        date: '3 ngày trước',
        sentiment: SentimentLabel.positive,
      ),
      CourseFeedbackModel(
        id: 'cfb7',
        courseId: '1',
        studentName: 'Đặng Minh Quân',
        studentAvatar: 'assets/images/student7.png',
        rating: 3,
        comment: 'Nội dung ổn nhưng video hơi dài, mong có tóm tắt ngắn gọn hơn.',
        date: '1 tháng trước',
        sentiment: SentimentLabel.negative,
      ),
      CourseFeedbackModel(
        id: 'cfb8',
        courseId: '1',
        studentName: 'Bùi Thị Linh',
        studentAvatar: 'assets/images/student8.png',
        rating: 5,
        comment: 'Khóa học đáng đồng tiền bát gạo! Giảng viên có kinh nghiệm thực tế, các case study rất thực tế.',
        date: '5 ngày trước',
        sentiment: SentimentLabel.positive,
      ),
      
      // Course 5 (Power BI) feedback
      CourseFeedbackModel(
        id: 'cfb9',
        courseId: '5',
        studentName: 'Nguyễn Thị Hương',
        studentAvatar: 'assets/images/student1.png',
        rating: 5,
        comment: 'Khóa học Power BI rất chi tiết, từ cơ bản đến nâng cao. Giảng viên giải thích rất rõ ràng.',
        date: '1 tuần trước',
        sentiment: SentimentLabel.positive,
      ),
      CourseFeedbackModel(
        id: 'cfb10',
        courseId: '5',
        studentName: 'Trần Văn Đức',
        studentAvatar: 'assets/images/student2.png',
        rating: 4,
        comment: 'Nội dung hay, nhiều ví dụ thực tế. Tuy nhiên cần cập nhật thêm tính năng mới của Power BI.',
        date: '2 tuần trước',
        sentiment: SentimentLabel.neutral,
      ),
    ];

    return allFeedback.where((feedback) => feedback.courseId == courseId).toList();
  }

  // Calculate average rating for a list of feedbacks
  static double calculateAverageRating(List<CourseFeedbackModel> feedbacks) {
    if (feedbacks.isEmpty) return 0.0;
    final totalRating = feedbacks.fold(0, (sum, feedback) => sum + feedback.rating);
    return totalRating / feedbacks.length;
  }

  // Get rating distribution (1-5 stars)
  static Map<int, int> getRatingDistribution(List<CourseFeedbackModel> feedbacks) {
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final feedback in feedbacks) {
      distribution[feedback.rating] = (distribution[feedback.rating] ?? 0) + 1;
    }
    return distribution;
  }
}