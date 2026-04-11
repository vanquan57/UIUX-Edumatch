import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/core/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header với button back
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        // Header với avatar và thông tin cá nhân
        _buildProfileHeader(context),
        
        SizedBox(height: 24.h),
        
        // Lịch sử section
        _buildHistorySection(context),
        
        SizedBox(height: 16.h),
        
        // Ví EduMatch section
        _buildWalletSection(),
        
        SizedBox(height: 16.h),
        
        // Tài khoản và bảo mật section
        _buildAccountSecuritySection(),
        
        SizedBox(height: 16.h),
        
        // Trung tâm trợ giúp section
        _buildHelpCenterSection(),
        
        SizedBox(height: 16.h),
        
        // Đăng xuất section
        _buildLogoutSection(context),
        
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
              context.go(AppRouter.homeStudent);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Tài khoản của tôi',
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

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.dividerColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 32.r,
                backgroundImage: const AssetImage('assets/images/have_login.jpg'),
              ),
              
              SizedBox(width: 16.w),
              
              // Tên và thông tin
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Văn An',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Học sinh',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Icons thông báo và tin nhắn
              Row(
                children: [
                  _buildIconButton(
                    icon: Icons.notifications_outlined,
                    badgeCount: 3,
                    onTap: () => context.go(AppRouter.notificationList),
                  ),
                  SizedBox(width: 12.w),
                  _buildIconButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    badgeCount: 1,
                    onTap: () => context.go(AppRouter.messengerChatList),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    int badgeCount = 0,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: AppColors.textDark,
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return _buildSection(
      title: 'Lịch sử',
      items: [
        _MenuItem(
          icon: Icons.school_outlined,
          title: 'Khóa học của tôi',
          subtitle: '5 khóa học',
          onTap: () => context.push(AppRouter.myCourses),
        ),
        _MenuItem(
          icon: Icons.calendar_today_outlined,
          title: 'Lịch học (Thời khóa biểu)',
          subtitle: '3 buổi học tuần này',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.person_outline_rounded,
          title: 'Gia sư đã đặt',
          subtitle: '2 gia sư',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildWalletSection() {
    return _buildSection(
      title: 'Ví EduMatch',
      items: [
        _MenuItem(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Số dư ví',
          subtitle: '500,000 VND',
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'Nạp tiền',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.history_outlined,
          title: 'Lịch sử giao dịch',
          subtitle: 'Xem tất cả giao dịch',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAccountSecuritySection() {
    return _buildSection(
      title: 'Tài khoản và bảo mật',
      items: [
        _MenuItem(
          icon: Icons.edit_outlined,
          title: 'Chỉnh sửa hồ sơ',
          subtitle: 'Cập nhật thông tin cá nhân',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.lock_outline_rounded,
          title: 'Đổi mật khẩu',
          subtitle: 'Bảo mật tài khoản',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Cài đặt riêng tư',
          subtitle: 'Quản lý quyền riêng tư',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildHelpCenterSection() {
    return _buildSection(
      title: 'Trung tâm trợ giúp',
      items: [
        _MenuItem(
          icon: Icons.help_outline_rounded,
          title: 'Câu hỏi thường gặp',
          subtitle: 'Tìm câu trả lời nhanh chóng',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.support_agent_outlined,
          title: 'Liên hệ hỗ trợ',
          subtitle: 'Chat với đội ngũ hỗ trợ',
          onTap: () {},
        ),
        _MenuItem(
          icon: Icons.feedback_outlined,
          title: 'Góp ý và phản hồi',
          subtitle: 'Giúp chúng tôi cải thiện',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () => _showLogoutDialog(context),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    size: 20.sp,
                    color: AppColors.errorRed,
                  ),
                ),
                
                SizedBox(width: 16.w),
                
                Expanded(
                  child: Text(
                    'Đăng xuất',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.errorRed,
                    ),
                  ),
                ),
                
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: AppColors.errorRed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_MenuItem> items,
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
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;
            
            return Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: item.onTap,
                    child: Padding(
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
                                if (item.subtitle != null) ...[
                                  SizedBox(height: 2.h),
                                  Text(
                                    item.subtitle!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textGray,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          if (item.trailing != null)
                            item.trailing!
                          else
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.sp,
                              color: AppColors.textLightGray,
                            ),
                        ],
                      ),
                    ),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Đăng xuất',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          content: Text(
            'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGray,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Hủy',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                UserSession.logout();
                context.go(AppRouter.login);
              },
              child: Text(
                'Đăng xuất',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.errorRed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}