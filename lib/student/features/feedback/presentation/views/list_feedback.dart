import 'package:edu_match/student/data/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/share/components/lowfi/lowfi_button.dart';
import 'package:edu_match/share/components/lowfi/lowfi_card.dart';

class FeedbackListPage extends StatefulWidget {
  final String tutorId;
  final String tutorName;
  final double tutorRating;

  const FeedbackListPage({
    super.key,
    required this.tutorId,
    required this.tutorName,
    required this.tutorRating,
  });

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  late List<FeedbackModel> allFeedbacks;
  late List<FeedbackModel> displayedFeedbacks;
  int itemsPerPage = 5;
  int currentPage = 1;
  bool isLoadingMore = false;
  
  // Filter states
  SentimentLabel? _selectedSentiment;
  int? _selectedRating;

  @override
  void initState() {
    super.initState();
    allFeedbacks = FeedbackModel.mockFeedbacksByTutorId(widget.tutorId);
    displayedFeedbacks = allFeedbacks.take(itemsPerPage).toList();
  }

  // Get filtered feedbacks based on selected filters
  List<FeedbackModel> _getFilteredFeedbacks() {
    var filtered = allFeedbacks;
    
    // Filter by sentiment
    if (_selectedSentiment != null) {
      filtered = filtered.where((f) => f.sentiment == _selectedSentiment).toList();
    }
    
    // Filter by rating
    if (_selectedRating != null) {
      filtered = filtered.where((f) => f.rating == _selectedRating).toList();
    }
    
    return filtered;
  }

  // Update displayed feedbacks when filter changes
  void _updateDisplayedFeedbacks() {
    setState(() {
      allFeedbacks = FeedbackModel.mockFeedbacksByTutorId(widget.tutorId);
      var filtered = _getFilteredFeedbacks();
      displayedFeedbacks = filtered.take(itemsPerPage).toList();
      currentPage = 1;
    });
  }

