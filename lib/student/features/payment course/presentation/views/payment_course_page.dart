import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:edu_match/student/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum _PaymentState { idle, processing, failed }

enum _PaymentMethod { bank, wallet }

enum _BankOption { internetBanking, vietQR }

// ─── Fake bank data ──────────────────────────────────────────────────────────

const _kBankName = 'Vietcombank (VCB)';
const _kBankAccount = '9901 2345 6789 0';
const _kBankOwner = 'CONG TY TNHH EDUMATCH';
const _kFakeCourseRef = 'EDUMATCH-CR20240402';

class PaymentCoursePage extends StatefulWidget {
  final String courseId;
  final String courseTitle;
  final double coursePrice;
  final String instructorName;

  const PaymentCoursePage({
    super.key,
    required this.courseId,
    required this.courseTitle,
    required this.coursePrice,
    required this.instructorName,
  });

  @override
  State<PaymentCoursePage> createState() => _PaymentCoursePageState();
}

class _PaymentCoursePageState extends State<PaymentCoursePage> {
  _PaymentState _paymentState = _PaymentState.idle;
  _PaymentMethod _selectedMethod = _PaymentMethod.bank;
  _BankOption _bankOption = _BankOption.internetBanking;

  static const double _feeRate = 0.02;
  static const double _walletBalance = 750000;

  double get _fee => widget.coursePrice * _feeRate;
  double get _total => widget.coursePrice + _fee;

  String get _transferContent =>
      '$_kFakeCourseRef ${_formatPrice(_total).replaceAll('₫', '').replaceAll('.', '')}';

  void _onPay() {
    if (_selectedMethod == _PaymentMethod.wallet) {
      _showWalletConfirmDialog();
      return;
    }
    _startPaymentFlow();
  }

