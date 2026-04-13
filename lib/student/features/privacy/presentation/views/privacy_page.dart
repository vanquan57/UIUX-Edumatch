import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  // Fake data cho các tùy chọn quyền riêng tư
  bool _profileVisibility = true;
  bool _showOnlineStatus = false;
  bool _allowMessagesFromAnyone = true;
  bool _showLearningProgress = true;
  bool _allowNotifications = true;
  bool _allowEmailNotifications = false;
  bool _allowSMSNotifications = false;
  bool _shareDataForRecommendations = true;
  bool _allowLocationAccess = false;
  bool _showReviewsPublicly = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header với button back
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        SizedBox(height: 16.h),
        
        // Hiển thị hồ sơ section
        _buildProfileVisibilitySection(),
        
        SizedBox(height: 16.h),
        
        // Giao tiếp section
        _buildCommunicationSection(),
        
        SizedBox(height: 16.h),
        
        // Thông báo section
        _buildNotificationSection(),
        
        SizedBox(height: 16.h),
        
        // Dữ liệu và quyền riêng tư section
        _buildDataPrivacySection(),
        
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
              context.go(AppRouter.account);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Cài đặt riêng tư',
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

  Widget _buildProfileVisibilitySection() {
    return _buildSection(
      title: 'Hiển thị hồ sơ',
      description: 'Kiểm soát ai có thể xem thông tin của bạn',
      items: [
        _PrivacyItem(
          icon: Icons.visibility_outlined,
          title: 'Hồ sơ công khai',
          subtitle: 'Cho phép mọi người xem hồ sơ của bạn',
          value: _profileVisibility,
          onChanged: (value) => setState(() => _profileVisibility = value),
        ),
        _PrivacyItem(
          icon: Icons.circle_outlined,
          title: 'Hiển thị trạng thái online',
          subtitle: 'Gia sư có thể thấy khi bạn đang online',
          value: _showOnlineStatus,
          onChanged: (value) => setState(() => _showOnlineStatus = value),
        ),
        _PrivacyItem(
          icon: Icons.school_outlined,
          title: 'Hiển thị tiến độ học tập',
          subtitle: 'Cho phép gia sư xem tiến độ học của bạn',
          value: _showLearningProgress,
          onChanged: (value) => setState(() => _showLearningProgress = value),
        ),
      ],
    );
  }

  Widget _buildCommunicationSection() {
    return _buildSection(
      title: 'Giao tiếp',
      description: 'Quản lý cách mọi người có thể liên hệ với bạn',
      items: [
        _PrivacyItem(
          icon: Icons.message_outlined,
          title: 'Nhận tin nhắn từ mọi người',
          subtitle: 'Cho phép bất kỳ ai gửi tin nhắn cho bạn',
          value: _allowMessagesFromAnyone,
          onChanged: (value) => setState(() => _allowMessagesFromAnyone = value),
        ),
        _PrivacyItem(
          icon: Icons.star_outline_rounded,
          title: 'Hiển thị đánh giá công khai',
          subtitle: 'Đánh giá của bạn sẽ hiển thị cho mọi người',
          value: _showReviewsPublicly,
          onChanged: (value) => setState(() => _showReviewsPublicly = value),
        ),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return _buildSection(
      title: 'Thông báo',
      description: 'Chọn cách bạn muốn nhận thông báo',
      items: [
        _PrivacyItem(
          icon: Icons.notifications_outlined,
          title: 'Thông báo đẩy',
          subtitle: 'Nhận thông báo trên ứng dụng',
          value: _allowNotifications,
          onChanged: (value) => setState(() => _allowNotifications = value),
        ),
        _PrivacyItem(
          icon: Icons.email_outlined,
          title: 'Thông báo qua Email',
          subtitle: 'Nhận thông báo qua địa chỉ email',
          value: _allowEmailNotifications,
          onChanged: (value) => setState(() => _allowEmailNotifications = value),
        ),
        _PrivacyItem(
          icon: Icons.sms_outlined,
          title: 'Thông báo qua SMS',
          subtitle: 'Nhận thông báo qua tin nhắn điện thoại',
          value: _allowSMSNotifications,
          onChanged: (value) => setState(() => _allowSMSNotifications = value),
        ),
      ],
    );
  }

  Widget _buildDataPrivacySection() {
    return _buildSection(
      title: 'Dữ liệu và quyền riêng tư',
      description: 'Kiểm soát cách dữ liệu của bạn được sử dụng',
      items: [
        _PrivacyItem(
          icon: Icons.recommend_outlined,
          title: 'Chia sẻ dữ liệu để gợi ý',
          subtitle: 'Sử dụng dữ liệu học tập để đề xuất gia sư phù hợp',
          value: _shareDataForRecommendations,
          onChanged: (value) => setState(() => _shareDataForRecommendations = value),
        ),
        _PrivacyItem(
          icon: Icons.location_on_outlined,
          title: 'Truy cập vị trí',
          subtitle: 'Cho phép ứng dụng sử dụng vị trí của bạn',
          value: _allowLocationAccess,
          onChanged: (value) => setState(() => _allowLocationAccess = value),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<_PrivacyItem> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 8.h),
          
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;
            
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          item.icon,
                          size: 20.sp,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      
                      SizedBox(width: 16.w),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              item.subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(width: 12.w),
                      
                      // Custom Switch Toggle
                      _buildCustomSwitch(
                        value: item.value,
                        onChanged: item.onChanged,
                      ),
                    ],
                  ),
                ),
                
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.dividerColor,
                    indent: 72.w,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48.w,
        height: 28.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: value ? AppColors.primaryGreen : AppColors.disabledGray,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24.w,
            height: 24.h,
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrivacyItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PrivacyItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
}