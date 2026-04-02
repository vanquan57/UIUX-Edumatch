class StudentModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? avatarUrl;

  const StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.avatarUrl,
  });
}

/// Fake student dùng để hiển thị UI
const kFakeStudent = StudentModel(
  id: 'stu_001',
  name: 'Nguyễn Minh Khoa',
  email: 'minhkhoa.student@gmail.com',
  phone: '0912 345 678',
  address: '123 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP.HCM',
);
