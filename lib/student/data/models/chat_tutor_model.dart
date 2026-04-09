class ChatTutorModel {
  final String id;
  final String name;
  final String subject;
  final bool hasUnreadMessage;

  const ChatTutorModel({
    required this.id,
    required this.name,
    required this.subject,
    this.hasUnreadMessage = false,
  });

  String get shortName {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  static List<ChatTutorModel> mockData() {
    return const [
      ChatTutorModel(
        id: 'tutor-001',
        name: 'Nguyen Hoang Minh',
        subject: 'Toan',
        hasUnreadMessage: true,
      ),
      ChatTutorModel(
        id: 'tutor-002',
        name: 'Tran Thi Bao Ngan',
        subject: 'Tieng Anh',
      ),
      ChatTutorModel(
        id: 'tutor-003',
        name: 'Le Quoc Khanh',
        subject: 'Vat Ly',
        hasUnreadMessage: true,
      ),
      ChatTutorModel(
        id: 'tutor-004',
        name: 'Pham Thu Uyen',
        subject: 'Hoa Hoc',
      ),
      ChatTutorModel(
        id: 'tutor-005', 
        name: 'Doan Gia Bao', 
        subject: 'Ngu Van'
      ),
      ChatTutorModel(
        id: 'tutor-006', 
        name: 'Vo Nhat Anh', 
        subject: 'Sinh Hoc'
      ),
      ChatTutorModel(
        id: 'tutor-007',
        name: 'Hoang Truc Lam',
        subject: 'Lich Su',
        hasUnreadMessage: true,
      ),
      ChatTutorModel(
        id: 'tutor-008',
        name: 'Nguyen Phuc An',
        subject: 'Dia Ly',
      ),
      ChatTutorModel(
        id: 'tutor-009',
        name: 'Bui Minh Chau',
        subject: 'Tieng Trung',
      ),
      ChatTutorModel(
        id: 'tutor-010',
        name: 'Dang Quynh Trang',
        subject: 'Tieng Han',
      ),
    ];
  }
}