  void _showWalletConfirmDialog() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (ctx) {
        final lightScheme = ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.light,
        ).copyWith(surface: AppColors.white);
        return Theme(
          data: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: lightScheme,
            dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
          ),
          child: AlertDialog(
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 8,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            title: Text(
              'Xác nhận thanh toán',
              style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            content: Text(
              'Bạn có chắc muốn thanh toán bằng Ví EduMatch?',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textGray,
                height: 1.45,
              ),
            ),
            actionsPadding:
                EdgeInsets.only(left: 16.w, right: 8.w, bottom: 12.h),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Không',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _startPaymentFlow();
                },
                child: Text(
                  'Đồng ý',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startPaymentFlow() {
    setState(() => _paymentState = _PaymentState.processing);
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      context.pushReplacement(
        AppRouter.coursePaymentSuccess,
        extra: {
          'courseTitle': widget.courseTitle,
        },
      );
    });
  }

  String _formatPrice(double price) {
    final str = price.toInt().toString();
    String result = '';
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) result += '.';
      result += str[i];
    }
    return '$result₫';
  }

  @override
  Widget build(BuildContext context) {
    switch (_paymentState) {
      case _PaymentState.processing:
        return _buildProcessingOverlay();
      case _PaymentState.failed:
        return _buildFailedScreen();
      case _PaymentState.idle:
        return _buildIdleScreen();
    }
  }

  // ─── Idle ─────────────────────────────────────────────────────────────────

  Widget _buildIdleScreen() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildSectionLabel('Thông Tin Khóa Học'),
              SizedBox(height: 10.h),
              _buildCourseSummaryCard(),
              SizedBox(height: 20.h),
              _buildSectionLabel('Thông Tin Người Thanh Toán'),
              SizedBox(height: 10.h),
              _buildStudentInfoCard(),
              SizedBox(height: 20.h),
              _buildSectionLabel('Phương Thức Thanh Toán'),
              SizedBox(height: 10.h),
              _buildMethodTabs(),
              SizedBox(height: 12.h),
              _buildPaymentDetail(),
              SizedBox(height: 20.h),
              _buildSectionLabel('Chi Tiết Thanh Toán'),
              SizedBox(height: 10.h),
              _buildPriceSummary(),
              SizedBox(height: 110.h),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildPayButton(),
        ),
      ],
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.arrow_back, color: AppColors.textDark, size: 22.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'Thanh Toán',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  // ─── Course Summary ───────────────────────────────────────────────────────

  Widget _buildCourseSummaryCard() {
    // Get course details from mock data
    final course = CourseModel.mockCourses().firstWhere(
      (c) => c.id == widget.courseId,
      orElse: () => CourseModel.mockCourses().first,
    );

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course header
          Row(
            children: [
              Container(
                width: 46.w,
                height: 46.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(Icons.play_circle_filled, color: AppColors.white, size: 26.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseTitle,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            size: 11.sp, color: AppColors.primaryGreen),
                        SizedBox(width: 4.w),
                        Text(
                          widget.instructorName,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildBadge(
                'Online',
                Icons.videocam,
                AppColors.primaryGreen,
                AppColors.lightGreen,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: AppColors.dividerColor, height: 1),
          SizedBox(height: 12.h),

          // Course details
          _buildInfoRow(
            Icons.school_outlined,
            'Loại khóa học',
            'Khóa học trực tuyến tự học',
          ),
          SizedBox(height: 8.h),

          _buildInfoRow(
            Icons.access_time,
            'Thời lượng',
            '${course.totalHours} giờ video • ${course.totalLectures} bài giảng',
          ),
          SizedBox(height: 8.h),

          _buildInfoRow(
            Icons.star_outline,
            'Đánh giá',
            '${course.rating}/5 (${course.reviewCount} đánh giá)',
          ),
          SizedBox(height: 8.h),

          _buildInfoRow(
            Icons.people_outline,
            'Học viên',
            '${course.totalStudents} học viên đã đăng ký',
          ),
          SizedBox(height: 8.h),

          _buildInfoRow(
            Icons.verified_outlined,
            'Chứng chỉ',
            'Có cấp chứng chỉ hoàn thành',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.textGray),
        SizedBox(width: 8.w),
        SizedBox(
          width: 72.w,
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 12.sp, color: AppColors.textGray),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String label, IconData icon, Color fg, Color bg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: fg),
          SizedBox(width: 3.w),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 10.sp, fontWeight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }

  // ─── Student Info ──────────────────────────────────────────────────────────

  Widget _buildStudentInfoCard() {
    const s = kFakeStudent;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.person_outline,
                      color: AppColors.primaryGreen, size: 22.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.name,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'ID: ${s.id}',
                      style: GoogleFonts.inter(
                          fontSize: 10.sp, color: AppColors.textLightGray),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: AppColors.dividerColor, height: 1),
          SizedBox(height: 12.h),
          _buildStudentRow(Icons.phone_outlined, 'Điện thoại', s.phone),
          SizedBox(height: 8.h),
          _buildStudentRow(Icons.email_outlined, 'Email', s.email),
          SizedBox(height: 8.h),
          _buildStudentRow(Icons.location_on_outlined, 'Địa chỉ', s.address,
              multiline: true),
        ],
      ),
    );
  }

  Widget _buildStudentRow(IconData icon, String label, String value,
      {bool multiline = false}) {
    return Row(
      crossAxisAlignment:
          multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.primaryGreen),
        SizedBox(width: 8.w),
        SizedBox(
          width: 72.w,
          child: Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: AppColors.textGray)),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark),
            maxLines: multiline ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ─── Payment Method Tabs ───────────────────────────────────────────────────

  Widget _buildMethodTabs() {
    final tabs = [
      (_PaymentMethod.bank, Icons.account_balance, 'Ngân hàng'),
      (_PaymentMethod.wallet, Icons.account_balance_wallet_outlined, 'Ví EduMatch'),
    ];

    return Row(
      children: List.generate(tabs.length, (i) {
        final (method, icon, label) = tabs[i];
        final isSelected = _selectedMethod == method;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedMethod = method),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: i == 0 ? 10.w : 0),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryGreen
                      : AppColors.borderColor,
                ),
              ),
              child: Column(
                children: [
                  Icon(icon,
                      size: 22.sp,
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textGray),
                  SizedBox(height: 4.h),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? AppColors.white : AppColors.textGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ─── Payment Detail (switches by method/option) ────────────────────────────

  Widget _buildPaymentDetail() {
    if (_selectedMethod == _PaymentMethod.wallet) {
      return _buildWalletDetail();
    }
    return _buildBankDetail();
  }

  // Ngân hàng: sub-tabs + info
  Widget _buildBankDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sub-option selector
        Row(
          children: [
            _buildBankSubTab(
              _BankOption.internetBanking,
              Icons.language,
              'Internet Banking',
            ),
            SizedBox(width: 10.w),
            _buildBankSubTab(
              _BankOption.vietQR,
              Icons.qr_code_2,
              'VietQR',
            ),
          ],
        ),
        SizedBox(height: 14.h),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _bankOption == _BankOption.internetBanking
              ? _buildInternetBankingInfo()
              : _buildVietQRInfo(),
        ),
      ],
    );
  }

  Widget _buildBankSubTab(_BankOption opt, IconData icon, String label) {
    final isSelected = _bankOption == opt;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _bankOption = opt),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lightGreen : AppColors.bgLight,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16.sp,
                  color: isSelected
                      ? AppColors.primaryGreen
                      : AppColors.textGray),
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.primaryGreen
                      : AppColors.textGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInternetBankingInfo() {
    return Container(
      key: const ValueKey('internet'),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF006B3E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(Icons.account_balance,
                      color: const Color(0xFF006B3E), size: 20.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                _kBankName,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Divider(color: AppColors.dividerColor, height: 1),
          SizedBox(height: 14.h),
          _buildBankRow('Số tài khoản', _kBankAccount, copyable: true),
          SizedBox(height: 10.h),
          _buildBankRow('Chủ tài khoản', _kBankOwner),
          SizedBox(height: 10.h),
          _buildBankRow('Số tiền', _formatPrice(_total),
              valueColor: AppColors.primaryGreen, bold: true),
          SizedBox(height: 10.h),
          _buildBankRow('Nội dung', _transferContent, copyable: true),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.warningOrange.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    size: 14.sp, color: AppColors.warningOrange),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Vui lòng chuyển đúng nội dung để hệ thống tự động xác nhận.',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: AppColors.warningOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankRow(
    String label,
    String value, {
    bool copyable = false,
    Color? valueColor,
    bool bold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: AppColors.textGray),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? AppColors.textDark,
            ),
          ),
        ),
        if (copyable)
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đã sao chép: $value'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Icon(Icons.copy_outlined,
                size: 14.sp, color: AppColors.primaryGreen),
          ),
      ],
    );
  }

  Widget _buildVietQRInfo() {
    final qrData =
        'Bank=$_kBankName|STK=$_kBankAccount|Amount=${_total.toInt()}|Content=$_transferContent';

    return Container(
      key: const ValueKey('vietqr'),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          // QR code
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 180.w,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Color(0xFF1C8659),
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF005BAC),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'VietQR',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF005BAC),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.dividerColor, height: 1),
          SizedBox(height: 14.h),
          _buildBankRow('Ngân hàng', _kBankName),
          SizedBox(height: 8.h),
          _buildBankRow('Số tài khoản', _kBankAccount, copyable: true),
          SizedBox(height: 8.h),
          _buildBankRow('Số tiền', _formatPrice(_total),
              valueColor: AppColors.primaryGreen, bold: true),
          SizedBox(height: 8.h),
          _buildBankRow('Nội dung', _transferContent, copyable: true),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.warningOrange.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    size: 14.sp, color: AppColors.warningOrange),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Quét mã QR bằng app ngân hàng để chuyển khoản nhanh.',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: AppColors.warningOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Wallet detail
  Widget _buildWalletDetail() {
    final canPay = _walletBalance >= _total;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: canPay ? AppColors.primaryGreen : AppColors.errorRed,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(Icons.account_balance_wallet_outlined,
                      color: AppColors.primaryGreen, size: 22.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ví EduMatch',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Số dư: ${_formatPrice(_walletBalance)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: canPay
                            ? AppColors.successGreen
                            : AppColors.errorRed,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                canPay ? Icons.check_circle : Icons.cancel,
                color: canPay ? AppColors.successGreen : AppColors.errorRed,
                size: 20.sp,
              ),
            ],
          ),
          if (!canPay) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.errorRed.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 14.sp, color: AppColors.errorRed),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Số dư không đủ. Cần thêm ${_formatPrice(_total - _walletBalance)} để hoàn tất.',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: AppColors.errorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Price Summary ─────────────────────────────────────────────────────────

  Widget _buildPriceSummary() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          _buildPriceRow('Giá khóa học', _formatPrice(widget.coursePrice)),
          SizedBox(height: 10.h),
          _buildPriceRow('Phí dịch vụ (2%)', _formatPrice(_fee),
              subNote: 'Bao gồm VAT'),
          SizedBox(height: 12.h),
          Divider(color: AppColors.dividerColor, height: 1),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng Thanh Toán',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                _formatPrice(_total),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {String? subNote}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: AppColors.textGray)),
            if (subNote != null)
              Text(subNote,
                  style: GoogleFonts.inter(
                      fontSize: 10.sp, color: AppColors.textLightGray)),
          ],
        ),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
      ],
    );
  }

  // ─── Pay Button ────────────────────────────────────────────────────────────

  Widget _buildPayButton() {
    final walletInsufficient = _selectedMethod == _PaymentMethod.wallet &&
        _walletBalance < _total;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.dividerColor)),
        boxShadow: [
          BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, -3)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng tiền',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: AppColors.textGray)),
              Text(_formatPrice(_total),
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryGreen)),
            ],
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: walletInsufficient ? null : _onPay,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                gradient: walletInsufficient
                    ? null
                    : LinearGradient(
                        colors: [AppColors.primaryGreen, AppColors.accentGreen],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                color: walletInsufficient ? AppColors.disabledGray : null,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: walletInsufficient
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.primaryGreen.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      walletInsufficient
                          ? Icons.block
                          : Icons.check_circle_outline,
                      color: AppColors.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      walletInsufficient
                          ? 'Số dư không đủ'
                          : (_selectedMethod == _PaymentMethod.bank
                              ? 'Xác nhận đã thanh toán'
                              : 'Xác nhận thanh toán'),
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Processing ────────────────────────────────────────────────────────────

  Widget _buildProcessingOverlay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
                color: AppColors.lightGreen, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                width: 36.w,
                height: 36.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text('Đang xử lý thanh toán...',
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          SizedBox(height: 8.h),
          Text('Vui lòng không thoát khỏi màn hình này',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: AppColors.textGray)),
        ],
      ),
    );
  }

  // ─── Failed ────────────────────────────────────────────────────────────────

  Widget _buildFailedScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                  color: AppColors.errorRed.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: Center(
                child: Icon(Icons.cancel,
                    color: AppColors.errorRed, size: 52.sp),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Thanh Toán Thất Bại',
                style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark)),
            SizedBox(height: 8.h),
            Text(
              'Giao dịch không thể hoàn tất.\nVui lòng thử lại hoặc chọn phương thức khác.',
              style: GoogleFonts.inter(
                  fontSize: 13.sp, color: AppColors.textGray, height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: () => setState(() => _paymentState = _PaymentState.idle),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text('Thử Lại',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Center(
                  child: Text('Quay Lại',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textGray)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
