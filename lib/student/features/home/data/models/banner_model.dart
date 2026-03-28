class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? ctaText;
  final String type; // course | tutor | external
  final String targetId; // ID của course, tutor, hoặc link external
  final String? badge; // Discount label

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.ctaText,
    required this.type,
    required this.targetId,
    this.badge,
  });

  // Mock data for UI development
  static List<BannerModel> mockBanners() {
    return [
      BannerModel(
        id: '1',
        title: 'Giảm 50% Khóa Học IELTS',
        subtitle: 'Khóa học Tiếng Anh chất lượng cao',
        imageUrl: 'assets/images/banner1.jpg',
        ctaText: 'Khám phá ngay',
        type: 'course',
        targetId: 'course_001',
        badge: 'Giảm 50%',
      ),
      BannerModel(
        id: '2',
        title: 'Gia sư Toán Hàng Đầu',
        subtitle: 'Tìm kiếm gia sư Toán chuyên nghiệp',
        imageUrl: 'assets/images/banner2.jpg',
        ctaText: 'Xem hồ sơ',
        type: 'tutor',
        targetId: 'tutor_001',
        badge: 'Sao 5',
      ),
      BannerModel(
        id: '3',
        title: 'Lớp Học Nhóm Online',
        subtitle: 'Học cùng các bạn, tiết kiệm chi phí',
        imageUrl: 'assets/images/banner3.jpg',
        ctaText: 'Đăng ký ngay',
        type: 'course',
        targetId: 'course_002',
        badge: 'Mới',
      ),
      BannerModel(
        id: '4',
        title: 'Sự Kiện Tuyển Gia Sư',
        subtitle: 'Tham gia sự kiện phát triển kỹ năng',
        imageUrl: 'assets/images/banner4.jpg',
        ctaText: 'Tìm hiểu',
        type: 'external',
        targetId: 'https://example.com/event',
        badge: 'Hot',
      ),
    ];
  }
}
