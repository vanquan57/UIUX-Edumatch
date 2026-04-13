class TransactionModel {
  final String id;
  final String type; // 'topup', 'payment', 'refund'
  final double amount;
  final String description;
  final DateTime createdAt;
  final String status; // 'completed', 'pending', 'failed'
  final String? paymentMethod; // 'bank_transfer', 'qr_code', 'wallet'
  final String? referenceId;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.status,
    this.paymentMethod,
    this.referenceId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String,
      paymentMethod: json['payment_method'] as String?,
      referenceId: json['reference_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'payment_method': paymentMethod,
      'reference_id': referenceId,
    };
  }
}

// Fake data for demo
final List<TransactionModel> kFakeTransactions = [
  TransactionModel(
    id: 'TXN001',
    type: 'topup',
    amount: 500000,
    description: 'Nạp tiền vào ví EduMatch',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'completed',
    paymentMethod: 'bank_transfer',
    referenceId: 'VCB123456789',
  ),
  TransactionModel(
    id: 'TXN002',
    type: 'payment',
    amount: -255000,
    description: 'Thanh toán buổi học với Thầy Nguyễn Văn A',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    status: 'completed',
    paymentMethod: 'wallet',
    referenceId: 'BOOKING001',
  ),
  TransactionModel(
    id: 'TXN003',
    type: 'topup',
    amount: 1000000,
    description: 'Nạp tiền vào ví EduMatch',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    status: 'completed',
    paymentMethod: 'qr_code',
    referenceId: 'QR987654321',
  ),
  TransactionModel(
    id: 'TXN004',
    type: 'payment',
    amount: -180000,
    description: 'Mua khóa học "Toán học cơ bản"',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    status: 'completed',
    paymentMethod: 'wallet',
    referenceId: 'COURSE001',
  ),
  TransactionModel(
    id: 'TXN005',
    type: 'topup',
    amount: 200000,
    description: 'Nạp tiền vào ví EduMatch',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    status: 'completed',
    paymentMethod: 'bank_transfer',
    referenceId: 'VCB111222333',
  ),
  TransactionModel(
    id: 'TXN006',
    type: 'refund',
    amount: 255000,
    description: 'Hoàn tiền buổi học bị hủy',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    status: 'completed',
    paymentMethod: 'wallet',
    referenceId: 'REFUND001',
  ),
  TransactionModel(
    id: 'TXN007',
    type: 'payment',
    amount: -320000,
    description: 'Thanh toán buổi học với Cô Trần Thị B',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    status: 'completed',
    paymentMethod: 'wallet',
    referenceId: 'BOOKING002',
  ),
  TransactionModel(
    id: 'TXN008',
    type: 'topup',
    amount: 800000,
    description: 'Nạp tiền vào ví EduMatch',
    createdAt: DateTime.now().subtract(const Duration(days: 12)),
    status: 'completed',
    paymentMethod: 'qr_code',
    referenceId: 'QR555666777',
  ),
  TransactionModel(
    id: 'TXN009',
    type: 'payment',
    amount: -150000,
    description: 'Mua khóa học "Tiếng Anh giao tiếp"',
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    status: 'completed',
    paymentMethod: 'wallet',
    referenceId: 'COURSE002',
  ),
  TransactionModel(
    id: 'TXN010',
    type: 'topup',
    amount: 300000,
    description: 'Nạp tiền vào ví EduMatch',
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
    status: 'pending',
    paymentMethod: 'bank_transfer',
    referenceId: 'VCB444555666',
  ),
];