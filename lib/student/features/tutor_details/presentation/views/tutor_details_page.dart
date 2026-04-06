import 'dart:math';

import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class TutorDetailsPage extends StatefulWidget {
  final String tutorId;

  const TutorDetailsPage({super.key, required this.tutorId});

  @override
  State<TutorDetailsPage> createState() => _TutorDetailsPageState();
}

class _TutorDetailsPageState extends State<TutorDetailsPage> {
  late TutorModel tutor;
  bool _isSaved = false;
  bool _isLoading = true;
  bool _extraDataFetched = false;
  late List<TutorModel> _nearbyTutorsCache;

  @override
  void initState() {
    super.initState();
    // Don't call context methods here - it's not available yet
    // Will be called in didChangeDependencies instead
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Try to get tutor from route extra only once
    if (!_extraDataFetched) {
      _extraDataFetched = true;
      _loadTutorDetails();
    }
  }

  Future<void> _loadTutorDetails() async {
    // Simulate loading for better UX
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        // Always use mock data for prototype
        final allTutors = TutorModel.mockTutors();
        final foundTutor = allTutors.firstWhere(
          (t) => t.id == widget.tutorId,
          orElse: () => allTutors.first, // Use first tutor as fallback
        );
        tutor = foundTutor;
        _nearbyTutorsCache = _generateNearbyTutors();
        _isLoading = false;
      });
    }
  }

  void _onSavePressed() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Đã lưu gia sư' : 'Đã bỏ lưu gia sư'),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _onSharePressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chia sẻ gia sư'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  void _onBookingPressed() {
    // Event: onClickBooking → navigate BookingFlow (no extra data needed for prototype)
    context.push(AppRouter.bookingLearningMethod);
  }

  void _onChatPressed() {
    // Event: onClickChat → open chat
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mở chat với gia sư'),
        duration: Duration(milliseconds: 1500),
      ),
    );
    // TODO: Open chat or navigate to chat screen
    // context.go(AppRouter.chatDetail, extra: tutor.id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colors.primaryGreen),
      );
    }

    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(context, colors)
        : _buildFullLayout();
  }

  Widget _buildLowFiLayout(BuildContext context, AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Chi tiết gia sư',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 16.h),

          // Tutor basic info
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
                  '[AVATAR]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  tutor.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                ),
                Text(
                  '${tutor.rating}⭐ (${tutor.reviewCount} đánh giá)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  '${tutor.pricePerHour.toInt()}₫/giờ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // About
          Text(
            'Giới thiệu',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              (tutor.bio?.isNotEmpty == true) ? tutor.bio! : '[GIỚI THIỆU GIA SƯ]',
              style: TextStyle(
                fontSize: 12.sp,
                color: (tutor.bio?.isNotEmpty == true) ? colors.textDark : colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Subjects
          Text(
            'Môn dạy',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              tutor.subjects.isNotEmpty ? tutor.subjects.join(', ') : '[MÔN DẠY]',
              style: TextStyle(
                fontSize: 12.sp,
                color: tutor.subjects.isNotEmpty ? colors.textDark : colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Experience
          Text(
            'Kinh nghiệm',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              tutor.experiences?.isNotEmpty == true 
                ? '${tutor.experiences!.length} vị trí kinh nghiệm'
                : 'Chưa có thông tin kinh nghiệm',
              style: TextStyle(
                fontSize: 12.sp,
                color: colors.textDark,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Reviews
          Text(
            'Đánh giá',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '[XEM TẤT CẢ ĐÁNH GIÁ]',
              style: TextStyle(
                fontSize: 12.sp,
                color: colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Availability
          Text(
            'Lịch rảnh',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '[LỊCH RẢNH CỦA GIA SƯ]',
              style: TextStyle(
                fontSize: 12.sp,
                color: colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Book button
          GestureDetector(
            onTap: () => _onBookingPressed(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.textDark, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
                color: colors.textDark,
              ),
              child: Center(
                child: Text(
                  'Đặt lịch học',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.white,
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
    return Stack(
      children: [
        // Main content
        SingleChildScrollView(
          child: Column(
            children: [
              // Header with back, avatar, rating, save/share
              _buildHeader(),

              // Body sections
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // About me
                    _buildAboutSection(),
                    SizedBox(height: 24.h),

                    // Experience
                    _buildExperienceSection(),
                    SizedBox(height: 24.h),

                    // Certificates
                    _buildCertificatesSection(),
                    SizedBox(height: 24.h),

                    // Subjects
                    _buildSubjectsSection(),
                    SizedBox(height: 24.h),

                    // Pricing
                    _buildPricingSection(),
                    SizedBox(height: 24.h),

                    // Reviews preview
                    _buildReviewsPreviewSection(),
                    SizedBox(height: 24.h),

                    // Availability preview
                    _buildAvailabilitySection(),
                    SizedBox(height: 24.h),

                    // Map View - Nearby Tutors
                    _buildMapView(),
                    SizedBox(height: 120.h), // Space for sticky footer
                  ],
                ),
              ),
            ],
          ),
        ),

        // Sticky footer
        Positioned(bottom: 0, left: 0, right: 0, child: _buildStickyFooter()),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Header Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: AppThemeConfig.colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Back button and actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _onSavePressed,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppThemeConfig.colors.bgLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            _isSaved ? Icons.favorite : Icons.favorite_border,
                            color: _isSaved
                                ? AppThemeConfig.colors.errorRed
                                : AppThemeConfig.colors.textGray,
                            size: 24.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: _onSharePressed,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppThemeConfig.colors.bgLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            color: AppThemeConfig.colors.textGray,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Avatar and basic info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppThemeConfig.colors.borderColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeConfig.colors.shadowColor,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        tutor.avatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppThemeConfig.colors.lightGreen,
                            child: Icon(
                              Icons.person_rounded,
                              size: 50.sp,
                              color: AppThemeConfig.colors.primaryGreen,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Name
                  Text(
                    tutor.name,
                    style: GoogleFonts.roboto(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeConfig.colors.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Online status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: tutor.isOnline
                          ? AppThemeConfig.colors.lightGreen
                          : AppThemeConfig.colors.bgLight,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      tutor.isOnline ? 'Đang hoạt động' : 'Không hoạt động',
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: tutor.isOnline
                            ? AppThemeConfig.colors.primaryGreen
                            : AppThemeConfig.colors.textGray,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Rating and reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${tutor.rating}',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppThemeConfig.colors.textDark,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '(${tutor.reviewCount} đánh giá)',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: AppThemeConfig.colors.textGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // About Me Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới thiệu',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppThemeConfig.colors.lightGreen,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppThemeConfig.colors.borderColor),
          ),
          child: Text(
            tutor.bio ?? 'Chưa có thông tin',
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
              color: AppThemeConfig.colors.textDark,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Experience Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildExperienceSection() {
    final experiences = tutor.experiences ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kinh nghiệm',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        if (experiences.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppThemeConfig.colors.borderColor),
              borderRadius: BorderRadius.circular(12.r),
              color: AppThemeConfig.colors.bgLight,
            ),
            child: Text(
              'Chưa có thông tin kinh nghiệm',
              style: GoogleFonts.roboto(
                fontSize: 12.sp,
                color: AppThemeConfig.colors.textGray,
              ),
            ),
          )
        else
          Column(
            children: experiences.map((exp) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppThemeConfig.colors.borderColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp.title,
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppThemeConfig.colors.textDark,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        exp.company,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: AppThemeConfig.colors.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        exp.duration,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: AppThemeConfig.colors.textGray,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        exp.description,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: AppThemeConfig.colors.textDark,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Certificates Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildCertificatesSection() {
    final certs = tutor.certifications ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chứng chỉ & Bằng cấp',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        if (certs.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'Chưa có chứng chỉ',
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  color: AppThemeConfig.colors.textGray,
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 190.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: certs.map((cert) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        _showCertificateDetailDialog(context, cert);
                      },
                      child: Container(
                        width: 140.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppThemeConfig.colors.borderColor,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Certificate background/image
                            if (cert.image != null && cert.image!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(11.r),
                                child: Image.asset(
                                  cert.image!,
                                  width: 140.w,
                                  height: 180.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Container(
                                width: 140.w,
                                height: 180.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.r),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppThemeConfig.colors.primaryGreen.withOpacity(0.3),
                                      AppThemeConfig.colors.lightGreen.withOpacity(0.2),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.card_giftcard,
                                    size: 40.sp,
                                    color: AppThemeConfig.colors.primaryGreen,
                                  ),
                                ),
                              ),
                            // Badge overlay
                            Positioned(
                              top: 8.w,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: AppThemeConfig.colors.primaryGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.verified,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Text overlay
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(11.r),
                                    bottomRight: Radius.circular(11.r),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      cert.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.2,
                                      ),
                                    ),
                                    if (cert.issuer != null &&
                                        cert.issuer!.isNotEmpty)
                                      Text(
                                        cert.issuer!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                          fontSize: 8.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Subjects Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildSubjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Môn học dạy',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: tutor.subjects.map((subject) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppThemeConfig.colors.primaryGreen,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                subject,
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeConfig.colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Pricing Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildPricingSection() {
    final pricingPlans = [
      {
        'type': 'Lẻ',
        'duration': 'Mỗi giờ',
        'price': '${(tutor.pricePerHour / 1000).toStringAsFixed(0)}k',
      },
      {
        'type': 'Gói 5 buổi',
        'duration': 'Tiết kiệm 5%',
        'price':
            '${((tutor.pricePerHour * 5 * 0.95) / 1000).toStringAsFixed(0)}k',
      },
      {
        'type': 'Gói 10 buổi',
        'duration': 'Tiết kiệm 10%',
        'price':
            '${((tutor.pricePerHour * 10 * 0.9) / 1000).toStringAsFixed(0)}k',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giá học',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 0.9,
          children: pricingPlans.map((plan) {
            return Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppThemeConfig.colors.borderColor),
                borderRadius: BorderRadius.circular(12.r),
                color: AppThemeConfig.colors.bgLight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    plan['type']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeConfig.colors.textDark,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    plan['price']!,
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeConfig.colors.primaryGreen,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    plan['duration']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 10.sp,
                      color: AppThemeConfig.colors.textGray,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Reviews Preview Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildReviewsPreviewSection() {
    final reviews = tutor.reviews ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Đánh giá từ học viên',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push(
                  AppRouter.feedbackList.replaceFirst(':tutorId', tutor.id),
                  extra: {'tutorName': tutor.name, 'tutorRating': tutor.rating},
                );
              },
              child: Text(
                'Xem tất cả',
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeConfig.colors.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (reviews.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'Chưa có đánh giá',
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  color: AppThemeConfig.colors.textGray,
                ),
              ),
            ),
          )
        else
          Column(
            children: reviews.map((review) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppThemeConfig.colors.borderColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review.name,
                            style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppThemeConfig.colors.textDark,
                            ),
                          ),
                          Text(
                            review.date,
                            style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              color: AppThemeConfig.colors.textGray,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: index < review.rating
                                ? Colors.amber
                                : AppThemeConfig.colors.borderColor,
                          );
                        }),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        review.text,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: AppThemeConfig.colors.textDark,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Availability Preview Section
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildAvailabilitySection() {
    final weekDays = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'CN',
    ];
    final availability = {
      'Thứ 2': true,
      'Thứ 3': true,
      'Thứ 4': true,
      'Thứ 5': true,
      'Thứ 6': true,
      'Thứ 7': false,
      'CN': false,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lịch học sẵn có',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppThemeConfig.colors.borderColor),
            borderRadius: BorderRadius.circular(12.r),
            color: AppThemeConfig.colors.bgLight,
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: weekDays.map((day) {
                  final isAvailable = availability[day] ?? false;
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppThemeConfig.colors.primaryGreen
                          : AppThemeConfig.colors.disabledGray,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      day,
                      style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: isAvailable
                            ? AppThemeConfig.colors.white
                            : AppThemeConfig.colors.textGray,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 12.h),
              Divider(color: AppThemeConfig.colors.borderColor),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giờ học:',
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppThemeConfig.colors.textDark,
                    ),
                  ),
                  Text(
                    '08:00 - 18:00',
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeConfig.colors.primaryGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Sticky Footer
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildStickyFooter() {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        border: Border(top: BorderSide(color: AppThemeConfig.colors.borderColor, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppThemeConfig.colors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h + 12.h),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _onChatPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeConfig.colors.bgLight,
                  foregroundColor: AppThemeConfig.colors.primaryGreen,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message_outlined, size: 20.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Nhắn tin',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: _onBookingPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeConfig.colors.primaryGreen,
                  foregroundColor: AppThemeConfig.colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 20.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Đặt lịch',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
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

  // ─────────────────────────────────────────────────────────────────────────────
  // Map View - Nearby Tutors
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildMapView() {
    final nearbyTutors = _getNearbyTutors();
    final centerLat = tutor.latitude;
    final centerLon = tutor.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gia sư gần đây',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppThemeConfig.colors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        // OpenStreetMap with tutors markers
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppThemeConfig.colors.borderColor),
          ),
          clipBehavior: Clip.hardEdge,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(centerLat, centerLon),
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              // OpenStreetMap TileLayer
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.edu_match',
              ),
              // Markers Layer
              MarkerLayer(
                markers: [
                  // Current tutor marker (center)
                  Marker(
                    point: LatLng(centerLat, centerLon),
                    width: 50.w,
                    height: 50.w,
                    child: Column(
                      children: [
                        Container(
                          width: 45.w,
                          height: 45.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppThemeConfig.colors.errorRed,
                            border: Border.all(
                              color: AppThemeConfig.colors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppThemeConfig.colors.errorRed.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.star,
                              color: AppThemeConfig.colors.white,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Nearby tutors markers
                  ...nearbyTutors.map((nearbyTutor) {
                    return Marker(
                      point: LatLng(
                        nearbyTutor.latitude,
                        nearbyTutor.longitude,
                      ),
                      width: 50.w,
                      height: 50.w,
                      child: GestureDetector(
                        onTap: () {
                          context.push(
                            AppRouter.marketplaceTutorDetails.replaceFirst(
                              ':tutorId',
                              nearbyTutor.id,
                            ),
                            extra: nearbyTutor,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppThemeConfig.colors.primaryGreen,
                                border: Border.all(
                                  color: AppThemeConfig.colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppThemeConfig.colors.primaryGreen.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: AppThemeConfig.colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Show nearby tutors count
        Text(
          'Tìm thấy ${nearbyTutors.length} gia sư gần đây',
          style: GoogleFonts.roboto(fontSize: 12.sp, color: AppThemeConfig.colors.textGray),
        ),
        SizedBox(height: 12.h),
        // Nearby tutors list
        if (nearbyTutors.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: nearbyTutors.map((nearbyTutor) {
                final distance = _calculateDistance(
                  centerLat,
                  centerLon,
                  nearbyTutor.latitude,
                  nearbyTutor.longitude,
                );
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        AppRouter.marketplaceTutorDetails.replaceFirst(
                          ':tutorId',
                          nearbyTutor.id,
                        ),
                        extra: nearbyTutor,
                      );
                    },
                    child: Container(
                      width: 140.w,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppThemeConfig.colors.borderColor),
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppThemeConfig.colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nearbyTutor.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppThemeConfig.colors.textDark,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 12.sp,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${nearbyTutor.rating}',
                                style: GoogleFonts.roboto(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12.sp,
                                color: AppThemeConfig.colors.primaryGreen,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${distance.toStringAsFixed(1)}km',
                                style: GoogleFonts.roboto(
                                  fontSize: 10.sp,
                                  color: AppThemeConfig.colors.textGray,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '${(nearbyTutor.pricePerHour / 1000).toStringAsFixed(0)}k/giờ',
                            style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: AppThemeConfig.colors.primaryGreen,
                            ),
                          ),
                        ],
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

  // Get Nearby Tutors - Lấy từ cache (tính 1 lần khi load)
  List<TutorModel> _getNearbyTutors() {
    return _nearbyTutorsCache;
  }

  // Generate nearby tutors once during load
  List<TutorModel> _generateNearbyTutors() {
    final allTutors = TutorModel.mockTutors();
    allTutors.shuffle();
    return allTutors.take(4).toList();
  }

  // Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371; // km
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);
    final a =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRad(double deg) => deg * (3.141592653589793 / 180);

  // ─────────────────────────────────────────────────────────────────────────────
  // Certificate Detail Dialog
  // ─────────────────────────────────────────────────────────────────────────────
  void _showCertificateDetailDialog(
    BuildContext context,
    CertificateModel cert,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: GestureDetector(
                onTap: () {}, // Prevent closing when tapping on dialog
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 400.w,
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Stack(
                      children: [
                        // Main content
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12.h),
                              // Certificate image
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child:
                                      cert.image != null &&
                                          cert.image!.isNotEmpty
                                      ? Image.asset(
                                          cert.image!,
                                          width: double.infinity,
                                          height: 280.h,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 280.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                AppThemeConfig.colors.primaryGreen
                                                    .withOpacity(0.3),
                                                AppThemeConfig.colors.lightGreen
                                                    .withOpacity(0.2),
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.card_giftcard,
                                              size: 60.sp,
                                              color: AppThemeConfig.colors.primaryGreen,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              // Certificate name
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  cert.name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppThemeConfig.colors.textDark,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              // Certificate issuer
                              if (cert.issuer != null &&
                                  cert.issuer!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppThemeConfig.colors.lightGreen,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          size: 16.sp,
                                          color: AppThemeConfig.colors.primaryGreen,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            cert.issuer!,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppThemeConfig.colors.primaryGreen,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: 24.h),
                              // Close button
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppThemeConfig.colors.primaryGreen,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Đóng',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                        // Close button (X button)
                        Positioned(
                          top: 8.w,
                          right: 8.w,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppThemeConfig.colors.bgLight,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                Icons.close,
                                size: 20.sp,
                                color: AppThemeConfig.colors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
