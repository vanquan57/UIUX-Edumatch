class CourseModel {
  final String id;
  final String title;
  final String instructorName;
  final String thumbnail;
  final double rating;
  final int reviewCount;
  final double price;
  final String badge; // "Best Seller", "Hot", or empty

  CourseModel({
    required this.id,
    required this.title,
    required this.instructorName,
    required this.thumbnail,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.badge,
  });

  /// Mock data for featured courses
  static List<CourseModel> mockFeaturedCourses() {
    return [
      CourseModel(
        id: '1',
        title: 'Toán Lớp 12 - Ôn Thi THPT Quốc Gia',
        instructorName: 'Thầy Nguyễn Văn A',
        thumbnail: 'assets/images/course_math.jpg',
        rating: 4.8,
        reviewCount: 324,
        price: 299000,
        badge: 'Best Seller',
      ),
      CourseModel(
        id: '2',
        title: 'Tiếng Anh B1 - Giao Tiếp Thực Tế',
        instructorName: 'Cô Phạm Thị B',
        thumbnail: 'assets/images/course_english.jpg',
        rating: 4.9,
        reviewCount: 512,
        price: 249000,
        badge: 'Hot',
      ),
      CourseModel(
        id: '3',
        title: 'Hóa Học Hữu Cơ - Bước Tiến Cơ Bản',
        instructorName: 'Thầy Trần Văn C',
        thumbnail: 'assets/images/course_chemistry.jpg',
        rating: 4.7,
        reviewCount: 189,
        price: 279000,
        badge: 'Best Seller',
      ),
      CourseModel(
        id: '4',
        title: 'Vật Lý Điện Từ - Hiểu Sâu Công Thức',
        instructorName: 'Thầy Lê Minh D',
        thumbnail: 'assets/images/course_physics.jpg',
        rating: 4.6,
        reviewCount: 276,
        price: 289000,
        badge: '',
      ),
      CourseModel(
        id: '5',
        title: 'Lập Trình Python cho Người Mới Bắt Đầu',
        instructorName: 'Thầy Hoàng Anh E',
        thumbnail: 'assets/images/course_python.png',
        rating: 4.9,
        reviewCount: 698,
        price: 349000,
        badge: 'Hot',
      ),
    ];
  }
}
