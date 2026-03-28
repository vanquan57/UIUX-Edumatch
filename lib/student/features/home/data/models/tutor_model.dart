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
  final List<String>? certifications;

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
        certifications: ['IELTS 7.5', 'Sư phạm Toán'],
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
        certifications: ['Cambridge CAE', 'TOEFL'],
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
        certifications: ['Thạc sĩ Hóa học'],
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
        certifications: ['Sư phạm Văn'],
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
        certifications: ['Cử nhân CNPM'],
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
        certifications: ['IELTS 7.5', 'Sư phạm Toán'],
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
        certifications: ['Cambridge CAE', 'TOEFL'],
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
        certifications: ['Sư phạm Văn'],
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
        certifications: ['Cử nhân CNPM'],
      ),
    ];
  }
}
