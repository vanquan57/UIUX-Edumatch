import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/share/components/course_list_view_card.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_match/core/router/app_router.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late List<CourseModel> _courses = [];
  late List<CourseModel> _allCourses = [];
  String _sortBy = 'popular'; // popular, priceAsc, ratingDesc
  final TextEditingController _searchController = TextEditingController();

  // Filter state
  final Set<String> _selectedCategories = {};
  RangeValues _priceRange = const RangeValues(100000, 500000);
  double _minRating = 0;
  String _selectedLanguage = 'Tất cả';
  String _selectedDuration = 'Tất cả'; // <1h, 1-2h, 1-3h, >3h
  bool? _hasSubtitles; // null = all, true = yes, false = no

  // Pagination state
  int _currentPage = 1;
  final int _itemsPerPage = 6;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCourses() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));
    
    setState(() {
      _allCourses = CourseModel.mockCourses();
      _calculateTotalPages();
      _applySort();
    });
  }

  void _calculateTotalPages() {
    _totalPages = (_allCourses.length / _itemsPerPage).ceil();
    if (_totalPages == 0) _totalPages = 1;
  }

  void _updateCurrentPage() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = (startIndex + _itemsPerPage).clamp(0, _allCourses.length);
    _courses = _allCourses.sublist(startIndex, endIndex);
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        _updateCurrentPage();
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _updateCurrentPage();
      });
    }
  }

  void _goToPage(int pageNumber) {
    if (pageNumber >= 1 && pageNumber <= _totalPages) {
      setState(() {
        _currentPage = pageNumber;
        _updateCurrentPage();
      });
    }
  }

  void _applySort() {
    switch (_sortBy) {
      case 'priceAsc':
        _allCourses.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'ratingDesc':
        _allCourses.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        _allCourses.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
        break;
      case 'popular':
      default:
        // Keep original order
        break;
    }
    _currentPage = 1;
    _calculateTotalPages();
    _updateCurrentPage();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => _buildFilterBottomSheet(setModalState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with search
          _buildHeader(),
          SizedBox(height: 16.h),

          // Sort options
          _buildSortOptions(),
          SizedBox(height: 16.h),

          // Course list
          if (_allCourses.isEmpty)
            Center(
                child: Text(
                  'Không tìm thấy khóa học',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: AppColors.textGray,
                  ),
                ),
            )
          else
            Column(
              children: [
                _buildCourseList(),
                SizedBox(height: 24.h),
                _buildPaginationControls(),
                SizedBox(height: 16.h),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return CourseListViewCard(
          id: course.id,
          title: course.title,
          instructorName: course.instructorName,
          thumbnail: course.thumbnail,
          rating: course.rating,
          reviewCount: course.reviewCount,
          price: course.price,
          badge: course.badge,
          lastUpdated: course.lastUpdated,
          totalHours: course.totalHours,
          totalLectures: course.totalLectures,
          onTap: () {
            context.push('/courses/${course.id}');
          },
          onViewDetails: () {
            context.push('/courses/${course.id}');
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Header with Search
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh sách khóa học',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgLight,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tên khóa học, giảng viên...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.textLightGray,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textGray,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: _showFilterBottomSheet,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.tune,
                  color: AppColors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Sort Options
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildSortOptions() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:         Row(
          children: [
            _buildSortButton('popular', 'Phổ biến'),
            SizedBox(width: 8.w),
            _buildSortButton('newest', 'Mới nhất'),
            SizedBox(width: 8.w),
            _buildSortButton('priceAsc', 'Giá: Thấp → Cao'),
            SizedBox(width: 8.w),
            _buildSortButton('ratingDesc', 'Đánh giá cao'),
          ],
        ),
    );
  }

  Widget _buildSortButton(String value, String label) {
    bool isSelected = _sortBy == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortBy = value;
          _applySort();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.bgLight,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.textGray,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Filter Bottom Sheet
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildFilterBottomSheet(StateSetter setModalState) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bộ lọc',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.textGray,
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Category Filter
              _buildFilterSection(
                title: 'Chủ đề',
                child: _buildCategoryFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Price Range Filter
              _buildFilterSection(
                title: 'Giá khóa học (₫)',
                child: _buildPriceRangeFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Rating Filter
              _buildFilterSection(
                title: 'Đánh giá tối thiểu',
                child: _buildRatingFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Duration Filter
              _buildFilterSection(
                title: 'Thời lượng',
                child: _buildDurationFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Language Filter
              _buildFilterSection(
                title: 'Ngôn ngữ',
                child: _buildLanguageFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Subtitles Filter
              _buildFilterSection(
                title: 'Phụ đề',
                child: _buildSubtitlesFilter(setModalState),
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setModalState(() {
                          _selectedCategories.clear();
                          _priceRange = const RangeValues(100000, 500000);
                          _minRating = 0;
                          _selectedLanguage = 'Tất cả';
                          _selectedDuration = 'Tất cả';
                          _hasSubtitles = null;
                        });
                        setState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Xóa bộ lọc')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.borderColor),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Xóa bộ lọc',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Áp dụng bộ lọc')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Áp dụng',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Pagination Controls
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildPaginationControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Page info
        Text(
          'Trang $_currentPage / $_totalPages',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 12.h),
        
        // Navigation Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button
            ElevatedButton.icon(
              onPressed: _currentPage > 1 ? _goToPreviousPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentPage > 1 
                    ? AppColors.primaryGreen 
                    : AppColors.textLightGray,
                disabledBackgroundColor: AppColors.borderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
              icon: Icon(Icons.chevron_left, size: 18.sp),
              label: Text(
                'Trước',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // Page Numbers
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _totalPages,
                    (index) {
                      int pageNum = index + 1;
                      bool isCurrentPage = pageNum == _currentPage;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: GestureDetector(
                          onTap: () => _goToPage(pageNum),
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: isCurrentPage 
                                  ? AppColors.primaryGreen 
                                  : AppColors.bgLight,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: isCurrentPage
                                    ? AppColors.primaryGreen
                                    : AppColors.borderColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                pageNum.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isCurrentPage
                                      ? Colors.white
                                      : AppColors.textGray,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // Next Button
            ElevatedButton.icon(
              onPressed: _currentPage < _totalPages ? _goToNextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentPage < _totalPages
                    ? AppColors.primaryGreen
                    : AppColors.textLightGray,
                disabledBackgroundColor: AppColors.borderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
              icon: Icon(Icons.chevron_right, size: 18.sp),
              label: Text(
                'Sau',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        child,
      ],
    );
  }

  Widget _buildCategoryFilter(StateSetter setModalState) {
    final categories = [
      'Công nghệ', 'Marketing', 'Sáng tạo nội dung', 
      'Phân tích dữ liệu', 'Toán học', 'Ngoại ngữ', 
      'Khoa học', 'Lập trình'
    ];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: categories.map((category) {
        bool isSelected = _selectedCategories.contains(category);
        return GestureDetector(
          onTap: () {
            setModalState(() {
              if (isSelected) {
                _selectedCategories.remove(category);
              } else {
                _selectedCategories.add(category);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.lightGreen : AppColors.bgLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
              ),
            ),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primaryGreen : AppColors.textGray,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRangeFilter(StateSetter setModalState) {
    return Column(
      children: [
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 1000000,
          activeColor: AppColors.primaryGreen,
          inactiveColor: AppColors.borderColor,
          onChanged: (RangeValues values) {
            setModalState(() {
              _priceRange = values;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₫${(_priceRange.start / 1000).toStringAsFixed(0)}k',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
              Text(
                '₫${(_priceRange.end / 1000).toStringAsFixed(0)}k',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingFilter(StateSetter setModalState) {
    return Row(
      children: List.generate(
        5,
        (index) {
          double starValue = (index + 1).toDouble();
          bool isSelected = _minRating >= starValue;
          return GestureDetector(
            onTap: () {
              setModalState(() {
                _minRating = isSelected ? starValue - 1 : starValue;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(
                isSelected ? Icons.star : Icons.star_border,
                color: AppColors.warningOrange,
                size: 24.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDurationFilter(StateSetter setModalState) {
    final durations = [
      {'label': 'Tất cả', 'value': 'Tất cả'},
      {'label': 'Dưới 1 giờ', 'value': '<1h'},
      {'label': '1-2 giờ', 'value': '1-2h'},
      {'label': '1-3 giờ', 'value': '1-3h'},
      {'label': 'Trên 3 giờ', 'value': '>3h'},
    ];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: durations.map((duration) {
        bool isSelected = _selectedDuration == duration['value'];
        return GestureDetector(
          onTap: () {
            setModalState(() {
              _selectedDuration = duration['value']!;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.lightGreen : AppColors.bgLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
              ),
            ),
            child: Text(
              duration['label']!,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primaryGreen : AppColors.textGray,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLanguageFilter(StateSetter setModalState) {
    final languages = ['Tất cả', 'Tiếng Việt', 'Tiếng Anh', 'Tiếng Trung', 'Tiếng Nhật'];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: languages.map((language) {
        bool isSelected = _selectedLanguage == language;
        return GestureDetector(
          onTap: () {
            setModalState(() {
              _selectedLanguage = language;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.lightGreen : AppColors.bgLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
              ),
            ),
            child: Text(
              language,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primaryGreen : AppColors.textGray,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubtitlesFilter(StateSetter setModalState) {
    return Column(
      children: [
        // Yes option
        RadioListTile<bool?>(
          value: true,
          groupValue: _hasSubtitles,
          onChanged: (value) {
            setModalState(() {
              _hasSubtitles = value;
            });
          },
          activeColor: AppColors.primaryGreen,
          title: Text(
            'Có',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        // No option
        RadioListTile<bool?>(
          value: false,
          groupValue: _hasSubtitles,
          onChanged: (value) {
            setModalState(() {
              _hasSubtitles = value;
            });
          },
          activeColor: AppColors.primaryGreen,
          title: Text(
            'Không',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        // All option
        RadioListTile<bool?>(
          value: null,
          groupValue: _hasSubtitles,
          onChanged: (value) {
            setModalState(() {
              _hasSubtitles = value;
            });
          },
          activeColor: AppColors.primaryGreen,
          title: Text(
            'Tất cả',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      ],
    );
  }
}
