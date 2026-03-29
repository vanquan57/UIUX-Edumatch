import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/share/components/course_card.dart';
import 'package:edu_match/share/components/empty_state.dart';
import 'package:edu_match/share/components/online_tutor_item.dart';
import 'package:edu_match/share/components/quick_action_item.dart';
import 'package:edu_match/share/components/section_title.dart';
import 'package:edu_match/share/components/skeleton_loader.dart';
import 'package:edu_match/share/components/tutor_card.dart';
import 'package:edu_match/student/data/models/banner_model.dart';
import 'package:edu_match/student/data/models/course_model.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool _isLoadingRecommendations = false;
  bool _isLoadingFeaturedCourses = false;
  bool _isLoadingOnlineTutors = false;
  bool _isLoadingBanners = false;
  List<TutorModel> _recommendedTutors = [];
  List<CourseModel> _featuredCourses = [];
  List<TutorModel> _onlineTutors = [];
  List<BannerModel> _banners = [];
  late PageController _bannerPageController;
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController();
    _loadRecommendedTutors();
    _loadFeaturedCourses();
    _loadOnlineTutors();
    _loadBanners();
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  Future<void> _loadRecommendedTutors() async {
    setState(() => _isLoadingRecommendations = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _recommendedTutors = TutorModel.mockTutors();
      _isLoadingRecommendations = false;
    });
  }

  Future<void> _loadFeaturedCourses() async {
    setState(() => _isLoadingFeaturedCourses = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _featuredCourses = CourseModel.mockFeaturedCourses();
      _isLoadingFeaturedCourses = false;
    });
  }

  Future<void> _loadOnlineTutors() async {
    setState(() => _isLoadingOnlineTutors = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() {
      _onlineTutors = TutorModel.mockOnlineTutors();
      _isLoadingOnlineTutors = false;
    });
  }

  Future<void> _loadBanners() async {
    setState(() => _isLoadingBanners = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1300));

    setState(() {
      _banners = BannerModel.mockBanners();
      _isLoadingBanners = false;
    });

    // Auto slide carousel
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 4), () {
      if (_bannerPageController.hasClients && _banners.isNotEmpty) {
        int nextPage = (_currentBannerIndex + 1) % _banners.length;
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome banner
          _buildWelcomeBanner(),
          SizedBox(height: 8.h),

          // For You - Recommended Tutors Section
          _buildForYouSection(),
          SizedBox(height: 24.h),

          // Banner Promotions Section
          _buildBannerPromotionsSection(),
          SizedBox(height: 24.h),

          // Featured Courses Section
          _buildFeaturedCoursesSection(),
          SizedBox(height: 24.h),

          // Online Tutors Section
          _buildOnlineTutorsSection(),
          SizedBox(height: 24.h),

          // Quick Actions Section
          _buildQuickActionsSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Welcome Banner
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildWelcomeBanner() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryGreen, AppColors.primaryGreenDark],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Xin chào đến EduMatch!',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tìm gia sư phù hợp hoặc tham gia khóa học yêu thích',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // For You Section (Recommended Tutors)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildForYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Gia sư phù hợp với bạn',
          onViewAllPressed: () {
            context.go(AppRouter.marketplaceTutorList);
          },
        ),
        _isLoadingRecommendations
            ? _buildSkeletonList()
            : _recommendedTutors.isEmpty
            ? _buildEmptyTutorsState()
            : _buildTutorsList(),
      ],
    );
  }

  Widget _buildSkeletonList() {
    return SizedBox(
      height: 320.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: SizedBox(
            width: 200.w,
            child: const TutorCardSkeleton(),
          ),
        ),
      ),
    );
  }

  Widget _buildTutorsList() {
    return SizedBox(
      height: 320.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recommendedTutors.length,
        itemBuilder: (context, index) {
          final tutor = _recommendedTutors[index];
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: SizedBox(
              width: 200.w,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Xem hồ sơ ${tutor.name}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyTutorsState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: EmptyState(
        icon: Icons.person_search_rounded,
        title: 'Chưa có gia sư nào',
        subtitle: 'Hãy thử điều chỉnh bộ lọc hoặc tìm kiếm gia sư',
        ctaText: 'Tìm gia sư',
        onCtaPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tìm gia sư')));
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Featured Courses Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildFeaturedCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Khóa học nổi bật',
          onViewAllPressed: () {
            // Navigate to full courses list
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xem tất cả khóa học')),
            );
          },
        ),
        _isLoadingFeaturedCourses
            ? _buildFeaturedCoursesSkeletonList()
            : _featuredCourses.isEmpty
            ? _buildEmptyCoursesState()
            : _buildFeaturedCoursesList(),
      ],
    );
  }

  Widget _buildFeaturedCoursesSkeletonList() {
    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: const CourseCardSkeleton(),
        ),
      ),
    );
  }

  Widget _buildFeaturedCoursesList() {
    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _featuredCourses.length,
        itemBuilder: (context, index) {
          final course = _featuredCourses[index];
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CourseCard(
              id: course.id,
              title: course.title,
              instructorName: course.instructorName,
              thumbnail: course.thumbnail,
              rating: course.rating,
              reviewCount: course.reviewCount,
              price: course.price,
              badge: course.badge,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Xem chi tiết ${course.title}')),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCoursesState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: EmptyState(
        icon: Icons.video_library_rounded,
        title: 'Chưa có khóa học nào',
        subtitle: 'Hãy thử lại sau hoặc khám phá các khóa học khác',
        ctaText: 'Khám phá khóa học',
        onCtaPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Khám phá khóa học')));
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Online Tutors Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildOnlineTutorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Gia sư đang online (${_onlineTutors.length})',
          onViewAllPressed: () {
            context.go(AppRouter.marketplaceTutorList);
          },
        ),
        SizedBox(height: 12.h),
        _isLoadingOnlineTutors
            ? _buildOnlineTutorsSkeletonList()
            : _onlineTutors.isEmpty
            ? _buildEmptyOnlineTutorsState()
            : _buildOnlineTutorsList(),
      ],
    );
  }

  Widget _buildOnlineTutorsSkeletonList() {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 16.w, right: index == 3 ? 16.w : 0),
          child: const OnlineTutorItemSkeleton(),
        ),
      ),
    );
  }

  Widget _buildOnlineTutorsList() {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _onlineTutors.length,
        itemBuilder: (context, index) {
          final tutor = _onlineTutors[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == _onlineTutors.length - 1 ? 16.w : 10.w,
            ),
            child: OnlineTutorItem(
              id: tutor.id,
              name: tutor.name,
              avatar: tutor.avatar,
              onChatPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Chat với ${tutor.name}')),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyOnlineTutorsState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: EmptyState(
        icon: Icons.waving_hand_rounded,
        title: 'Chưa có gia sư nào online',
        subtitle: 'Vui lòng thử lại sau',
        ctaText: 'Quay lại',
        onCtaPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Quay lại')));
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Banner Promotions Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildBannerPromotionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Khuyến mãi & Sự kiện',
          onViewAllPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xem tất cả khuyến mãi')),
            );
          },
        ),
        SizedBox(height: 12.h),
        _isLoadingBanners
            ? _buildBannerSkeletonLoader()
            : _banners.isEmpty
            ? _buildEmptyBannersState()
            : _buildBannerCarousel(),
      ],
    );
  }

  Widget _buildBannerSkeletonLoader() {
    return Container(
      height: 160.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _bannerPageController,
            onPageChanged: (index) {
              setState(() => _currentBannerIndex = index);
              _startAutoSlide();
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return _buildBannerItem(banner);
            },
          ),
        ),
        SizedBox(height: 12.h),
        // Indicator dots
        _buildBannerIndicators(),
      ],
    );
  }

  Widget _buildBannerItem(BannerModel banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image with gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1C8659).withOpacity(0.8),
                  const Color(0xFF0D5A3F).withOpacity(0.9),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                banner.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1C8659).withOpacity(0.9),
                          const Color(0xFF0D5A3F).withOpacity(1),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Content overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
          // Badge
          if (banner.badge != null)
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.errorRed,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  banner.badge!,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          // Text content and CTA button
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 12.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        banner.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.85),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (banner.ctaText != null)
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${banner.ctaText} - ${banner.type}/${banner.targetId}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreenLight,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            banner.ctaText!,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerIndicators() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _banners.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: _currentBannerIndex == index ? 24.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: _currentBannerIndex == index
                  ? AppColors.primaryGreen
                  : Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyBannersState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: EmptyState(
        icon: Icons.local_offer_rounded,
        title: 'Chưa có khuyến mãi nào',
        subtitle: 'Hãy quay lại sau để cập nhật khuyến mãi mới',
        ctaText: 'Quay lại',
        onCtaPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Quay lại')));
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Quick Actions Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          children: [
            QuickActionItem(
              icon: Icons.search,
              label: 'Tìm gia sư',
              onTap: () => _navigateToTutorList(),
            ),
            QuickActionItem(
              icon: Icons.play_circle_outline,
              label: 'Học online',
              onTap: () => _navigateToCourseList(),
            ),
            QuickActionItem(
              icon: Icons.calendar_today,
              label: 'Lịch học',
              onTap: () => _navigateToSchedule(),
            ),
            QuickActionItem(
              icon: Icons.message_outlined,
              label: 'Tin nhắn',
              onTap: () => _navigateToMessages(),
            ),
            QuickActionItem(
              icon: Icons.favorite_border,
              label: 'Ưa thích',
              onTap: () => _navigateToFavorites(),
            ),
            QuickActionItem(
              icon: Icons.person,
              label: 'Hồ sơ',
              onTap: () => _navigateToProfile(),
            ),
            QuickActionItem(
              icon: Icons.assignment,
              label: 'Bài tập',
              onTap: () => _navigateToAssignments(),
            ),
            QuickActionItem(
              icon: Icons.assessment,
              label: 'Thống kê',
              onTap: () => _navigateToStatistics(),
            ),
            QuickActionItem(
              icon: Icons.settings,
              label: 'Cài đặt',
              onTap: () => _navigateToSettings(),
            ),
          ],
        ),
      ],
    );
  }

  // Navigation Methods
  void _navigateToTutorList() {
    context.go(AppRouter.marketplaceTutorList);
  }

  void _navigateToCourseList() {
    // TODO: Navigate to Course List page
    // context.go(AppRouter.courseList);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Course List')));
  }

  void _navigateToSchedule() {
    // TODO: Navigate to My Learning / Schedule page
    // context.go(AppRouter.myLearning);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Schedule')));
  }

  void _navigateToMessages() {
    // TODO: Navigate to Chat List page
    // context.go(AppRouter.chatList);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Messages')));
  }

  void _navigateToFavorites() {
    // TODO: Navigate to Favorites page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Favorites')));
  }

  void _navigateToProfile() {
    // TODO: Navigate to Profile page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Profile')));
  }

  void _navigateToAssignments() {
    // TODO: Navigate to Assignments page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Assignments')));
  }

  void _navigateToStatistics() {
    // TODO: Navigate to Statistics page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Statistics')));
  }

  void _navigateToSettings() {
    // TODO: Navigate to Settings page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Settings')));
  }
}
