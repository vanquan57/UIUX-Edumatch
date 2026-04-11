import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  final TextEditingController _searchController = TextEditingController();
  List<CourseModel> _allCourses = [];
  List<CourseModel> _filteredCourses = [];
  int _displayedCourseCount = 6; // Hiển thị 6 khóa học đầu tiên

  @override
  void initState() {
    super.initState();
    _loadMyCourses();
  }

  void _loadMyCourses() {
    // Giả lập danh sách khóa học đã mua (lấy 8 khóa học đầu tiên từ mock data)
    _allCourses = CourseModel.mockCourses().take(8).toList();
    _filteredCourses = _allCourses;
  }

  void _filterCourses(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCourses = _allCourses;
      } else {
        _filteredCourses = _allCourses
            .where((course) =>
                course.title.toLowerCase().contains(query.toLowerCase()) ||
                course.instructorName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      // Reset displayed count khi search
      _displayedCourseCount = 6;
    });
  }

  void _loadMoreCourses() {
    setState(() {
      _displayedCourseCount = _filteredCourses.length;
    });
  }

  int _calculateCourseProgress(CourseModel course) {
    // Tính tổng số bài học trong khóa học
    int totalLectures = 0;
    for (var section in course.courseSections) {
      totalLectures += section.lectures.length;
    }
    
    // Giả lập: 5 bài đầu tiên đã hoàn thành
    int completedLectures = totalLectures >= 5 ? 5 : totalLectures;
    
    if (totalLectures == 0) return 0;
    return ((completedLectures / totalLectures) * 100).round();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header với button back
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        SizedBox(height: 16.h),
        
        // Search input
        _buildSearchInput(),
        
        SizedBox(height: 20.h),
        
        // Course statistics
        _buildCourseStats(),
        
        SizedBox(height: 20.h),
        
        // Course list
        _buildCourseList(),
        
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
                return;
              }
              context.go(AppRouter.accountProfile);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Khóa học của tôi',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _filterCourses,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm khóa học...',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGray,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 20.sp,
              color: AppColors.textGray,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      _filterCourses('');
                    },
                    icon: Icon(
                      Icons.clear_rounded,
                      size: 20.sp,
                      color: AppColors.textGray,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseStats() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
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
            Expanded(
              child: _buildStatItem(
                icon: Icons.school_outlined,
                label: 'Tổng khóa học',
                value: '${_allCourses.length}',
                color: AppColors.primaryGreen,
              ),
            ),
            Container(
              width: 1,
              height: 40.h,
              color: AppColors.dividerColor,
            ),
            Expanded(
              child:               _buildStatItem(
                icon: Icons.play_circle_outline,
                label: 'Đang học',
                value: '${_allCourses.length}', // Tất cả khóa học đều đang học
                color: AppColors.warningOrange,
              ),
            ),
            Container(
              width: 1,
              height: 40.h,
              color: AppColors.dividerColor,
            ),
            Expanded(
              child:               _buildStatItem(
                icon: Icons.check_circle_outline,
                label: 'Hoàn thành',
                value: '0', // Chưa có khóa học nào hoàn thành 100%
                color: AppColors.successGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.sp,
          color: color,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCourseList() {
    if (_filteredCourses.isEmpty) {
      return _buildEmptyState();
    }

    final displayedCourses = _filteredCourses.take(_displayedCourseCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh sách khóa học (${_filteredCourses.length})',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              if (_searchController.text.isNotEmpty)
                Text(
                  'Tìm thấy ${_filteredCourses.length} kết quả',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
            ],
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Course grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: displayedCourses.length,
            itemBuilder: (context, index) {
              return _buildCourseCard(displayedCourses[index]);
            },
          ),
        ),
        
        // Load more button
        if (_displayedCourseCount < _filteredCourses.length) ...[
          SizedBox(height: 20.h),
          _buildLoadMoreButton(),
        ],
      ],
    );
  }

  Widget _buildCourseCard(CourseModel course) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.courseContent, extra: course);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course thumbnail
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                    ),
                    child: Image.asset(
                      course.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.bgLight,
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 40.sp,
                            color: AppColors.textGray,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Progress indicator
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  child: Text(
                    '${_calculateCourseProgress(course)}%',
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  ),
                ),
              ],
            ),
            
            // Course info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 4.h),
                    
                    Text(
                      course.instructorName,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const Spacer(),
                    
                    // Rating and continue button
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 12.sp,
                          color: AppColors.warningOrange,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          course.rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Xem',
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: _loadMoreCourses,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            side: const BorderSide(color: AppColors.primaryGreen),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Xem thêm ${_filteredCourses.length - _displayedCourseCount} khóa học',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGreen,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18.sp,
                color: AppColors.primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
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
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: AppColors.textLightGray,
            ),
            SizedBox(height: 16.h),
            Text(
              _searchController.text.isNotEmpty
                  ? 'Không tìm thấy khóa học'
                  : 'Chưa có khóa học nào',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _searchController.text.isNotEmpty
                  ? 'Thử tìm kiếm với từ khóa khác'
                  : 'Hãy mua khóa học đầu tiên của bạn',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textGray,
              ),
              textAlign: TextAlign.center,
            ),
            if (_searchController.text.isEmpty) ...[
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  context.go(AppRouter.courseList);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Khám phá khóa học',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}