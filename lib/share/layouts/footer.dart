import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiFooter(colors)
        : _buildFullFooter();
  }

  Widget _buildLowFiFooter(AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: colors.borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          // Logo section
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '[LOGO] EduMatch',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colors.textDark,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          
          // Links sections
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Liên kết',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ...['Tìm gia sư', 'Khóa học', 'Blog'].map((text) => 
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hỗ trợ',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ...['FAQ', 'Chính sách', 'Điều khoản'].map((text) => 
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Contact section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '[LIÊN HỆ & MẠNG XÃ HỘI]',
              style: TextStyle(
                fontSize: 9.sp,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.h),
          
          // Copyright
          Text(
            '© 2026 EduMatch',
            style: TextStyle(
              fontSize: 8.sp,
              color: colors.textLightGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFullFooter() {
    return Container(
      color: AppColors.bgDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Main content ────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // About section
                _AboutSection(),
                SizedBox(height: 28.h),
                _Divider(),
                SizedBox(height: 24.h),

                // Links grid (Quick Links + Support side by side)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _LinksSection(
                        title: 'Liên kết nhanh',
                        items: const [
                          _LinkItem('Tìm gia sư', '/find-tutor'),
                          _LinkItem('Khóa học', '/courses'),
                          _LinkItem('Blog', '/blog'),
                          _LinkItem('Về chúng tôi', '/about'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _LinksSection(
                        title: 'Hỗ trợ',
                        items: const [
                          _LinkItem('FAQ', '/faq'),
                          _LinkItem('Chính sách bảo mật', '/privacy'),
                          _LinkItem('Điều khoản sử dụng', '/terms'),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                _Divider(),
                SizedBox(height: 24.h),

                // Contact section
                _ContactSection(),
                SizedBox(height: 24.h),
                _Divider(),
                SizedBox(height: 24.h),

                // Social media
                _SocialSection(),
              ],
            ),
          ),

          // ── Bottom bar ──────────────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.25),
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
            child: Text(
              '© 2026 EduMatch. All rights reserved.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                color: Colors.white.withOpacity(0.45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── About section ────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo row
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/images/logo.jpg',
                width: 36.w,
                height: 36.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Edu',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryGreenLight,
                    ),
                  ),
                  TextSpan(
                    text: 'Match',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Nền tảng kết nối gia sư và học sinh\nhàng đầu Việt Nam.',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: Colors.white.withOpacity(0.6),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ─── Links section ────────────────────────────────────────────────────────────

class _LinksSection extends StatelessWidget {
  final String title;
  final List<_LinkItem> items;

  const _LinksSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 12.h),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: GestureDetector(
              onTap: () {}, // TODO: navigate
              child: Text(
                item.label,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Contact section ──────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  static const _contacts = [
    _ContactItem(Icons.email_outlined, 'contact@edumatch.vn',
        'mailto:contact@edumatch.vn'),
    _ContactItem(Icons.phone_outlined, '1800 1234', 'tel:18001234'),
    _ContactItem(Icons.location_on_outlined,
        '123 Nguyễn Huệ, Q.1, TP. Hồ Chí Minh', null),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liên hệ',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 12.h),
        ..._contacts.map(
          (c) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: GestureDetector(
              onTap: c.url != null ? () => _launch(c.url!) : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    c.icon,
                    size: 16.sp,
                    color: AppColors.accentGreen,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      c.label,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.white.withOpacity(0.6),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

// ─── Social section ───────────────────────────────────────────────────────────

class _SocialSection extends StatelessWidget {
  static const _socials = [
    _SocialItem('Facebook', Icons.facebook_rounded, 'https://facebook.com'),
    _SocialItem('Youtube', Icons.play_circle_outline_rounded,
        'https://youtube.com'),
    _SocialItem('LinkedIn', Icons.work_outline_rounded,
        'https://linkedin.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mạng xã hội',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 8.h,
          children: _socials.map((s) => _SocialButton(item: s)).toList(),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final _SocialItem item;
  const _SocialButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(item.url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, size: 16.sp, color: AppColors.accentGreen),
              SizedBox(width: 6.w),
              Text(
                item.label,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
    );
  }
}

// ─── Divider ──────────────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }
}

// ─── Models ───────────────────────────────────────────────────────────────────

class _LinkItem {
  final String label;
  final String path;
  const _LinkItem(this.label, this.path);
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String? url;
  const _ContactItem(this.icon, this.label, this.url);
}

class _SocialItem {
  final String label;
  final IconData icon;
  final String url;
  const _SocialItem(this.label, this.icon, this.url);
}
