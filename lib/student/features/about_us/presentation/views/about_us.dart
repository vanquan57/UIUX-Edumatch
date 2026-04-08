import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Banner Section - full width, no padding
        _buildHeroBanner(context),
        
        SizedBox(height: 28.h),

        _buildTrialClassSection(),

        SizedBox(height: 40.h),

        _buildLearningMethodSection(),

        SizedBox(height: 32.h),
        
        // Company Info Section
        _buildCompanyInfoSection(),
        
        SizedBox(height: 40.h),
        
        // Leadership Section
        _buildLeadershipSection(),
        
        SizedBox(height: 40.h),
        
        // Business Fields Section
        _buildBusinessFieldsSection(),
        
        SizedBox(height: 40.h),
        
        // Values Section
        _buildValuesSection(),
        
        SizedBox(height: 40.h),
        
        // Mission & Vision Section
        _buildMissionVisionSection(),
        
        SizedBox(height: 40.h),
        
        // Staff Section
        _buildStaffSection(),
        
        SizedBox(height: 40.h),
        
        // Working Hours Section
        _buildWorkingHoursSection(),
        
        SizedBox(height: 40.h),
        
        // Contact Section
        _buildContactSection(),
        
        SizedBox(height: 60.h),
      ],
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      height: 280.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner_about_us.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.black.withOpacity(0.3),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Về chúng tôi',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Kết nối học sinh với những cơ hội giáo dục tốt nhất',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrialClassSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.accentGreen],
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đăng ký học thử miễn phí',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Trải nghiệm trước lộ trình học tập tại EduMatch để chọn đúng hình thức học phù hợp.',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white,
              height: 1.45,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              'PHƯƠNG PHÁP HỌC TIẾT KIỆM & HIỆU QUẢ',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryGreenDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Phương pháp học tiết kiệm & hiệu quả'),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildMethodCard(
                title: 'HỌC ONLINE',
                icon: Icons.computer,
                iconColor: AppColors.primaryGreen,
                items: const [
                  'Chủ động thời gian học tập, học theo lịch học sinh mong muốn',
                  'Không tốn thời gian di chuyển, chỉ cần máy tính và internet',
                  'Được lựa chọn giáo viên có thành tích tốt từ nhiều khu vực',
                  'Học phí vừa phải, nhiều ưu đãi nên chi phí thường thấp hơn',
                  'Có cam kết đầu ra theo lộ trình phù hợp',
                  'Hỗ trợ giải đáp thắc mắc ngoài giờ học',
                ],
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _buildMethodCard(
                title: 'HỌC OFFLINE',
                icon: Icons.school_outlined,
                iconColor: AppColors.warningOrange,
                items: const [
                  'Thường theo lịch cố định của trung tâm hoặc giáo viên',
                  'Tốn thời gian di chuyển, đưa đón mỗi buổi',
                  'Phạm vi lựa chọn giáo viên theo khu vực học',
                  'Học phí ổn định nhưng ít chương trình ưu đãi',
                  'Thường không có cam kết đầu ra rõ ràng',
                  'Bài tập phụ thuộc vào giáo viên, mức độ đa dạng thấp hơn',
                  'Giải đáp chủ yếu trong giờ học trực tiếp',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompanyInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin pháp nhân'),
        SizedBox(height: 16.h),
        _buildInfoCard([
          _buildInfoRow('Tên đầy đủ', 'Công ty TNHH Hệ thống gia sư trực tuyến (EduMatch)'),
          _buildInfoRow('Năm thành lập', '2026'),
          _buildInfoRow('Số DKKD', '03165830221'),
          _buildInfoRow('Giấy phép TVDH', '2026/QĐ-SGDĐT'),
          _buildInfoRow('Website', 'www.edumatch.online'),
        ]),
      ],
    );
  }

  Widget _buildLeadershipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Ban lãnh đạo'),
        SizedBox(height: 16.h),
        
        // CEO Section
        _buildLeaderCard(
          'Giám đốc công ty',
          'Ông Lê Văn A',
          [
            '16 năm giảng dạy môn Ngữ Văn, bậc trung học phổ thông',
            '01 năm dạy bán thời gian - Đại học Tổng hợp Hà Nội',
            '>23 năm kinh nghiệm điều hành công ty tư vấn du học, đào tạo ngoại ngữ',
            'Kinh nghiệm học tập dài hạn tại Australia',
            'Hiểu biết sâu sắc về hệ thống giáo dục của trên 20 nước',
          ],
        ),
        
        SizedBox(height: 20.h),
        
        // Deputy CEO Section
        _buildLeaderCard(
          'Phó Giám đốc',
          'Ông Lê Văn B',
          [
            'Cử nhân Anh Văn – Đại học Thương Mại Hà Nội, 2011',
            'Chứng chỉ coi thi của Pearson VUE, từ 2014 – nay',
            'Chứng chỉ Chuyên viên tư vấn du học Education New Zealand, 2015',
            '10 năm kinh nghiệm quản lý trung tâm khảo thí Pearson (PTE Academic)',
            '10 năm vị trí công tác Phó Giám Đốc công ty Đức Anh',
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Lĩnh vực hoạt động'),
        SizedBox(height: 16.h),
        Text(
          'EduMatch phát triển hệ sinh thái giáo dục kết hợp giữa nền tảng tìm gia sư và nền tảng e-learning, giúp học sinh linh hoạt lựa chọn mô hình học tập theo mục tiêu.',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textGray,
            height: 1.5,
          ),
        ),
        SizedBox(height: 20.h),
        
        _buildBusinessFieldCard(
          'Marketplace tìm gia sư',
          'Học sinh tìm kiếm, so sánh và đặt lịch học 1-1 theo môn học, khu vực, hình thức học, giá và đánh giá thực tế từ cộng đồng.',
          Icons.school,
        ),
        
        SizedBox(height: 16.h),
        
        _buildBusinessFieldCard(
          'Nền tảng khóa học online',
          'Cung cấp thư viện khóa học đa dạng với video, bài tập, quiz và theo dõi tiến độ học tập để học viên chủ động ôn luyện mọi lúc.',
          Icons.handshake,
        ),
        
        SizedBox(height: 16.h),
        
        _buildBusinessFieldCard(
          'Lớp học trực tuyến theo nhóm',
          'Tổ chức các buổi học live theo lịch, tăng tương tác giữa học viên với giáo viên và hỗ trợ xem lại nội dung khi cần.',
          Icons.language,
        ),
        
        SizedBox(height: 16.h),
        
        _buildBusinessFieldCard(
          'Quản lý học tập tập trung',
          'Học sinh quản lý lịch học, lớp đang theo học, khóa học đã mua và kết quả học tập trong một hệ thống thống nhất.',
          Icons.event,
        ),
      ],
    );
  }

  Widget _buildValuesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Tôn chỉ làm việc'),
        SizedBox(height: 16.h),
        Text(
          'Tại EduMatch, chúng tôi đặt chất lượng dịch vụ làm nền tảng cho mọi hoạt động, cam kết đồng hành cùng học sinh, sinh viên và đối tác bằng sự chuyên nghiệp, minh bạch và tận tâm.',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textGray,
            height: 1.5,
          ),
        ),
        SizedBox(height: 20.h),
        
        _buildValueCard(
          'Lấy học sinh làm trung tâm',
          'Thành công và lợi ích của học sinh, sinh viên là ưu tiên hàng đầu trong mọi quyết định và dịch vụ của chúng tôi.',
          Icons.person_pin,
        ),
        
        SizedBox(height: 12.h),
        
        _buildValueCard(
          'Chuyên nghiệp và tận tâm',
          'Đội ngũ chuyên gia giàu kinh nghiệm không ngừng nâng cao kiến thức, kỹ năng để cung cấp những tư vấn chính xác, hiệu quả và phù hợp nhất.',
          Icons.star,
        ),
        
        SizedBox(height: 12.h),
        
        _buildValueCard(
          'Minh bạch và trung thực',
          'Mọi quy trình tư vấn, tuyển sinh và hỗ trợ đều được thực hiện công khai, rõ ràng, đảm bảo quyền lợi cao nhất cho học sinh và phụ huynh.',
          Icons.verified,
        ),
        
        SizedBox(height: 12.h),
        
        _buildValueCard(
          'Hợp tác bền vững',
          'Chúng tôi luôn duy trì thái độ thân thiện, hợp tác và hỗ trợ tối đa cho khách hàng, đối tác, cũng như tuân thủ nghiêm túc các quy định pháp luật.',
          Icons.handshake_outlined,
        ),
        
        SizedBox(height: 12.h),
        
        _buildValueCard(
          'Sáng tạo và đổi mới',
          'Không ngừng cập nhật xu hướng giáo dục toàn cầu, tìm kiếm và phát triển các chương trình hợp tác mới để mở rộng cơ hội học tập và nghề nghiệp cho học sinh.',
          Icons.lightbulb,
        ),
      ],
    );
  }

  Widget _buildMissionVisionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sứ mệnh & Tầm nhìn'),
        SizedBox(height: 16.h),
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryGreen.withOpacity(0.1),
                AppColors.primaryGreenLight.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryGreen.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.rocket_launch,
                    color: AppColors.primaryGreen,
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Sứ mệnh',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Kết nối học sinh với gia sư chất lượng và nội dung học tập hiệu quả, mang đến giải pháp học tập linh hoạt từ 1-1 đến e-learning.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: 20.h),
              
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: AppColors.primaryGreen,
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Tầm nhìn',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Trở thành hệ sinh thái giáo dục số đáng tin cậy hàng đầu cho học sinh, phụ huynh và gia sư tại Việt Nam.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStaffSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Đội ngũ nhân viên'),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.groups,
                    color: AppColors.primaryGreen,
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '100% Cử nhân trở lên',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                '100% nhân viên của EduMatch đều có trình độ từ Cử nhân trở lên, đồng thời sở hữu các chứng chỉ nghiệp vụ theo yêu cầu của các cơ quan quản lý tại Việt Nam và các đối tác quốc tế.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Với niềm đam mê nghề nghiệp, kinh nghiệm dày dặn và tinh thần tận tâm, đội ngũ nhân sự của EduMatch luôn sẵn sàng hỗ trợ học sinh trên hành trình du học.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Giờ làm việc'),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.primaryGreen,
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Thời gian làm việc',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildWorkingHourRow('Thứ 2 - Thứ 7', '8:30 - 12:30 & 13:30 - 17:30'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.primaryGreen,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Hotline khẩn cấp: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '0936 000 000',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
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

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin liên hệ'),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryGreen,
                AppColors.primaryGreenLight,
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Công ty Education Match',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 16.h),
              _buildContactRow(Icons.location_on, '470 Trần Đại Nghĩa, P. Ngũ Hành Sơn, Tp. Đà Nẵng'),
              SizedBox(height: 12.h),
              _buildContactRow(Icons.phone, '0986 888 440'),
              SizedBox(height: 12.h),
              _buildContactRow(Icons.email, 'info@edumatch.online'),
              SizedBox(height: 12.h),
              _buildContactRow(Icons.web, 'www.edumatch.online'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textGray,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard(String position, String name, List<String> experiences) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryGreen,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    position,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: experiences.map((exp) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.only(top: 6.h, right: 8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      exp,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessFieldCard(String title, String description, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryGreen,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textGray,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(String title, String description, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.lightGreen.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primaryGreen,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textGray,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHourRow(String day, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: 18.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMethodCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      height: 550.h,
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
            children: [
              Icon(icon, color: iconColor, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 5.w,
                    height: 5.w,
                    margin: EdgeInsets.only(top: 7.h, right: 8.w),
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textGray,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}