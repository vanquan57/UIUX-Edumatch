class ExperienceModel {
  final String title;
  final String company;
  final String duration;
  final String description;

  ExperienceModel({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
  });
}

class CertificateModel {
  final String name;
  final String? issuer;
  final String? image; // Certificate image/badge

  CertificateModel({required this.name, this.issuer, this.image});
}

class ReviewModel {
  final String name;
  final int rating;
  final String text;
  final String date;

  ReviewModel({
    required this.name,
    required this.rating,
    required this.text,
    required this.date,
  });
}

class TutorModel {
  final String id;
  final String name;
  final String avatar;
  final double rating;
  final int reviewCount;
  final double pricePerHour;
  final List<String> subjects;
  final bool isOnline;
  final String? bio;
  final List<CertificateModel>? certifications;
  final List<ExperienceModel>? experiences;
  final List<ReviewModel>? reviews;
  final double latitude; // Tọa độ Đà Nẵng
  final double longitude; // Tọa độ Đà Nẵng

  TutorModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    required this.subjects,
    required this.isOnline,
    this.bio,
    this.certifications,
    this.experiences,
    this.reviews,
    required this.latitude,
    required this.longitude,
  });

  // Mock data for UI development
  static List<TutorModel> mockTutors() {
    return [
      TutorModel(
        id: '1',
        name: 'Thầy Minh',
        avatar: 'assets/images/tutor1.png',
        rating: 4.8,
        reviewCount: 245,
        pricePerHour: 150000,
        subjects: ['Toán', 'Vật lý'],
        isOnline: true,
        bio: 'Giáo viên Toán với 8 năm kinh nghiệm',
        certifications: [
          CertificateModel(
            name: 'Sư phạm Toán',
            issuer: 'ĐH Sư phạm Hà Nội',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'Thạc sĩ Toán học',
            issuer: 'ĐH Quốc gia Hà Nội',
            image: 'assets/images/certificate_3.jpg',
          ),
          CertificateModel(
            name: 'Tiến sĩ Toán học',
            issuer: 'ĐH Quốc gia Hà Nội',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Toán',
            company: 'Trường THPT chuyên Lê Hồng Phong',
            duration: '2016 - Nay (8 năm)',
            description: 'Giảng dạy Toán cho các lớp 10, 11, 12',
          ),
          ExperienceModel(
            title: 'Gia sư Toán riêng',
            company: 'Độc lập',
            duration: '2015 - Nay',
            description: 'Dạy kèm Toán cho học sinh lớp 6 đến 12',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0544,
        longitude: 108.2022,
      ),
      TutorModel(
        id: '2',
        name: 'Cô Lan',
        avatar: 'assets/images/tutor2.png',
        rating: 4.9,
        reviewCount: 312,
        pricePerHour: 180000,
        subjects: ['Tiếng Anh', 'IELTS'],
        isOnline: true,
        bio: 'Chuyên gia Tiếng Anh, hơn 10 năm kinh nghiệm',
        certifications: [
          CertificateModel(
            name: 'Cambridge CAE',
            issuer: 'Cambridge',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'TOEFL iBT 110',
            issuer: 'ETS',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0690,
        longitude: 108.2050,
      ),
      TutorModel(
        id: '3',
        name: 'Thầy Hùng',
        avatar: 'assets/images/tutor3.png',
        rating: 4.7,
        reviewCount: 189,
        pricePerHour: 140000,
        subjects: ['Hóa học', 'Sinh học'],
        isOnline: false,
        bio: 'Giảng viên Hóa - Sinh tại ĐH Quốc gia',
        certifications: [
          CertificateModel(
            name: 'Thạc sĩ Hóa học',
            issuer: 'ĐH Quốc gia Hà Nội',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giảng viên Hóa học',
            company: 'ĐH Quốc gia Hà Nội',
            duration: '2015 - Nay (9 năm)',
            description: 'Giảng dạy Hóa học và Sinh học tại đại học',
          ),
          ExperienceModel(
            title: 'Nhà nghiên cứu',
            company: 'Viện Hóa học',
            duration: '2013 - 2015',
            description: 'Nghiên cứu các hợp chất hữu cơ',
          ),
        ],
        latitude: 16.0428,
        longitude: 108.1961,
      ),
      TutorModel(
        id: '4',
        name: 'Cô Hà',
        avatar: 'assets/images/tutor4.png',
        rating: 4.9,
        reviewCount: 267,
        pricePerHour: 170000,
        subjects: ['Văn học', 'Lịch sử'],
        isOnline: true,
        bio: 'Giáo viên Văn dạy tại trường chuyên',
        certifications: [
          CertificateModel(
            name: 'Sư phạm Văn',
            issuer: 'ĐH Sư phạm Hà Nội',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Văn',
            company: 'Trường THPT chuyên Nguyễn Huệ',
            duration: '2014 - Nay (10 năm)',
            description: 'Dạy Văn học cho các lớp chuyên, soạn đề thi',
          ),
          ExperienceModel(
            title: 'Tuyên truyền viên',
            company: 'Sở Giáo dục Hà Nội',
            duration: '2012 - 2014',
            description: 'Phát triển chương trình Văn học',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0750,
        longitude: 108.2100,
      ),
      TutorModel(
        id: '5',
        name: 'Thầy Khánh',
        avatar: 'assets/images/tutor5.png',
        rating: 4.6,
        reviewCount: 156,
        pricePerHour: 120000,
        subjects: ['Toán', 'Tin học'],
        isOnline: true,
        bio: 'Chuyên gia Lập trình & Toán',
        certifications: [
          CertificateModel(
            name: 'Cử nhân CNPM',
            issuer: 'ĐH Công nghệ',
            image: 'assets/images/certificate_2.jpg',
          ),
          CertificateModel(
            name: 'Java Developer',
            issuer: 'Oracle',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Kỹ sư phần mềm',
            company: 'FPT Software',
            duration: '2015 - Nay (9 năm)',
            description: 'Phát triển ứng dụng web và mobile',
          ),
          ExperienceModel(
            title: 'Freelancer',
            company: 'Fiverr/Upwork',
            duration: '2013 - 2015',
            description: 'Lập trình dự án cho khách hàng quốc tế',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0400,
        longitude: 108.2180,
      ),
      TutorModel(
        id: '6',
        name: 'Thầy Nam',
        avatar: 'assets/images/tutor1.png',
        rating: 4.5,
        reviewCount: 198,
        pricePerHour: 130000,
        subjects: ['Tiếng Anh', 'Toán'],
        isOnline: true,
        bio: 'Giáo viên Tiếng Anh với 5 năm kinh nghiệm',
        certifications: [
          CertificateModel(
            name: 'TOEIC 900',
            issuer: 'ETS',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Tiếng Anh',
            company: 'Trung tâm Anh ngữ Apollo',
            duration: '2017 - Nay (7 năm)',
            description: 'Dạy TOEIC, IELTS cho học sinh nước ngoài',
          ),
          ExperienceModel(
            title: 'Biên phiên dịch',
            company: 'Công ty ABC Corp',
            duration: '2015 - 2017',
            description: 'Phiên dịch trong các hội thảo quốc tế',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0650,
        longitude: 108.1890,
      ),
      TutorModel(
        id: '7',
        name: 'Cô Tâm',
        avatar: 'assets/images/tutor2.png',
        rating: 4.8,
        reviewCount: 276,
        pricePerHour: 160000,
        subjects: ['Tiếng Pháp', 'Du lịch'],
        isOnline: false,
        bio: 'Chuyên gia Tiếng Pháp, du học tại Paris',
        certifications: [
          CertificateModel(
            name: 'DALF C1',
            issuer: 'France Education',
            image: 'assets/images/certificate_2.jpg',
          ),
          CertificateModel(
            name: 'DELF B2',
            issuer: 'France Education',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Tiếng Pháp',
            company: 'Đại học Pháp-Việt',
            duration: '2016 - Nay (8 năm)',
            description: 'Giảng dạy Tiếng Pháp cho du học sinh',
          ),
          ExperienceModel(
            title: 'Du học',
            company: 'Sorbonne Université',
            duration: '2013 - 2015',
            description: 'Học bổng trường Sorbonne, học tiếng Pháp nâng cao',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0500,
        longitude: 108.2150,
      ),
      TutorModel(
        id: '8',
        name: 'Thầy Tuấn',
        avatar: 'assets/images/tutor3.png',
        rating: 4.7,
        reviewCount: 223,
        pricePerHour: 145000,
        subjects: ['Vật lý', 'Toán'],
        isOnline: true,
        bio: 'Giảng viên Vật lý tại ĐH Bách Khoa',
        certifications: [
          CertificateModel(
            name: 'Tiến sĩ Vật lý',
            issuer: 'ĐH Bách Khoa',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giảng viên Vật lý',
            company: 'ĐH Bách Khoa Hà Nội',
            duration: '2014 - Nay (10 năm)',
            description: 'Giảng dạy Vật lý đại cương và Vật lý chuyên sâu',
          ),
          ExperienceModel(
            title: 'Nhà nghiên cứu',
            company: 'Viện Vật lý',
            duration: '2012 - 2014',
            description: 'Nghiên cứu vật liệu bán dẫn',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0720,
        longitude: 108.1950,
      ),
      TutorModel(
        id: '9',
        name: 'Cô Hương',
        avatar: 'assets/images/tutor4.png',
        rating: 4.9,
        reviewCount: 301,
        pricePerHour: 175000,
        subjects: ['Sinh học', 'IELTS'],
        isOnline: true,
        bio: 'Giáo viên Sinh học và IELTS chuyên nghiệp',
        certifications: [
          CertificateModel(
            name: 'IELTS 8.0',
            issuer: 'British Council',
            image: 'assets/images/certificate_2.jpg',
          ),
          CertificateModel(
            name: 'Thạc sĩ Sinh học',
            issuer: 'ĐH Tây Âu',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Sinh học',
            company: 'Trường THPT chuyên Lê Hồng Phong',
            duration: '2015 - Nay (9 năm)',
            description: 'Dạy Sinh học cho các lớp chuyên khoa học',
          ),
          ExperienceModel(
            title: 'Tư vấn khoa học',
            company: 'Bộ Giáo dục',
            duration: '2014 - 2015',
            description: 'Phát triển chương trình Sinh học',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0320,
        longitude: 108.2080,
      ),
      TutorModel(
        id: '10',
        name: 'Thầy Quân',
        avatar: 'assets/images/tutor5.png',
        rating: 4.6,
        reviewCount: 167,
        pricePerHour: 135000,
        subjects: ['Tin học', 'Lập trình'],
        isOnline: true,
        bio: 'Lập trình viên Full-stack, dạy kỹ năng IT',
        certifications: [
          CertificateModel(
            name: 'Cử nhân CNTT',
            issuer: 'ĐH Công nghệ',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'AWS Certified',
            issuer: 'Amazon',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Senior Developer',
            company: 'Google Vietnam',
            duration: '2017 - Nay (7 năm)',
            description: 'Phát triển ứng dụng web quy mô lớn',
          ),
          ExperienceModel(
            title: 'Developer',
            company: 'Startup XYZ',
            duration: '2014 - 2017',
            description: 'Xây dựng nền tảng e-commerce',
          ),
        ],
        latitude: 16.0580,
        longitude: 108.2050,
      ),
      TutorModel(
        id: '11',
        name: 'Cô Liên',
        avatar: 'assets/images/tutor1.png',
        rating: 4.8,
        reviewCount: 289,
        pricePerHour: 165000,
        subjects: ['Toán', 'Hóa học'],
        isOnline: false,
        bio: 'Thủ khoa Toán, kinh nghiệm dạy 12 năm',
        certifications: [
          CertificateModel(
            name: 'Thạc sĩ Toán học',
            issuer: 'ĐH Quốc gia',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Toán',
            company: 'Trường THPT chuyên Lê Hồng Phong',
            duration: '2012 - Nay (12 năm)',
            description: 'Dạy Toán cho các lớp 10, 11, 12 chuyên',
          ),
          ExperienceModel(
            title: 'Gia sư Toán',
            company: 'Độc lập',
            duration: '2010 - 2012',
            description: 'Dạy kèm Toán cho học sinh cấp 2 và 3',
          ),
        ],
        latitude: 16.0470,
        longitude: 108.2000,
      ),
      TutorModel(
        id: '12',
        name: 'Thầy Độ',
        avatar: 'assets/images/tutor2.png',
        rating: 4.7,
        reviewCount: 234,
        pricePerHour: 155000,
        subjects: ['Lịch sử', 'Địa lý'],
        isOnline: true,
        bio: 'Giáo viên Lịch sử-Địa lý tại trường chuyên',
        certifications: [
          CertificateModel(
            name: 'Sư phạm Lịch sử',
            issuer: 'ĐH Sư phạm',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'Giáo dục',
            issuer: 'Bộ GD',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Lịch sử',
            company: 'Trường THPT chuyên',
            duration: '2013 - Nay (11 năm)',
            description: 'Giảng dạy Lịch sử và Địa lý cho các lớp 10, 11, 12',
          ),
          ExperienceModel(
            title: 'Cộng tác viên',
            company: 'Bảo tàng Quốc gia',
            duration: '2011 - 2013',
            description: 'Hướng dẫn du khách và tổ chức triển lãm',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0680,
        longitude: 108.1920,
      ),
      TutorModel(
        id: '13',
        name: 'Cô Thảo',
        avatar: 'assets/images/tutor3.png',
        rating: 4.9,
        reviewCount: 318,
        pricePerHour: 185000,
        subjects: ['Tiếng Anh', 'Văn học', 'TOEFL'],
        isOnline: true,
        bio: 'Chuyên gia TOEFL, đã giúp 500+ học sinh',
        certifications: [
          CertificateModel(
            name: 'TOEFL 115',
            issuer: 'ETS',
            image: 'assets/images/certificate_3.jpg',
          ),
          CertificateModel(
            name: 'Cambridge Proficiency',
            issuer: 'Cambridge',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Chuyên gia TOEFL',
            company: 'Trung tâm luyện thi quốc tế',
            duration: '2015 - Nay (9 năm)',
            description: 'Huấn luyện TOEFL, IELTS cho hàng trăm học sinh',
          ),
          ExperienceModel(
            title: 'Biên tập viên',
            company: 'Nhà xuất bản Giáo dục',
            duration: '2013 - 2015',
            description: 'Biên tập sách luyện thi tiếng Anh',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0350,
        longitude: 108.2120,
      ),
      TutorModel(
        id: '14',
        name: 'Thầy Long',
        avatar: 'assets/images/tutor4.png',
        rating: 4.6,
        reviewCount: 176,
        pricePerHour: 125000,
        subjects: ['Toán', 'Kinh tế'],
        isOnline: false,
        bio: 'Giảng viên Kinh tế, chuyên Toán ứng dụng',
        certifications: [
          CertificateModel(
            name: 'Thạc sĩ Kinh tế',
            issuer: 'ĐH Quốc gia',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giảng viên Kinh tế',
            company: 'ĐH Kinh tế Quốc dân',
            duration: '2014 - Nay (10 năm)',
            description: 'Dạy Kinh tế lượng, Toán tài chính',
          ),
          ExperienceModel(
            title: 'Nhà kinh tế',
            company: 'Viện Nghiên cứu CIEM',
            duration: '2012 - 2014',
            description: 'Phân tích chính sách kinh tế',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0750,
        longitude: 108.1850,
      ),
      TutorModel(
        id: '15',
        name: 'Cô Mai',
        avatar: 'assets/images/tutor5.png',
        rating: 4.8,
        reviewCount: 254,
        pricePerHour: 170000,
        subjects: ['Âm nhạc', 'Piano', 'Thanh nhạc'],
        isOnline: true,
        bio: 'Giáo viên âm nhạc chuyên nghiệp tại nhạc viện',
        certifications: [
          CertificateModel(
            name: 'Bằng âm nhạc ABRSM',
            issuer: 'ABRSM',
            image: 'assets/images/certificate_3.jpg',
          ),
          CertificateModel(
            name: 'Piano LCME',
            issuer: 'LCME',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Piano',
            company: 'Nhạc viện Hà Nội',
            duration: '2014 - Nay (10 năm)',
            description: 'Dạy Piano, thanh nhạc cho học sinh mọi trình độ',
          ),
          ExperienceModel(
            title: 'Nghệ sĩ trình diễn',
            company: 'Dàn nhạc giao hưởng',
            duration: '2012 - 2014',
            description: 'Biểu diễn Piano tại các sự kiện quốc tế',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0790,
        longitude: 108.1952,
      ),
    ];
  }

  // Mock data for online tutors
  static List<TutorModel> mockOnlineTutors() {
    return [
      TutorModel(
        id: '1',
        name: 'Thầy Minh',
        avatar: 'assets/images/tutor1.png',
        rating: 4.8,
        reviewCount: 245,
        pricePerHour: 150000,
        subjects: ['Toán', 'Vật lý'],
        isOnline: true,
        bio: 'Giáo viên Toán với 8 năm kinh nghiệm',
        certifications: [
          CertificateModel(
            name: 'Sư phạm Toán',
            issuer: 'ĐH Sư phạm Hà Nội',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'Thạc sĩ Toán học',
            issuer: 'ĐH Quốc gia Hà Nội',
            image: 'assets/images/certificate_3.jpg',
          ),
          CertificateModel(
            name: 'Tiến sĩ Toán học',
            issuer: 'ĐH Quốc gia Hà Nội',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Toán',
            company: 'Trường THPT chuyên Lê Hồng Phong',
            duration: '2016 - Nay (8 năm)',
            description: 'Giảng dạy Toán cho các lớp 10, 11, 12',
          ),
          ExperienceModel(
            title: 'Gia sư Toán riêng',
            company: 'Độc lập',
            duration: '2015 - Nay',
            description: 'Dạy kèm Toán cho học sinh lớp 6 đến 12',
          ),
        ],
        reviews: [
          ReviewModel(
            name: 'Nguyễn Văn A',
            rating: 5,
            text: 'Thầy dạy rất tốt, tôi hiểu bài ngay',
            date: '2 tuần trước',
          ),
          ReviewModel(
            name: 'Trần Thị B',
            rating: 4,
            text: 'Nội dung hay nhưng muốn có thêm bài tập',
            date: '1 tháng trước',
          ),
          ReviewModel(
            name: 'Lê Văn C',
            rating: 5,
            text: 'Xuất sắc! Điểm Toán của tôi tăng rất nhanh',
            date: '1 tháng trước',
          ),
        ],
        latitude: 16.0544,
        longitude: 108.2022,
      ),
      TutorModel(
        id: '2',
        name: 'Cô Lan',
        avatar: 'assets/images/tutor2.png',
        rating: 4.9,
        reviewCount: 312,
        pricePerHour: 180000,
        subjects: ['Tiếng Anh', 'IELTS'],
        isOnline: true,
        bio: 'Chuyên gia Tiếng Anh, hơn 10 năm kinh nghiệm',
        certifications: [
          CertificateModel(
            name: 'Cambridge CAE',
            issuer: 'Cambridge',
            image: 'assets/images/certificate_1.jpg',
          ),
          CertificateModel(
            name: 'TOEFL iBT 110',
            issuer: 'ETS',
            image: 'assets/images/certificate_2.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Tiếng Anh',
            company: 'Trường Quốc tế British School',
            duration: '2015 - Nay (9 năm)',
            description: 'Giảng dạy Tiếng Anh cho các lớp IELTS, Cambridge',
          ),
          ExperienceModel(
            title: 'Chuyên gia IELTS',
            company: 'Du học Singapore',
            duration: '2014 - 2015',
            description: 'Thực tập và phát triển kỹ năng IELTS',
          ),
        ],
        latitude: 16.0690,
        longitude: 108.2050,
      ),
      TutorModel(
        id: '4',
        name: 'Cô Hà',
        avatar: 'assets/images/tutor4.png',
        rating: 4.9,
        reviewCount: 267,
        pricePerHour: 170000,
        subjects: ['Văn học', 'Lịch sử'],
        isOnline: true,
        bio: 'Giáo viên Văn dạy tại trường chuyên',
        certifications: [
          CertificateModel(
            name: 'Sư phạm Văn',
            issuer: 'ĐH Sư phạm Hà Nội',
            image: 'assets/images/certificate_1.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Giáo viên Văn',
            company: 'Trường THPT chuyên Nguyễn Huệ',
            duration: '2014 - Nay (10 năm)',
            description: 'Dạy Văn học cho các lớp chuyên, soạn đề thi',
          ),
          ExperienceModel(
            title: 'Tuyên truyền viên',
            company: 'Sở Giáo dục Hà Nội',
            duration: '2012 - 2014',
            description: 'Phát triển chương trình Văn học',
          ),
        ],
        latitude: 16.0750,
        longitude: 108.2100,
      ),
      TutorModel(
        id: '5',
        name: 'Thầy Khánh',
        avatar: 'assets/images/tutor5.png',
        rating: 4.6,
        reviewCount: 156,
        pricePerHour: 120000,
        subjects: ['Toán', 'Tin học'],
        isOnline: true,
        bio: 'Chuyên gia Lập trình & Toán',
        certifications: [
          CertificateModel(
            name: 'Cử nhân CNPM',
            issuer: 'ĐH Công nghệ',
            image: 'assets/images/certificate_2.jpg',
          ),
          CertificateModel(
            name: 'Java Developer',
            issuer: 'Oracle',
            image: 'assets/images/certificate_3.jpg',
          ),
        ],
        experiences: [
          ExperienceModel(
            title: 'Kỹ sư phần mềm',
            company: 'FPT Software',
            duration: '2015 - Nay (9 năm)',
            description: 'Phát triển ứng dụng web và mobile',
          ),
          ExperienceModel(
            title: 'Freelancer',
            company: 'Fiverr/Upwork',
            duration: '2013 - 2015',
            description: 'Lập trình dự án cho khách hàng quốc tế',
          ),
        ],
        latitude: 16.0400,
        longitude: 108.2180,
      ),
    ];
  }
}
