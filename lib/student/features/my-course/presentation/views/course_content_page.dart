import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseContentPage extends StatefulWidget {
  final CourseModel course;
  
  const CourseContentPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  late List<bool> _completedLectures;

  @override
  void initState() {
    super.initState();
    _initializeCompletedLectures();
  }

  void _initializeCompletedLectures() {
    // Fake data: học theo thứ tự từ trên xuống dưới
    _completedLectures = [];
    int totalLectures = 0;
    
    // Đếm tổng số bài học
    for (var section in widget.course.courseSections) {
      totalLectures += section.lectures.length;
    }
    
    // Nếu khóa học đã hoàn thành, tất cả bài học đều đã hoàn thành
    // Nếu chưa hoàn thành, chỉ 5 bài đầu tiên đã hoàn thành
    for (int i = 0; i < totalLectures; i++) {
      if (widget.course.isCompleted) {
        _completedLectures.add(true); // Tất cả bài học đã hoàn thành
      } else {
        _completedLectures.add(i < 1); // Chỉ 1 bài đầu tiên được đánh dấu hoàn thành
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header với button back
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        SizedBox(height: 16.h),
        
        // Course info
        _buildCourseInfo(),
        
        SizedBox(height: 20.h),
        
        // Progress section
        _buildProgressSection(),
        
        SizedBox(height: 20.h),
        
        // Course content
        _buildCourseContent(),
        
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
                return;
              }
              context.go(AppRouter.myCourses);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Nội dung khóa học',
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

  Widget _buildCourseInfo() {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course.title,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16.sp,
                  color: AppColors.textGray,
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    widget.course.instructorName,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGray,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.star_rounded,
                  size: 16.sp,
                  color: AppColors.warningOrange,
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    '${widget.course.rating} (${widget.course.reviewCount} đánh giá)',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGray,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    final totalLectures = _completedLectures.length;
    final completedCount = _completedLectures.where((completed) => completed).length;
    final progressPercent = totalLectures > 0 ? (completedCount / totalLectures * 100) : 0;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiến độ học tập',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '${progressPercent.toInt()}%',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: progressPercent / 100,
              backgroundColor: AppColors.bgLight,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
              minHeight: 8.h,
            ),
            SizedBox(height: 8.h),
            Text(
              '$completedCount/$totalLectures bài học đã hoàn thành',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
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
          SizedBox(height: 12.h),
          ...widget.course.courseSections.map((section) => _buildSectionItem(section)),
        ],
      ),
    );
  }

  Widget _buildSectionItem(CourseSection section) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          section.title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          section.duration,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: AppColors.textGray,
          ),
        ),
        children: section.lectures.asMap().entries.map((entry) {
          final index = _getLectureGlobalIndex(section, entry.key);
          final lecture = entry.value;
          final isCompleted = index < _completedLectures.length ? _completedLectures[index] : false;
          // Debug: print('Lecture $index: ${lecture.title} - Completed: $isCompleted');
          
          return _buildLectureItem(lecture, isCompleted);
        }).toList(),
      ),
    );
  }

  int _getLectureGlobalIndex(CourseSection currentSection, int lectureIndex) {
    int globalIndex = 0;
    for (var section in widget.course.courseSections) {
      if (section == currentSection) {
        return globalIndex + lectureIndex;
      }
      globalIndex += section.lectures.length;
    }
    return globalIndex;
  }

  Widget _buildLectureItem(CourseLecture lecture, bool isCompleted) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Nếu là lecture nhận chứng chỉ, điều hướng đến certificate page
          if (lecture.isCertificate) {
            context.push(
              AppRouter.certificate,
              extra: {
                'studentName': 'Nguyễn Văn A', // TODO: Lấy từ user profile
                'courseTitle': widget.course.title,
                'instructorName': widget.course.instructorName,
                'completionDate': DateTime.now(),
              },
            );
          } else {
            // Điều hướng đến play video như bình thường
            context.push(
              AppRouter.playVideo,
              extra: {
                'videoUrl': lecture.previewVideoUrl ?? 'assets/videos/course1.mp4',
                'title': lecture.title,
                'courseName': widget.course.title,
                'instructorName': widget.course.instructorName,
                'duration': lecture.duration,
                'isVideoPreview': false,
              },
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Lecture type icon with completion status
              Stack(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? AppColors.primaryGreen.withOpacity(0.1)
                          : AppColors.bgLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      lecture.type == 'video' ? Icons.play_circle_outline : 
                      lecture.type == 'article' ? Icons.article_outlined : 
                      lecture.type == 'certificate' ? Icons.workspace_premium :
                      Icons.quiz,
                      size: 18.sp,
                      color: isCompleted ? AppColors.primaryGreen : AppColors.textGray,
                    ),
                  ),
                  if (isCompleted)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 8.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
              
              SizedBox(width: 12.w),
              
              // Lecture info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture.title,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isCompleted ? AppColors.textGray : AppColors.textDark,
                        // Loại bỏ gạch ngang, chỉ dùng màu để phân biệt
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    if (lecture.type == 'video') ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 12.sp,
                            color: AppColors.primaryGreen,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Xem video',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ] else if (lecture.type == 'certificate') ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            size: 12.sp,
                            color: AppColors.warningOrange,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Nhận chứng chỉ',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.warningOrange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Duration and status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    lecture.duration,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                  if (isCompleted) ...[
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'Hoàn thành',
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}