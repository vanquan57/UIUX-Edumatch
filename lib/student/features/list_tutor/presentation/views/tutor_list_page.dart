import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/tutor_card.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  late List<TutorModel> _tutors = [];
  late List<TutorModel> _allTutors = [];
  String _sortBy = 'popular'; // popular, priceAsc, ratingDesc
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = true; // Toggle between grid and list view

  // Filter state
  final Set<String> _selectedSubjects = {};
  RangeValues _priceRange = const RangeValues(50000, 500000);
  double _minRating = 0;
  String _selectedLocation = 'Tất cả';

  // Pagination state
  int _currentPage = 1;
  final int _itemsPerPage = 6;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _loadTutors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTutors() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));
    
    setState(() {
      _allTutors = TutorModel.mockTutors();
      _calculateTotalPages();
      _applySort();
    });
  }

  void _calculateTotalPages() {
    _totalPages = (_allTutors.length / _itemsPerPage).ceil();
    if (_totalPages == 0) _totalPages = 1;
  }

  void _updateCurrentPage() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = (startIndex + _itemsPerPage).clamp(0, _allTutors.length);
    _tutors = _allTutors.sublist(startIndex, endIndex);
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
        _allTutors.sort((a, b) => (a.pricePerHour).compareTo(b.pricePerHour));
        break;
      case 'ratingDesc':
        _allTutors.sort((a, b) => (b.rating).compareTo(a.rating));
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

          // Tutor list
          if (_allTutors.isEmpty)
            Center(
                child: Text(
                  'Không tìm thấy gia sư',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: AppColors.textGray,
                  ),
                ),
            )
          else
            Column(
              children: [
                _isGridView 
                    ? _buildResponsiveTutorGrid()
                    : _buildListViewTutors(),
                SizedBox(height: 24.h),
                _buildPaginationControls(),
                SizedBox(height: 16.h),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildResponsiveTutorGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardWidth = 200.w; // TutorCard width
        final spacing = 12.w;
        
        // Calculate columns (minimum 2)
        int columns = ((screenWidth + spacing) / (cardWidth + spacing)).floor();
        columns = columns.clamp(2, 4);
        
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.6,
          children: List.generate(
            _tutors.length,
            (index) {
              final tutor = _tutors[index];
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100.w,
                  maxWidth: 250.w,
                ),
                child: TutorCard(
                  id: tutor.id,
                  name: tutor.name,
                  avatar: tutor.avatar,
                  rating: tutor.rating,
                  reviewCount: tutor.reviewCount,
                  pricePerHour: tutor.pricePerHour,
                  subjects: tutor.subjects,
                  isOnline: tutor.isOnline,
                  onViewProfile: () {
                    context.push(
                      AppRouter.marketplaceTutorDetails.replaceFirst(
                        ':tutorId',
                        tutor.id,
                      ),
                      extra: tutor,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildListViewTutors() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tutors.length,
      itemBuilder: (context, index) {
        final tutor = _tutors[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: GestureDetector(
            onTap: () {
              context.push(
                AppRouter.marketplaceTutorDetails.replaceFirst(
                  ':tutorId',
                  tutor.id,
                ),
                extra: tutor,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                    ),
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      color: AppColors.bgLight,
                      child: Image.asset(
                        tutor.avatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE8F5E9),
                            child: Center(
                              child: Icon(
                                Icons.person_rounded,
                                size: 40.sp,
                                color: const Color(0xFF1C8659),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Info
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Online badge
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  tutor.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (tutor.isOnline)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.successGreen,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    'Online',
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.warningOrange,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${tutor.rating} (${tutor.reviewCount} reviews)',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          // Price
                          Text(
                            '₫${(tutor.pricePerHour / 1000).toStringAsFixed(0)}k/h',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1C8659),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          // Subjects
                          Wrap(
                            spacing: 4.w,
                            runSpacing: 2.h,
                            children: tutor.subjects.take(3).map((subject) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  subject,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1C8659),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Action Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Xem hồ sơ ${tutor.name}'),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            child: Text(
                              'Xem\nhồ sơ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          'Tìm kiếm gia sư',
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
                    hintText: 'Tên gia sư, môn học...',
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
            // View Toggle Button
            GestureDetector(
              onTap: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _isGridView ? Icons.view_list : Icons.grid_view,
                  color: AppColors.white,
                  size: 22.sp,
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
        child: Row(
          children: [
            _buildSortButton('popular', 'Phổ biến'),
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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

              // Subject Filter
              _buildFilterSection(
                title: 'Môn học',
                child: _buildSubjectFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Price Range Filter
              _buildFilterSection(
                title: 'Giá tiếng (₫)',
                child: _buildPriceRangeFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Rating Filter
              _buildFilterSection(
                title: 'Đánh giá tối thiểu',
                child: _buildRatingFilter(setModalState),
              ),
              SizedBox(height: 20.h),

              // Location Filter
              _buildFilterSection(
                title: 'Địa điểm',
                child: _buildLocationFilter(setModalState),
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setModalState(() {
                          _selectedSubjects.clear();
                          _priceRange = const RangeValues(50000, 500000);
                          _minRating = 0;
                          _selectedLocation = 'Tất cả';
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
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
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

  Widget _buildSubjectFilter(StateSetter setModalState) {
    final subjects = ['Toán', 'Tiếng Anh', 'Lý', 'Hóa', 'Sinh', 'Sử'];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: subjects.map((subject) {
        bool isSelected = _selectedSubjects.contains(subject);
        return GestureDetector(
          onTap: () {
            setModalState(() {
              if (isSelected) {
                _selectedSubjects.remove(subject);
              } else {
                _selectedSubjects.add(subject);
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
              subject,
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

  Widget _buildLocationFilter(StateSetter setModalState) {
    final locations = ['Tất cả', 'Hà Nội', 'TP HCM', 'Đà Nẵng', 'Online'];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: locations.map((location) {
        bool isSelected = _selectedLocation == location;
        return GestureDetector(
          onTap: () {
            setModalState(() {
              _selectedLocation = location;
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
              location,
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
}
