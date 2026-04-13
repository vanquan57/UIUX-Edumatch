import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum _TopUpMethod { bank, qr }

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  bool _isBalanceVisible = false;
  _TopUpMethod _selectedMethod = _TopUpMethod.bank;
  final TextEditingController _amountController = TextEditingController();
  
  // Fake data
  static const double _currentBalance = 750000;
  static const List<int> _quickAmounts = [50000, 100000, 200000, 500000, 1000000, 2000000];
  
  // Bank info
  static const String _bankName = 'Vietcombank (VCB)';
  static const String _bankAccount = '9901 2345 6789 0';
  static const String _bankOwner = 'CONG TY TNHH EDUMATCH';

  String _formatPrice(double price) {
    final str = price.toInt().toString();
    String result = '';
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) result += '.';
      result += str[i];
    }
    return '$result₫';
  }

  void _onQuickAmountTap(int amount) {
    _amountController.text = amount.toString();
  }

  void _onTopUp() {
    final amount = double.tryParse(_amountController.text.replaceAll('.', ''));
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập số tiền hợp lệ'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }
    
    // Show success dialog
    _showTopUpSuccessDialog(amount);
  }

  void _showTopUpSuccessDialog(double amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.successGreen,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Nạp tiền thành công',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.dividerColor,
              ),
            ),
          ],
        ),
        content: Text(
          'Bạn đã nạp thành công ${_formatPrice(amount)} vào ví EduMatch.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: AppColors.textGray,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _amountController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                'Đóng',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 24.h),
        _buildBalanceCard(),
        SizedBox(height: 24.h),
        _buildTopUpSection(),
        SizedBox(height: 32.h),
      ],
    );
  }

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
          'Ví EduMatch',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.accentGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số dư hiện tại',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white.withOpacity(0.9),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    _isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _isBalanceVisible ? _formatPrice(_currentBalance) : '***,***₫',
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildBalanceAction(
                  icon: Icons.add_circle_outline,
                  label: 'Nạp tiền',
                  onTap: () {
                    // Scroll to top up section
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildBalanceAction(
                  icon: Icons.history,
                  label: 'Lịch sử',
                  onTap: () => context.push(AppRouter.transactionHistory),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xác nhận đã nạp tiền',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 16.h),
        _buildAmountInput(),
        SizedBox(height: 16.h),
        _buildQuickAmounts(),
        SizedBox(height: 24.h),
        _buildPaymentMethods(),
        SizedBox(height: 24.h),
        _buildTopUpButton(),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số tiền muốn nạp',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Nhập số tiền',
            prefixText: '',
            suffixText: 'VND',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chọn nhanh',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _quickAmounts.map((amount) {
            return GestureDetector(
              onTap: () => _onQuickAmountTap(amount),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _formatPrice(amount.toDouble()),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hình thức nạp tiền',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildMethodTab(
                method: _TopUpMethod.bank,
                icon: Icons.account_balance,
                label: 'Chuyển khoản',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMethodTab(
                method: _TopUpMethod.qr,
                icon: Icons.qr_code_2,
                label: 'QR Code',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildPaymentDetail(),
      ],
    );
  }

  Widget _buildMethodTab({
    required _TopUpMethod method,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = method),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isSelected ? AppColors.white : AppColors.textGray,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetail() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedMethod == _TopUpMethod.bank
          ? _buildBankTransferDetail()
          : _buildQRCodeDetail(),
    );
  }

  Widget _buildBankTransferDetail() {
    return Container(
      key: const ValueKey('bank'),
      padding: EdgeInsets.all(16.w),
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
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF006B3E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.account_balance,
                    color: const Color(0xFF006B3E),
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                _bankName,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildBankInfoRow('Số tài khoản', _bankAccount, copyable: true),
          SizedBox(height: 12.h),
          _buildBankInfoRow('Chủ tài khoản', _bankOwner),
          SizedBox(height: 12.h),
          _buildBankInfoRow(
            'Nội dung chuyển khoản',
            'NAPVI [Số điện thoại của bạn]',
            copyable: true,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.warningOrange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.sp,
                  color: AppColors.warningOrange,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Vui lòng chuyển đúng nội dung để hệ thống tự động cộng tiền vào ví.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
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

  Widget _buildBankInfoRow(String label, String value, {bool copyable = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: AppColors.textGray,
            ),
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
            child: Icon(
              Icons.copy_outlined,
              size: 16.sp,
              color: AppColors.primaryGreen,
            ),
          ),
      ],
    );
  }

  Widget _buildQRCodeDetail() {
    final qrData = 'Bank=$_bankName|Account=$_bankAccount|Content=NAPVI';
    
    return Container(
      key: const ValueKey('qr'),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
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
                SizedBox(height: 12.h),
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
                    SizedBox(width: 6.w),
                    Text(
                      'VietQR',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
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
          _buildBankInfoRow('Ngân hàng', _bankName),
          SizedBox(height: 8.h),
          _buildBankInfoRow('Số tài khoản', _bankAccount, copyable: true),
          SizedBox(height: 8.h),
          _buildBankInfoRow('Nội dung', 'NAPVI [Số điện thoại]', copyable: true),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.warningOrange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.sp,
                  color: AppColors.warningOrange,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Quét mã QR bằng app ngân hàng để chuyển khoản nhanh chóng.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
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

  Widget _buildTopUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onTopUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'Xác nhận đã nạp tiền',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}