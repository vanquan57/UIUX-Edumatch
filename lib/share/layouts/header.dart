import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/core/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  // Row 1 (56) + Row 2 nav (44) = 100
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  static const _navItems = [
    _NavItem('Tìm gia sư', '/marketplace/tutors'),
    _NavItem('Khóa học', '/courses'),
    _NavItem('Về chúng tôi', '/about-us'),
    _NavItem('Blog', '/blog'),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: UserSession.roleNotifier,
      builder: (context, role, _) {
        final isLoggedIn = role != null;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Row 1: Logo + Auth ──────────────────────────
                SizedBox(
                  height: 56,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        _Logo(),
                        const Spacer(),
                        if (isLoggedIn)
                          _LoggedInActions(role: role)
                        else
                          _GuestActions(),
                      ],
                    ),
                  ),
                ),
                // ── Row 2: Nav links ────────────────────────────
                Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.dividerColor),
                    ),
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _navItems.length,
                    separatorBuilder: (_, __) => SizedBox(width: 4.w),
                    itemBuilder: (context, i) {
                      return _NavChip(item: _navItems[i]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Logo ────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRouter.homeStudent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 32.w,
              height: 32.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Edu',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryGreen,
                  ),
                ),
                TextSpan(
                  text: 'Match',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryGreenLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Guest auth actions ───────────────────────────────────────────────────────

class _GuestActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => context.go(AppRouter.login),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          ),
          child: Text(
            'Đăng nhập',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
        SizedBox(width: 6.w),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryGreen, AppColors.accentGreen],
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            child: InkWell(
              onTap: () => context.go(AppRouter.register),
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                child: Text(
                  'Đăng ký',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Logged-in auth actions ───────────────────────────────────────────────────

class _LoggedInActions extends StatelessWidget {
  final String role;
  const _LoggedInActions({required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Notification icon
        _BadgeIconButton(
          icon: Icons.notifications_outlined,
          badgeCount: 3,
          onTap: () {},
        ),
        SizedBox(width: 4.w),
        // Chat icon
        _BadgeIconButton(
          icon: Icons.chat_bubble_outline_rounded,
          badgeCount: 1,
          onTap: () {},
        ),
        SizedBox(width: 8.w),
        // Avatar dropdown
        _AvatarDropdown(role: role),
      ],
    );
  }
}

// ─── Badge icon button ────────────────────────────────────────────────────────

class _BadgeIconButton extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  final VoidCallback onTap;

  const _BadgeIconButton({
    required this.icon,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(10.r),
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
                width: 16.w,
                height: 16.w,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: GoogleFonts.poppins(
                      fontSize: 9.sp,
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
}

// ─── Avatar dropdown ──────────────────────────────────────────────────────────

class _AvatarDropdown extends StatelessWidget {
  final String role;
  const _AvatarDropdown({required this.role});

  @override
  Widget build(BuildContext context) {
    final isParent = role == AppConstants.roleParent;

    return PopupMenuButton<_MenuAction>(
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      elevation: 8,
      color: AppColors.white,
      onSelected: (action) => _handleAction(context, action),
      itemBuilder: (context) => [
        _menuItem(
          _MenuAction.profile,
          Icons.person_outline_rounded,
          'Hồ sơ của tôi',
        ),
        _menuItem(
          _MenuAction.schedule,
          Icons.calendar_today_outlined,
          'Lịch học của tôi',
        ),
        _menuItem(
          _MenuAction.courses,
          Icons.menu_book_outlined,
          'Khóa học của tôi',
        ),
        _menuItem(
          _MenuAction.favorites,
          Icons.favorite_outline_rounded,
          'Yêu thích',
        ),
        if (isParent)
          _menuItem(
            _MenuAction.manageChildren,
            Icons.family_restroom_outlined,
            'Quản lý hồ sơ con',
          ),
        const PopupMenuDivider(),
        _menuItem(
          _MenuAction.logout,
          Icons.logout_rounded,
          'Đăng xuất',
          isDestructive: true,
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 17.r,
            backgroundImage:
                const AssetImage('assets/images/have_login.jpg'),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16.sp,
            color: AppColors.textGray,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_MenuAction> _menuItem(
    _MenuAction action,
    IconData icon,
    String label, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? AppColors.errorRed : AppColors.textDark;
    return PopupMenuItem<_MenuAction>(
      value: action,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, _MenuAction action) {
    switch (action) {
      case _MenuAction.logout:
        UserSession.logout();
        context.go(AppRouter.login);
        break;
      case _MenuAction.profile:
      case _MenuAction.schedule:
      case _MenuAction.courses:
      case _MenuAction.favorites:
      case _MenuAction.manageChildren:
        // TODO: navigate to respective pages
        break;
    }
  }
}

// ─── Nav chip ─────────────────────────────────────────────────────────────────

class _NavChip extends StatelessWidget {
  final _NavItem item;
  const _NavChip({required this.item});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = currentPath == item.path;

    return GestureDetector(
      onTap: () => context.go(item.path),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(
                    color: AppColors.primaryGreen,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Text(
          item.label,
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? AppColors.primaryGreen : AppColors.textGray,
          ),
        ),
      ),
    );
  }
}

// ─── Models ───────────────────────────────────────────────────────────────────

class _NavItem {
  final String label;
  final String path;
  const _NavItem(this.label, this.path);
}

enum _MenuAction {
  profile,
  schedule,
  courses,
  favorites,
  manageChildren,
  logout,
}
