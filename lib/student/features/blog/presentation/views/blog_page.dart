import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final PageController _sliderController;
  int _activeSlide = 0;

  final List<String> _feedbackImages = const [
    'assets/images/blog1.webp',
    'assets/images/blog2.webp',
    'assets/images/blog3.webp',
    'assets/images/blog4.webp',
  ];

  final List<_BlogStep> _learningSteps = const [
    _BlogStep(
      title: 'Đánh giá năng lực ban đầu',
      description:
          'Mỗi học viên được kiểm tra đầu vào để xác định trình độ hiện tại và phần kiến thức cần cải thiện. Từ đó, lộ trình học cá nhân hóa sẽ được thiết kế bám sát chương trình chuẩn.',
    ),
    _BlogStep(
      title: 'Xây dựng lộ trình học tập cá nhân',
      description:
          'Dựa trên mục tiêu và kết quả đánh giá, BIT thiết kế lộ trình Scaffolded Learning theo từng cấp độ để học viên phát triển toàn diện qua từng giai đoạn.',
    ),
    _BlogStep(
      title: 'Học và điều chỉnh liên tục',
      description:
          'Gia sư theo dõi tiến độ thường xuyên và cập nhật lộ trình kịp thời để ưu tiên phần kiến thức còn yếu trước khi chuyển sang nội dung mới.',
    ),
    _BlogStep(
      title: 'Kiểm tra và đánh giá định kỳ',
      description:
          'Sau mỗi buổi học, học sinh làm bài kiểm tra và nhận nhận xét trực tiếp từ gia sư để phụ huynh theo dõi tiến độ rõ ràng, đảm bảo đạt mục tiêu.',
    ),
  ];

  final List<_BlogStep> _scoreRoadmap = const [
    _BlogStep(
      title: 'Xây dựng kiến thức nền tảng',
      bullets: [
        'Trang bị vững chắc kiến thức nền tảng các môn học',
        'Sử dụng mindmap để hệ thống kiến thức tránh bỏ sót',
        'Tiếp cận tài liệu độc quyền từ BIT EDUCATION',
      ],
    ),
    _BlogStep(
      title: 'Bổ sung kiến thức nâng cao',
      bullets: [
        'Làm quen các dạng bài thi học kỳ đặc trưng',
        'Áp dụng kiến thức nâng cao để xử lý bài khó',
        'Tiếp cận nội dung dành cho mục tiêu 9 - 10',
      ],
    ),
    _BlogStep(
      title: 'Luyện đề thực chiến',
      bullets: [
        'Thực hành 20+ đề thi thử bám sát xu hướng ra đề',
        'Rèn kỹ năng làm bài và phân bổ thời gian',
        'Rèn kỹ năng kiểm lỗi trong phòng thi',
      ],
    ),
    _BlogStep(
      title: 'Thi thử và làm đề ngẫu nhiên',
      bullets: [
        'Làm đề từ ngân hàng đề thi tại BIT EDUCATION',
        'Bấm giờ mô phỏng áp lực như thi thật',
        'Phân tích kết quả và đưa ra hướng cải thiện điểm',
      ],
    ),
  ];

  final List<_BlogStep> _specialValues = const [
    _BlogStep(
      title: 'Lộ trình cá nhân hóa với Scaffolded Learning',
      description:
          'Lấy người học làm trung tâm, học sâu vào phần còn yếu trước khi chuyển sang kiến thức mới và phức tạp hơn.',
    ),
    _BlogStep(
      title: 'Báo cáo tiến độ chi tiết',
      bullets: [
        'Tổng hợp kiến thức đã nắm vững',
        'Chỉ rõ những phần cần cải thiện',
        'Phân tích điểm mạnh và định hướng tiếp theo',
      ],
    ),
    _BlogStep(
      title: 'Hỗ trợ ngoài giờ học',
      description:
          'Giải đáp thắc mắc nhanh chóng, cung cấp tài liệu bổ trợ và bài kiểm tra định kỳ để duy trì chất lượng học tập.',
    ),
    _BlogStep(
      title: 'Học thử miễn phí',
      description:
          'Trải nghiệm phương pháp học trước khi cam kết dài hạn để đánh giá mức độ phù hợp cho học viên.',
    ),
  ];

  final List<_BlogStep> _benefits = const [
    _BlogStep(
      title: 'Lộ trình học tập cá nhân hóa tại BIT',
      description:
          'Tập trung đúng phần kiến thức học viên còn yếu, từ đó tiến dần từ cơ bản đến nâng cao một cách vững chắc.',
    ),
    _BlogStep(
      title: 'Hỗ trợ học tập 24/7',
      description:
          'Hỗ trợ liên tục ngoài giờ học với giải đáp nhanh, tài liệu bổ trợ và kiểm tra định kỳ để duy trì tiến bộ.',
    ),
    _BlogStep(
      title: 'Báo cáo tiến độ đảm bảo tiến bộ từng ngày',
      bullets: [
        'Tổng hợp kiến thức đã nắm vững',
        'Xác định các điểm yếu cần cải thiện',
        'Phân tích điểm mạnh và lộ trình phát triển kế tiếp',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _sliderController = PageController(viewportFraction: 0.94);
  }

  @override
  void dispose() {
    _sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHero(),
        SizedBox(height: 28.h),
        _buildSectionTitle(
          title: 'Lộ Trình Học Cá Nhân Hóa',
          subtitle:
              'Trải nghiệm học tập theo phương pháp Scaffolded Learning với 4 quy trình rõ ràng.',
        ),
        SizedBox(height: 16.h),
        _buildStepGrid(_learningSteps),
        SizedBox(height: 32.h),
        _buildSectionTitle(
          title: 'Lộ Trình Để Con Đạt Điểm Cao',
          subtitle:
              'Thiết kế theo từng giai đoạn từ nền tảng đến thực chiến để tối ưu hiệu quả ôn luyện.',
        ),
        SizedBox(height: 16.h),
        _buildStepGrid(_scoreRoadmap),
        SizedBox(height: 32.h),
        _buildSectionTitle(
          title: 'Điểm Đặc Biệt Của BIT EDUCATION',
          subtitle:
              'Tập trung cá nhân hóa, theo dõi sát sao và hỗ trợ toàn diện cho học viên.',
        ),
        SizedBox(height: 16.h),
        _buildStepGrid(_specialValues),
        SizedBox(height: 32.h),
        _buildSectionTitle(
          title: 'Phụ Huynh - Học Sinh BIT Nói Gì',
          subtitle:
              'Cảm nhận thực tế từ học viên và phụ huynh qua những phản hồi trực quan.',
        ),
        SizedBox(height: 16.h),
        _buildImageSlider(),
        SizedBox(height: 32.h),
        _buildSectionTitle(
          title: 'Quyền Lợi Khi Học Tại BIT EDUCATION',
        ),
        SizedBox(height: 14.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            'assets/images/blog4_benefitwebp.webp',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20.h),
        _buildStepGrid(_benefits),
      ],
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BLOG GIÁO DỤC BIT',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.primaryGreenDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Phương pháp học cá nhân hóa giúp học viên tiến bộ bền vững',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle({required String title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: AppColors.textGray,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStepGrid(List<_BlogStep> items) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: isMobile ? 1.55 : 1.85,
      ),
      itemBuilder: (_, index) {
        final item = items[index];
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  '0${index + 1}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 8.h),
              if (item.description != null)
                Text(
                  item.description!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.6,
                    color: AppColors.textGray,
                  ),
                ),
              if (item.bullets.isNotEmpty) ...[
                for (final bullet in item.bullets)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Container(
                            width: 5.w,
                            height: 5.w,
                            decoration: const BoxDecoration(
                              color: AppColors.accentGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            bullet,
                            style: TextStyle(
                              fontSize: 13.sp,
                              height: 1.5,
                              color: AppColors.textGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        SizedBox(
          height: 290.h,
          child: PageView.builder(
            controller: _sliderController,
            itemCount: _feedbackImages.length,
            onPageChanged: (index) {
              setState(() => _activeSlide = index);
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    _feedbackImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _feedbackImages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _activeSlide == index ? 22.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: _activeSlide == index
                    ? AppColors.primaryGreen
                    : AppColors.borderColor,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BlogStep {
  final String title;
  final String? description;
  final List<String> bullets;

  const _BlogStep({
    required this.title,
    this.description,
    this.bullets = const [],
  });
}