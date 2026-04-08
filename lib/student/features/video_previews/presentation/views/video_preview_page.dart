import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/course_model.dart';

class VideoPreviewPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String courseName;
  final String instructorName;
  final String duration;

  const VideoPreviewPage({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.courseName,
    required this.instructorName,
    required this.duration,
  });

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.asset(widget.videoUrl);
    
    try {
      await _controller.initialize();
      setState(() {
        _isLoading = false;
      });
      
      _controller.addListener(() {
        if (mounted) {
          setState(() {
            _isPlaying = _controller.value.isPlaying;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể tải video: $e'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _showHideControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildVideoPlayer(),
            ),
            _buildVideoInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 8.w),
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.1),
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
              'Học thử miễn phí',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Miễn phí',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      color: AppColors.bgDark,
      child: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Đang tải video...',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            )
          : _controller.value.isInitialized
              ? GestureDetector(
                  onTap: _showHideControls,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      if (_showControls) _buildVideoControls(),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.white,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Không thể tải video',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Vui lòng thử lại sau',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          // Top controls
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Center play button
          GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.sp,
                color: AppColors.white,
              ),
            ),
          ),
          
          const Spacer(),
          
          // Bottom controls
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Progress bar
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: AppColors.primaryGreen,
                    bufferedColor: AppColors.textGray.withOpacity(0.3),
                    backgroundColor: AppColors.textGray.withOpacity(0.1),
                  ),
                ),
                SizedBox(height: 8.h),
                
                // Time and controls
                Row(
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      ' / ',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.white,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 24.sp,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.fullscreen,
                      size: 24.sp,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video title
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),
          
          // Course info
          Container(
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
                  'Thuộc khóa học',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.textGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.courseName,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 8.h),
                
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Giảng viên: ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.textGray,
                      ),
                    ),
                    Text(
                      widget.instructorName,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Thời lượng: ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.textGray,
                      ),
                    ),
                    Text(
                      widget.duration,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryGreen),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Quay lại',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to course payment page
                    // First, find the course to get the required data
                    final courses = CourseModel.mockCourses();
                    final course = courses.firstWhere(
                      (c) => c.title == widget.courseName,
                      orElse: () => courses.first,
                    );
                    
                    Navigator.pop(context);
                    context.push(
                      AppRouter.coursePayment,
                      extra: {
                        'courseId': course.id,
                        'courseTitle': course.title,
                        'coursePrice': course.price,
                        'instructorName': course.instructorName,
                      },
                    );
                  },
                  child: Container(
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
                          size: 18.sp,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Mua khóa học',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}