  void _showRatingFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppThemeConfig.colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lọc theo đánh giá',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppThemeConfig.colors.textDark,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close, size: 24.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      
                      // Rating options with scroll
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              _buildRatingOption(
                                label: 'Tất cả đánh giá',
                                value: null,
                                onTap: () => setState(() {
                                  this._selectedRating = null;
                                }),
                              ),
                              SizedBox(height: 12.h),
                              ...[5, 4, 3, 2, 1].map((int rating) {
                                return Column(
                                  children: [
                                    _buildRatingOption(
                                      label: '$rating ${_buildStarIcon(rating)}',
                                      value: rating,
                                      onTap: () => setState(() {
                                        this._selectedRating = rating;
                                      }),
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  this._selectedRating = null;
                                });
                                Navigator.pop(context);
                                _updateDisplayedFeedbacks();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppThemeConfig.colors.bgLight,
                                foregroundColor: AppThemeConfig.colors.textDark,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 0,
                              ),
                              child: Text('Bỏ lọc', style: GoogleFonts.roboto(fontSize: 14.sp)),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _updateDisplayedFeedbacks();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppThemeConfig.colors.primaryGreen,
                                foregroundColor: AppThemeConfig.colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 0,
                              ),
                              child: Text('Áp dụng', style: GoogleFonts.roboto(fontSize: 14.sp)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildRatingOption({
    required String label,
    required int? value,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedRating == value;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppThemeConfig.colors.white : AppThemeConfig.colors.textDark,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Radio<int?>(
              value: value,
              groupValue: _selectedRating,
              onChanged: (_) => onTap(),
              activeColor: AppThemeConfig.colors.white,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  String _buildStarIcon(int rating) {
    return '⭐' * rating;
  }

  void _loadMore() async {
    setState(() {
      isLoadingMore = true;
    });

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      currentPage++;
      final filtered = _getFilteredFeedbacks();
      final startIndex = (currentPage - 1) * itemsPerPage;
      final endIndex = startIndex + itemsPerPage;

      if (startIndex < filtered.length) {
        displayedFeedbacks.addAll(
          filtered.sublist(
            startIndex,
            endIndex > filtered.length ? filtered.length : endIndex,
          ),
        );
      }
      isLoadingMore = false;
    });
  }

  bool get hasMoreItems {
    final filtered = _getFilteredFeedbacks();
    return displayedFeedbacks.length < filtered.length;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(colors)
        : _buildFullLayout();
  }

  Widget _buildLowFiLayout(AppColorScheme colors) {
    final filteredFeedbacks = _getFilteredFeedbacks();
    final averageRating = FeedbackModel.calculateAverageRating(filteredFeedbacks);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Đánh giá của học viên',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 16.h),

          // Tutor info and rating
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[TUTOR RATING]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.tutorName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                    Text(
                      '${averageRating.toStringAsFixed(1)} ⭐',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${filteredFeedbacks.length} đánh giá',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Filters
          Text(
            'Lọc đánh giá',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSentiment = _selectedSentiment == SentimentLabel.positive 
                          ? null 
                          : SentimentLabel.positive;
                    });
                    _updateDisplayedFeedbacks();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedSentiment == SentimentLabel.positive ? colors.textDark : colors.borderColor,
                        width: _selectedSentiment == SentimentLabel.positive ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: _selectedSentiment == SentimentLabel.positive ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Tích cực',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSentiment = _selectedSentiment == SentimentLabel.neutral 
                          ? null 
                          : SentimentLabel.neutral;
                    });
                    _updateDisplayedFeedbacks();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedSentiment == SentimentLabel.neutral ? colors.textDark : colors.borderColor,
                        width: _selectedSentiment == SentimentLabel.neutral ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: _selectedSentiment == SentimentLabel.neutral ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Trung tính',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSentiment = _selectedSentiment == SentimentLabel.negative 
                          ? null 
                          : SentimentLabel.negative;
                    });
                    _updateDisplayedFeedbacks();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedSentiment == SentimentLabel.negative ? colors.textDark : colors.borderColor,
                        width: _selectedSentiment == SentimentLabel.negative ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: _selectedSentiment == SentimentLabel.negative ? colors.bgLight : colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Tiêu cực',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Feedback list
          Text(
            'Danh sách đánh giá',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          if (displayedFeedbacks.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  '[CHƯA CÓ ĐÁNH GIÁ]',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            )
          else
            ...displayedFeedbacks.map((feedback) => Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        feedback.studentName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textDark,
                        ),
                      ),
                      Text(
                        '${feedback.rating}⭐',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: colors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    feedback.comment,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: colors.textSecondary,
                    ),
                  ),
                  Text(
                    feedback.date,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: colors.textLightGray,
                    ),
                  ),
                ],
              ),
            )).toList(),

          // Load more button
          if (hasMoreItems)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: GestureDetector(
                onTap: isLoadingMore ? null : _loadMore,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.borderColor, width: 1.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: isLoadingMore
                        ? SizedBox(
                            height: 16.h,
                            width: 16.h,
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            '[XEM THÊM ĐÁNH GIÁ]',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colors.textSecondary,
                            ),
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFullLayout() {
    final filteredFeedbacks = _getFilteredFeedbacks();
    final averageRating = FeedbackModel.calculateAverageRating(filteredFeedbacks);
    final ratingDistribution =
        FeedbackModel.getRatingDistribution(filteredFeedbacks);
    final maxCount = ratingDistribution.values.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        // Header with back button
        Container(
          color: AppThemeConfig.colors.white,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppThemeConfig.colors.bgLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppThemeConfig.colors.textDark,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Đánh giá của học viên',
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeConfig.colors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Average rating section
        Container(
          color: AppThemeConfig.colors.white,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                // Tutor info and average rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tutorName,
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppThemeConfig.colors.textDark,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${filteredFeedbacks.length} đánh giá',
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            color: AppThemeConfig.colors.textGray,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: GoogleFonts.roboto(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppThemeConfig.colors.primaryGreen,
                          ),
                        ),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < averageRating.toInt()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppThemeConfig.colors.primaryGreen,
                                size: 16.sp,
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Rating breakdown bar chart
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phân bố đánh giá',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppThemeConfig.colors.textDark,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ...List.generate(5, (index) {
                      final rating = 5 - index;
                      final count = ratingDistribution[rating] ?? 0;
                      final percentage = maxCount > 0 ? (count / maxCount) * 100 : 0;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            // Star rating label
                            SizedBox(
                              width: 50.w,
                              child: Row(
                                children: [
                                  Text(
                                    '$rating',
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: AppThemeConfig.colors.textDark,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: AppThemeConfig.colors.primaryGreen,
                                    size: 14.sp,
                                  ),
                                ],
                              ),
                            ),
                            // Progress bar
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: Container(
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: AppThemeConfig.colors.dividerColor,
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: percentage / 100,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      color: AppThemeConfig.colors.primaryGreen,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            // Count
                            SizedBox(
                              width: 30.w,
                              child: Text(
                                '$count',
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeConfig.colors.textGray,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Filter buttons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // Row 1: Sentiment buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSentiment = _selectedSentiment == SentimentLabel.positive 
                              ? null 
                              : SentimentLabel.positive;
                        });
                        _updateDisplayedFeedbacks();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _selectedSentiment == SentimentLabel.positive 
                              ? AppThemeConfig.colors.primaryGreen 
                              : AppThemeConfig.colors.white,
                          border: Border.all(
                            color: _selectedSentiment == SentimentLabel.positive 
                                ? AppThemeConfig.colors.primaryGreen 
                                : AppThemeConfig.colors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '👍 Tích cực',
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: _selectedSentiment == SentimentLabel.positive
                                  ? AppThemeConfig.colors.white
                                  : AppThemeConfig.colors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSentiment = _selectedSentiment == SentimentLabel.neutral 
                              ? null 
                              : SentimentLabel.neutral;
                        });
                        _updateDisplayedFeedbacks();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _selectedSentiment == SentimentLabel.neutral 
                              ? AppThemeConfig.colors.primaryGreen 
                              : AppThemeConfig.colors.white,
                          border: Border.all(
                            color: _selectedSentiment == SentimentLabel.neutral 
                                ? AppThemeConfig.colors.primaryGreen 
                                : AppThemeConfig.colors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '😐 Trung tính',
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: _selectedSentiment == SentimentLabel.neutral
                                  ? AppThemeConfig.colors.white
                                  : AppThemeConfig.colors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSentiment = _selectedSentiment == SentimentLabel.negative 
                              ? null 
                              : SentimentLabel.negative;
                        });
                        _updateDisplayedFeedbacks();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _selectedSentiment == SentimentLabel.negative 
                              ? AppThemeConfig.colors.primaryGreen 
                              : AppThemeConfig.colors.white,
                          border: Border.all(
                            color: _selectedSentiment == SentimentLabel.negative 
                                ? AppThemeConfig.colors.primaryGreen 
                                : AppThemeConfig.colors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '👎 Tiêu cực',
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: _selectedSentiment == SentimentLabel.negative
                                  ? AppThemeConfig.colors.white
                                  : AppThemeConfig.colors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Row 2: Rating button
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _showRatingFilter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _selectedRating != null ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.white,
                          border: Border.all(
                            color: _selectedRating != null ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 18.sp,
                                color: _selectedRating != null ? AppThemeConfig.colors.white : AppThemeConfig.colors.textGray,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Lọc sao',
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedRating != null ? AppThemeConfig.colors.white : AppThemeConfig.colors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Review list
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (displayedFeedbacks.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Center(
                    child: Text(
                      'Chưa có đánh giá',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: AppThemeConfig.colors.textGray,
                      ),
                    ),
                  ),
                )
              else
                ...displayedFeedbacks.asMap().entries.map((entry) {
                  final feedback = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildFeedbackCard(feedback),
                  );
                }).toList(),
            ],
          ),
        ),

        // Load more button
        if (hasMoreItems)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 20.h),
            child: GestureDetector(
              onTap: isLoadingMore ? null : _loadMore,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppThemeConfig.colors.primaryGreen),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: isLoadingMore
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppThemeConfig.colors.primaryGreen,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Xem thêm đánh giá',
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppThemeConfig.colors.primaryGreen,
                          ),
                        ),
                ),
              ),
            ),
          ),

        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildFeedbackCard(FeedbackModel feedback) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        border: Border.all(color: AppThemeConfig.colors.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student info and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar and name
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppThemeConfig.colors.borderColor),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          feedback.studentAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppThemeConfig.colors.lightGreen,
                              child: Icon(
                                Icons.person_rounded,
                                size: 20.sp,
                                color: AppThemeConfig.colors.primaryGreen,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedback.studentName,
                            style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppThemeConfig.colors.textDark,
                            ),
                          ),
                          Text(
                            feedback.date,
                            style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              color: AppThemeConfig.colors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Star rating
              Row(
                children: [
                  ...List.generate(feedback.rating, (index) {
                    return Icon(
                      Icons.star,
                      color: AppThemeConfig.colors.primaryGreen,
                      size: 14.sp,
                    );
                  }),
                  ...List.generate(5 - feedback.rating, (index) {
                    return Icon(
                      Icons.star_border,
                      color: AppThemeConfig.colors.textLightGray,
                      size: 14.sp,
                    );
                  }),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Comment
          Text(
            feedback.comment,
            style: GoogleFonts.roboto(
              fontSize: 13.sp,
              color: AppThemeConfig.colors.textDark,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
