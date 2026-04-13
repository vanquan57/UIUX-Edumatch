import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/student/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum _TimeFilter { all, today, week, month, threeMonths }

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  _TimeFilter _selectedFilter = _TimeFilter.all;
  List<TransactionModel> _displayedTransactions = [];
  int _currentPage = 1;
  static const int _itemsPerPage = 5;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    final filteredTransactions = _getFilteredTransactions();
    final startIndex = 0;
    final endIndex = (_currentPage * _itemsPerPage).clamp(0, filteredTransactions.length);
    
    setState(() {
      _displayedTransactions = filteredTransactions.sublist(startIndex, endIndex);
      _hasMoreData = endIndex < filteredTransactions.length;
    });
  }

  void _loadMoreTransactions() {
    final filteredTransactions = _getFilteredTransactions();
    final startIndex = _displayedTransactions.length;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, filteredTransactions.length);
    
    if (startIndex < filteredTransactions.length) {
      setState(() {
        _displayedTransactions.addAll(filteredTransactions.sublist(startIndex, endIndex));
        _hasMoreData = endIndex < filteredTransactions.length;
        _currentPage++;
      });
    }
  }

  List<TransactionModel> _getFilteredTransactions() {
    final now = DateTime.now();
    return kFakeTransactions.where((transaction) {
      switch (_selectedFilter) {
        case _TimeFilter.today:
          return transaction.createdAt.day == now.day &&
                 transaction.createdAt.month == now.month &&
                 transaction.createdAt.year == now.year;
        case _TimeFilter.week:
          final weekAgo = now.subtract(const Duration(days: 7));
          return transaction.createdAt.isAfter(weekAgo);
        case _TimeFilter.month:
          final monthAgo = now.subtract(const Duration(days: 30));
          return transaction.createdAt.isAfter(monthAgo);
        case _TimeFilter.threeMonths:
          final threeMonthsAgo = now.subtract(const Duration(days: 90));
          return transaction.createdAt.isAfter(threeMonthsAgo);
        case _TimeFilter.all:
          return true;
      }
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void _onFilterChanged(_TimeFilter filter) {
    setState(() {
      _selectedFilter = filter;
      _currentPage = 1;
    });
    _loadTransactions();
  }

  String _formatPrice(double price) {
    final str = price.abs().toInt().toString();
    String result = '';
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) result += '.';
      result += str[i];
    }
    return '${price < 0 ? '-' : '+'}$result₫';
  }

  String _getFilterLabel(_TimeFilter filter) {
    switch (filter) {
      case _TimeFilter.all:
        return 'Tất cả';
      case _TimeFilter.today:
        return 'Hôm nay';
      case _TimeFilter.week:
        return '7 ngày';
      case _TimeFilter.month:
        return '30 ngày';
      case _TimeFilter.threeMonths:
        return '3 tháng';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 20.h),
        _buildFilterSection(),
        SizedBox(height: 20.h),
        _buildTransactionList(),
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
          'Lịch sử giao dịch',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khoảng thời gian',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _TimeFilter.values.map((filter) {
              final isSelected = _selectedFilter == filter;
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () => _onFilterChanged(filter),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGreen : AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
                      ),
                    ),
                    child: Text(
                      _getFilterLabel(filter),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? AppColors.white : AppColors.textGray,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    if (_displayedTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giao dịch gần đây',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _displayedTransactions.length + (_hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _displayedTransactions.length) {
              return _buildLoadMoreButton();
            }
            return _buildTransactionItem(_displayedTransactions[index]);
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 300.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 40.sp,
                color: AppColors.textGray,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Chưa có giao dịch nào',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Các giao dịch của bạn sẽ hiển thị tại đây',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction) {
    final isIncome = transaction.amount > 0;
    final isTopup = transaction.type == 'topup';
    final isPayment = transaction.type == 'payment';
    
    IconData icon;
    Color iconColor;
    Color bgColor;
    
    if (isTopup) {
      icon = Icons.add_circle_outline;
      iconColor = AppColors.successGreen;
      bgColor = AppColors.successGreen.withOpacity(0.1);
    } else if (isPayment) {
      icon = Icons.remove_circle_outline;
      iconColor = AppColors.errorRed;
      bgColor = AppColors.errorRed.withOpacity(0.1);
    } else {
      icon = Icons.refresh;
      iconColor = AppColors.primaryGreen;
      bgColor = AppColors.primaryGreen.withOpacity(0.1);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('dd/MM/yyyy • HH:mm').format(transaction.createdAt),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: AppColors.textGray,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(transaction.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        _getStatusText(transaction.status),
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: _getStatusColor(transaction.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              _formatPrice(transaction.amount),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isIncome ? AppColors.successGreen : AppColors.errorRed,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: GestureDetector(
          onTap: _loadMoreTransactions,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.primaryGreen),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.expand_more,
                  color: AppColors.primaryGreen,
                  size: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Xem thêm',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return AppColors.successGreen;
      case 'pending':
        return AppColors.warningOrange;
      case 'failed':
        return AppColors.errorRed;
      default:
        return AppColors.textGray;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Thành công';
      case 'pending':
        return 'Đang xử lý';
      case 'failed':
        return 'Thất bại';
      default:
        return 'Không xác định';
    }
  }
}