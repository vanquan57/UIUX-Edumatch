import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:edu_match/student/data/models/course_feedback_model.dart';

class CourseDetailsPage extends StatefulWidget {
  final String courseId;

  const CourseDetailsPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  late CourseModel course;
  bool isExpanded = false;
  int selectedTabIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Find course by ID from mock data
    course = CourseModel.mockCourses().firstWhere(
      (c) => c.id == widget.courseId,
      orElse: () => CourseModel.mockCourses().first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildCourseInfo(),
        _buildTabSection(),
        _buildTabContent(),
        _buildReviewsPreviewSection(),
        _buildRelatedTopicsSection(),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColors.textDark,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Chi tiết khóa học',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 24.sp,
              color: isFavorite ? AppColors.errorRed : AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category breadcrumb
          Row(
            children: [
              Text(
                course.category,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16.sp,
                color: AppColors.textGray,
              ),
              Text(
                course.subcategory,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          
          // Course title
          Text(
            course.title,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          SizedBox(height: 4.h),
          
          // Short description
          Text(
            course.shortDescription,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: AppColors.textGray,
            ),
          ),
          SizedBox(height: 8.h),
          
          // Badges
          Row(
            children: [
              if (course.badge.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: course.badge == 'Hot' ? AppColors.errorRed : AppColors.warningOrange,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    course.badge,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Xếp hạng cao nhất',
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Rating and stats
          Row(
            children: [
              Text(
                'Xếp hạng: ',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '${course.rating}/5',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          
          Row(
            children: [
              // Rating stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < course.rating.floor() ? Icons.star : Icons.star_border,
                    size: 16.sp,
                    color: AppColors.warningOrange,
                  );
                }),
              ),
              SizedBox(width: 8.w),
              Text(
                course.rating.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '(${course.reviewCount} xếp hạng)',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          
          Text(
            '${course.totalStudents} học viên',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 4.h),
          
          Row(
            children: [
              Text(
                'Được tạo bởi ',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                course.instructorName,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          
          Text(
            'Lần cập nhật gần đây nhất ${_formatDate(course.lastUpdated)}',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: AppColors.textGray,
            ),
          ),
          SizedBox(height: 4.h),
          
          Text(
            course.language,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    final tabs = ['Nội dung', 'Mô tả'];
    
    return Container(
      color: AppColors.white,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? AppColors.primaryGreen : AppColors.textGray,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      color: AppColors.bgLight,
      child: selectedTabIndex == 0 ? _buildContentTab() : _buildDescriptionTab(),
    );
  }

  Widget _buildContentTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // What you'll learn
          _buildWhatYouLearnSection(),
          SizedBox(height: 24.h),
          
          // Course includes
          _buildCourseIncludesSection(),
          SizedBox(height: 24.h),
          
          // Course content
          _buildCourseContentSection(),
        ],
      ),
    );
  }

  Widget _buildWhatYouLearnSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nội dung bài học',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Html(
            data: course.minidescription,
            style: {
              "body": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(14.sp),
                color: AppColors.textDark,
              ),
              "h3": Style(
                fontSize: FontSize(16.sp),
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                margin: Margins.only(bottom: 8.h),
              ),
              "ul": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.only(left: 16.w),
              ),
              "li": Style(
                fontSize: FontSize(14.sp),
                color: AppColors.textDark,
                margin: Margins.only(bottom: 4.h),
              ),
              "strong": Style(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGreen,
              ),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCourseIncludesSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Khóa học này bao gồm:',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          ...course.courseIncludes.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16.sp,
                  color: AppColors.primaryGreen,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCourseContentSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nội dung khóa học',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${course.courseSections.length} phần • ${course.totalLectures} bài giảng • ${course.totalHours} giờ ${(course.totalHours * 60 % 60).toInt()} phút tổng thời lượng',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...course.courseSections.map((section) => _buildSectionItem(section)),
        ],
      ),
    );
  }

  Widget _buildSectionItem(CourseSection section) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ExpansionTile(
        title: Text(
          section.title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Text(
          section.duration,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: AppColors.textGray,
          ),
        ),
        children: section.lectures.map((lecture) {
          
          return ListTile(
            leading: Icon(
              lecture.type == 'video' ? Icons.play_circle_outline : 
              lecture.type == 'article' ? Icons.article_outlined : Icons.quiz,
              size: 20.sp,
              color: AppColors.primaryGreen,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lecture.title,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: AppColors.textDark,
                  ),
                ),
                if (lecture.hasPreview && lecture.type == 'video')
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '/video-preview',
                          extra: {
                            'videoUrl': lecture.previewVideoUrl,
                            'title': lecture.title,
                            'courseName': course.title,
                            'instructorName': course.instructorName,
                            'duration': lecture.duration,
                          },
                        );
                      },
                      child: Text(
                        '▶ Học thử',
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGreen,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lecture.duration,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.textGray,
                  ),
                ),
                if (lecture.hasPreview)
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'Miễn phí',
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mô tả chi tiết',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12.h),
            Html(
              data: course.detailDescription,
              style: {
                "body": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(14.sp),
                  color: AppColors.textDark,
                ),
                "h3": Style(
                  fontSize: FontSize(16.sp),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  margin: Margins.only(top: 16.h, bottom: 8.h),
                ),
                "h4": Style(
                  fontSize: FontSize(15.sp),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                  margin: Margins.only(top: 12.h, bottom: 6.h),
                ),
                "p": Style(
                  fontSize: FontSize(14.sp),
                  color: AppColors.textDark,
                  margin: Margins.only(bottom: 8.h),
                ),
                "ul": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.only(left: 16.w),
                ),
                "li": Style(
                  fontSize: FontSize(14.sp),
                  color: AppColors.textDark,
                  margin: Margins.only(bottom: 4.h),
                ),
                "strong": Style(
                  fontWeight: FontWeight.w600,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsPreviewSection() {
    final reviews = CourseFeedbackModel.mockFeedbacksByCourseId(course.id);
    final previewReviews = reviews.take(3).toList(); // Show only first 3 reviews

    return Container(
      color: AppColors.bgLight,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        width: double.infinity,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đánh giá từ học viên',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(
                      AppRouter.courseFeedbackList.replaceFirst(':courseId', course.id),
                      extra: {
                        'courseName': course.title,
                        'courseRating': course.rating,
                      },
                    );
                  },
                  child: Text(
                    'Xem tất cả',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (previewReviews.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    'Chưa có đánh giá',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: previewReviews.map((review) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32.w,
                                      height: 32.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.borderColor),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          review.studentAvatar,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: AppColors.lightGreen,
                                              child: Icon(
                                                Icons.person_rounded,
                                                size: 16.sp,
                                                color: AppColors.primaryGreen,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.studentName,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          Text(
                                            review.date,
                                            style: GoogleFonts.poppins(
                                              fontSize: 11.sp,
                                              color: AppColors.textGray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star_rounded,
                                    size: 14.sp,
                                    color: index < review.rating
                                        ? AppColors.warningOrange
                                        : AppColors.borderColor,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            review.comment,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: AppColors.textDark,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTopicsSection() {
    return Container(
      color: AppColors.bgLight,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Khám phá các chủ đề liên quan',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: course.relatedCategories.map((category) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primaryGreen),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreen,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price section with details
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giá khóa học',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGray,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '₫${(course.price / 1000).toStringAsFixed(0)}.000',
                          style: GoogleFonts.poppins(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Truy cập vĩnh viễn',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                
                // Course benefits
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${course.totalHours} giờ video',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${course.totalLectures} bài giảng',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Giấy chứng nhận',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Hỗ trợ di động',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          
          // Buy now button
          GestureDetector(
            onTap: () {
              // Handle buy course
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Chuyển đến trang thanh toán khóa học: ${course.title}'),
                  backgroundColor: AppColors.primaryGreen,
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 20.sp,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Mua khóa học ngay',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          
          // Additional info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 16.sp,
                color: AppColors.textGray,
              ),
              SizedBox(width: 6.w),
              Text(
                'Thanh toán an toàn & bảo mật',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }
}