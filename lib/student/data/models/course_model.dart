class CourseSection {
  final String title;
  final String duration;
  final List<CourseLecture> lectures;

  CourseSection({
    required this.title,
    required this.duration,
    required this.lectures,
  });
}

class CourseLecture {
  final String title;
  final String duration;
  final String type; // "video", "article", "quiz", "certificate"
  final bool hasPreview; // Flag để check có học thử không
  final String? previewVideoUrl; // URL video học thử
  final bool isCertificate; // Flag để đánh dấu lecture nhận chứng chỉ

  CourseLecture({
    required this.title,
    required this.duration,
    required this.type,
    this.hasPreview = false,
    this.previewVideoUrl,
    this.isCertificate = false,
  });
}

class CourseModel {
  final String id;
  final String title;
  final String instructorName;
  final String thumbnail;
  final double rating;
  final int reviewCount;
  final double price;
  final String badge; // "Best Seller", "Hot", or empty
  final DateTime lastUpdated;
  final int totalHours;
  final int totalLectures;
  final String category;
  final String language;
  final bool hasSubtitles;
  final String level; // "Beginner", "Intermediate", "Advanced"

  // New fields for course details
  final String subcategory;
  final String shortDescription;
  final String minidescription; // HTML content
  final String detailDescription; // HTML content
  final int totalStudents;
  final List<String> whatYouWillLearn;
  final List<String> courseIncludes;
  final List<CourseSection> courseSections;
  final List<String> relatedCategories;
  final bool isCompleted; // Flag để đánh dấu khóa học đã hoàn thành

  CourseModel({
    required this.id,
    required this.title,
    required this.instructorName,
    required this.thumbnail,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.badge,
    required this.lastUpdated,
    required this.totalHours,
    required this.totalLectures,
    required this.category,
    required this.language,
    required this.hasSubtitles,
    required this.level,
    required this.subcategory,
    required this.shortDescription,
    required this.minidescription,
    required this.detailDescription,
    required this.totalStudents,
    required this.whatYouWillLearn,
    required this.courseIncludes,
    required this.courseSections,
    required this.relatedCategories,
    this.isCompleted = false,
  });

  /// Mock data for courses list
  static List<CourseModel> mockCourses() {
    return [
      CourseModel(
        id: '1',
        title: 'AWS Cloud for beginner (Vietnamese)',
        instructorName: 'Linh Nguyễn',
        thumbnail: 'assets/images/course1.jpg',
        rating: 4.7,
        reviewCount: 1239,
        price: 299000,
        badge: 'Best Seller',
        lastUpdated: DateTime(2026, 4, 1),
        totalHours: 30,
        totalLectures: 400,
        category: 'CNTT & Phần mềm',
        language: 'Tiếng Việt',
        hasSubtitles: true,
        level: 'Beginner',
        subcategory: 'Amazon AWS',
        shortDescription: 'AWS Cloud cho người mới bắt đầu (Tiếng Việt)',
        totalStudents: 5939,
        isCompleted: true, // Đánh dấu khóa học này đã hoàn thành
        whatYouWillLearn: [
          'Nắm vững các khái niệm về Cloud Computing & AWS',
          'Có kiến thức cơ bản về các dịch vụ AWS (Networking, Compute, Storage, Database, Container...)',
          'Tự tin tạo, cấu hình cũng như thao tác với các dịch vụ AWS thường dùng.',
          'Có khả năng tự thiết kế hệ thống trên AWS theo tiêu chuẩn Best Practice.',
          'Handson lab: tất cả các section đều có handson lab giúp bạn áp dụng kiến thức vào thực tế.',
          'Trang bị kiến thức cần thiết để chuẩn bị thi chứng chỉ SAA & DVA',
          'Final Assignment: Bài tập lớn giúp bạn làm quen với thiết kế & triển khai hệ thống trong dự án thực tế.',
        ],
        courseIncludes: [
          '30,5 giờ video theo yêu cầu',
          '2 bài kiểm tra thực hành',
          'Bài tập',
          '8 bài viết',
          '3 tài nguyên có thể tải xuống',
          'Truy cập trên thiết bị di động và TV',
          'Giấy chứng nhận hoàn thành',
        ],
        courseSections: [
          CourseSection(
            title: 'Giới thiệu',
            duration: '3:04',
            lectures: [
              CourseLecture(
                title: 'Hướng dẫn tải Source code & Slide của khoá học.',
                duration: '2:47',
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course1.mp4',
              ),
              CourseLecture(
                title: 'Download Slide + Code của khoá học.',
                duration: '0:23',
                type: 'article',
              ),
              CourseLecture(
                title: 'About me', 
                duration: '0:54', 
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course2.mp4',
              ),
              CourseLecture(
                title: 'Khoá học này dành cho ai? không dành cho ai?',
                duration: '1:51',
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course3.mp4',
              ),
              CourseLecture(
                title: 'Nội dung khoá học này bao gồm những gì?',
                duration: '1:49',
                type: 'video',
              ),
              CourseLecture(
                title: 'Mục tiêu sau khi kết thúc quá học.',
                duration: '0:30',
                type: 'video',
              ),
              CourseLecture(
                title: 'Lưu ý cho các bạn học viên',
                duration: '1:59',
                type: 'video',
              ),
              CourseLecture(
                title: 'Tương tác với giảng viên như thế nào?',
                duration: '2:58',
                type: 'video',
              ),
              CourseLecture(
                title: 'Lời nhắn dành cho các bạn học viên (QUAN TRỌNG)',
                duration: '4:36',
                type: 'video',
              ),
            ],
          ),
          CourseSection(
            title: 'EC2',
            duration: '2:00',
            lectures: [
              CourseLecture(
                title: 'EC2 Overview',
                duration: '1:00',
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course1.mp4',
              ),
              CourseLecture(
                title: 'Create EC2 Instance',
                duration: '1:00',
                type: 'video',
              ),
            ],
          ),
          CourseSection(
            title: 'EBS',
            duration: '3:04',
            lectures: [
              CourseLecture(
                title: 'EBS Overview',
                duration: '1:00',
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course2.mp4',
              ),
              CourseLecture(
                title: 'Create EBS Volume',
                duration: '1:00',
                type: 'video',
              ),
            ],
          ),
          CourseSection(
            title: 'Hoàn thành khóa học',
            duration: '0:30',
            lectures: [
              CourseLecture(
                title: 'Nhận chứng chỉ hoàn thành khóa học',
                duration: '0:30',
                type: 'certificate',
                isCertificate: true,
              ),
            ],
          ),
        ],
        relatedCategories: [
          'Cloud Computing',
          'DevOps',
          'Networking',
          'Database',
        ],
        minidescription: '''
          <div>
            <h3>Nội dung bài học</h3>
            <ul>
              <li><strong>Nắm vững các khái niệm về Cloud Computing & AWS</strong></li>
              <li><strong>Có kiến thức cơ bản về các dịch vụ AWS</strong> (Networking, Compute, Storage, Database, Container...)</li>
              <li><strong>Tự tin tạo, cấu hình</strong> cũng như thao tác với các dịch vụ AWS thường dùng.</li>
              <li><strong>Có khả năng tự thiết kế hệ thống trên AWS</strong> theo tiêu chuẩn Best Practice.</li>
              <li><strong>Handson lab:</strong> tất cả các section đều có handson lab giúp bạn áp dụng kiến thức vào thực tế.</li>
              <li><strong>Trang bị kiến thức cần thiết</strong> để chuẩn bị thi chứng chỉ SAA & DVA</li>
              <li><strong>Final Assignment:</strong> Bài tập lớn giúp bạn làm quen với thiết kế & triển khai hệ thống trong dự án thực tế.</li>
            </ul>
          </div>
        ''',
        detailDescription: '''
          <div>
            <h3>Yêu cầu</h3>
            <ul>
              <li>Có kiến thức cơ bản về IT & lập trình nói chung tuy nhiên không bắt buộc.</li>
              <li>Bạn không cần phải biết code vì tất cả code mẫu được cung cấp bởi giảng viên.</li>
              <li>Những bạn có kiến thức cơ bản về Server như Linux, Windows có khả năng sẽ học nhanh hơn.</li>
            </ul>

            <h3>Mô tả</h3>
            <p><strong>Chào mừng đến với khoá học AWS Cloud for beginner - Tiếng Việt!</strong></p>

            <h4>GIỚI THIỆU GIẢNG VIÊN</h4>
            <p>Hiện đang là AWS Cloud Solution Architect, Engineering Consultant chuyên phụ trách các dự án liên quan tới Cloud & AWS.</p>
            
            <p>Làm việc với Cloud & AWS từ năm 2015 với vai trò Cloud Engineer và từ 2018 với vai trò Cloud Solution Architect.</p>
            
            <p>Có kinh nghiệm thực chiến trong việc tư vấn, thiết kế và triển khai các hệ thống lớn quy mô hàng triệu user trên toàn thế giới. Chịu trách nhiệm cao nhất về kiến trúc cũng như giải pháp cho các dự án, đảm bảo hệ thống được thiết kế, xây dựng và release tới khách hàng và end-user với chất lượng cao nhất.</p>

            <h4>Chứng chỉ AWS hiện có:</h4>
            <ul>
              <li>AWS Certified Developer Associate (2016)</li>
              <li>AWS Certified Solution Architect Associate (2018)</li>
              <li>AWS Certified Solution Architect Professional (2020, renew 2023)</li>
              <li>AWS Certified DevOps Engineer Professional (2024)</li>
            </ul>
            
            <p><strong>Other:</strong> Thành viên của AWS Community Builder (năm thứ 3 liên tiếp), cộng đồng cho những nhà sáng tạo nội dung liên quan tới AWS trên toàn thế giới.</p>

            <h4>Về khoá học AWS Cloud for beginner - Tiếng Việt</h4>
            <p>Bạn đang là IT, Software Engineer hoặc sinh viên đang muốn bắt đầu hành trình trên Cloud của mình, hoặc bạn muốn học thêm những kiến thức liên quan AWS nói riêng phục vụ cho công việc hằng ngày cũng như tìm kiếm cơ hội mới. Khoá học này chính xác dành cho bạn!</p>
            
            <p>Khoá học này tập trung vào những kiến thức cơ bản liên quan tới Cloud Computing và AWS, lịch sử hình thành và phát triển của AWS, các dịch vụ cơ bản trên AWS, đặc trưng và usecase áp dụng các dịch vụ trong thực tế.</p>
            
            <p>Khoá học thiết kế đan xen giữa lý thuyết và thực hành, giúp các bạn không chỉ nắm rõ các dịch vụ của AWS mà còn tự tin thao tác, có thể vận dụng trong dự án thực tế cũng như phát triển sản phẩm của riêng bạn.</p>

            <h4>Sau khoá học này bạn sẽ tự tin làm việc với các dịch vụ:</h4>
            <ul>
              <li>Networking (VPC, Subnet, Security Group, Route53, CloudFront,...)</li>
              <li>Computing (EC2, Lambda, LoadBalancer)</li>
              <li>Database (SQL and No SQL)</li>
              <li>Storage (S3, EBS, EFS)</li>
              <li>Security (Identity & Access Manager, Security concepts, Encryption, Application Protection)</li>
              <li>Monitoring and Auditing (CloudWatch, CloudTrail)</li>
              <li>Container (Docker), ECR, ECS</li>
              <li>Messaging Services (SNS, SQS, SES)</li>
              <li>Infra as Code (basic)</li>
              <li>Backup and Recovery</li>
            </ul>
            
            <p>Không chỉ vậy, bạn còn được hướng dẫn cách tạo ra các mô hình thiết kế hệ thống kết hợp các dịch vụ đã học. Thiết kế và xây dựng hệ thống theo các Best Practice của AWS như tự động scale theo workload của người dùng, auto recovery khi có sự cố, High Availability, Security, Monitoring.</p>
            
            <p><strong>Đặc biệt:</strong> cuối khoá học mình có chuẩn bị 2 bài tập lớn (Final Assignment) để các bạn luyện tập thiết kế & triển khai hệ thống lên AWS. Các bạn có thể thực hành sau đó submit kết quả & mình sẽ nhận xét.</p>
            
            <p>Khoá học này không yêu cầu bất kỳ kinh nghiệm sẵn có nào tuy nhiên bạn sẽ gặp chút khó khăn nếu không phải là người học về IT/Software hoặc là người đang đi làm (ví dụ bạn học trái ngành và sang làm IT/Software chưa đủ lâu).</p>
            
            <p>Các bài lab đều được hướng dẫn kỹ step-by-step, chỉ cần bạn chịu khó là có thể hoàn thành.</p>
            
            <p>Chúc các bạn có thể gặt hái được nhiều kiến thức bổ ích qua khoá học này.</p>
            
            <p><strong>Thân ái - Linh Nguyễn.</strong></p>

            <h4>LIÊN LẠC VỚI GIẢNG VIÊN</h4>
            <p>Các bạn có thể sử dụng tính năng Q&A của Udemy, mình sẽ thường xuyên check và trả lời các comment cũng như update video khi bị outdate. Ngoài ra mình cũng có một group FB riêng hỗ trợ technical cho các bạn có mua khóa học của mình trong suốt quá trình học tập, check tin nhắn tự động sau khi mua khoá trên Udemy để request vào nhóm nhé.</p>
          </div>
        ''',
      ),
      CourseModel(
        id: '2',
        title:
            'Social Media Marketing Fundamentals - Nắm Vững Cách Làm Marketing',
        instructorName: 'Khoa Học Marketing',
        thumbnail: 'assets/images/course2.jpg',
        rating: 4.9,
        reviewCount: 512,
        price: 249000,
        badge: 'Hot',
        lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
        totalHours: 8,
        totalLectures: 32,
        category: 'Marketing',
        language: 'Tiếng Việt',
        hasSubtitles: true,
        level: 'Beginner',
        subcategory: 'Digital Marketing',
        shortDescription: 'Khóa học Marketing cơ bản',
        totalStudents: 1200,
        isCompleted: false,
        whatYouWillLearn: ['Marketing cơ bản', 'Social Media Strategy'],
        courseIncludes: ['8 giờ video', 'Tài liệu PDF'],
        courseSections: [
          CourseSection(
            title: 'Giới thiệu',
            duration: '1:00',
            lectures: [
              CourseLecture(
                title: 'Bài 1', 
                duration: '30:00', 
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course3.mp4',
              ),
              CourseLecture(
                title: 'Bài 2', 
                duration: '30:00', 
                type: 'video',
              ),
            ],
          ),
        ],
        relatedCategories: ['Marketing', 'Business'],
        minidescription: '<p>Học marketing cơ bản</p>',
        detailDescription: '<p>Mô tả chi tiết về marketing</p>',
      ),
      CourseModel(
        id: '3',
        title: 'Content Marketing Master - Từ Tư Duy → Chiến Lược → Thực Hiện',
        instructorName: 'Content Creator Pro',
        thumbnail: 'assets/images/course3.jpg',
        rating: 4.7,
        reviewCount: 189,
        price: 279000,
        badge: 'Best Seller',
        lastUpdated: DateTime.now().subtract(const Duration(days: 10)),
        totalHours: 15,
        totalLectures: 58,
        category: 'Marketing',
        language: 'Tiếng Việt',
        hasSubtitles: false,
        level: 'Advanced',
        subcategory: 'Content Marketing',
        shortDescription: 'Khóa học Content Marketing nâng cao',
        totalStudents: 800,
        isCompleted: false,
        whatYouWillLearn: ['Content Strategy', 'Content Creation'],
        courseIncludes: ['15 giờ video', 'Templates'],
        courseSections: [
          CourseSection(
            title: 'Giới thiệu',
            duration: '1:00',
            lectures: [
              CourseLecture(
                title: 'Bài 1', 
                duration: '30:00', 
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course1.mp4',
              ),
            ],
          ),
        ],
        relatedCategories: ['Marketing', 'Content'],
        minidescription: '<p>Học Content Marketing</p>',
        detailDescription: '<p>Mô tả chi tiết về Content Marketing</p>',
      ),
      CourseModel(
        id: '4',
        title: 'Lộ Trình Làm Video Từ Số 0 - Bán Hàng Triệu Đơn',
        instructorName: 'Video Creator',
        thumbnail: 'assets/images/course4.jpg',
        rating: 4.6,
        reviewCount: 276,
        price: 289000,
        badge: '',
        lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
        totalHours: 20,
        totalLectures: 75,
        category: 'Sáng tạo nội dung',
        language: 'Tiếng Việt',
        hasSubtitles: true,
        level: 'Intermediate',
        subcategory: 'Video Marketing',
        shortDescription: 'Khóa học làm video marketing',
        totalStudents: 500,
        isCompleted: false,
        whatYouWillLearn: ['Video Creation', 'Marketing Strategy'],
        courseIncludes: ['20 giờ video', 'Tools'],
        courseSections: [
          CourseSection(
            title: 'Giới thiệu',
            duration: '1:00',
            lectures: [
              CourseLecture(
                title: 'Bài 1', 
                duration: '30:00', 
                type: 'video',
                hasPreview: true,
                previewVideoUrl: 'assets/videos/course2.mp4',
              ),
            ],
          ),
        ],
        relatedCategories: ['Video', 'Marketing'],
        minidescription: '<p>Học làm video marketing</p>',
        detailDescription: '<p>Mô tả chi tiết về video marketing</p>',
      ),
      // Add basic info for other courses
      ...List.generate(6, (index) {
        final courseData = [
          {
            'id': '5',
            'title': 'Master Analytical Thinking & Analysis With Power BI',
            'instructor': 'Hiếu Nguyên Trung',
            'category': 'Phân tích dữ liệu',
            'subcategory': 'Power BI',
            'price': 349000,
            'rating': 4.9,
            'reviews': 698,
            'badge': 'Hot',
            'hours': 25,
            'lectures': 95,
            'students': 2500,
            'language': 'Tiếng Anh',
          },
          {
            'id': '6',
            'title': 'Toán Lớp 12 - Ôn Thi THPT Quốc Gia',
            'instructor': 'Thầy Nguyễn Văn A',
            'category': 'Toán học',
            'subcategory': 'THPT',
            'price': 199000,
            'rating': 4.8,
            'reviews': 324,
            'badge': '',
            'hours': 30,
            'lectures': 120,
            'students': 1200,
            'language': 'Tiếng Việt',
          },
          {
            'id': '7',
            'title': 'Tiếng Anh B1 - Giao Tiếp Thực Tế',
            'instructor': 'Cô Phạm Thị B',
            'category': 'Ngoại ngữ',
            'subcategory': 'Tiếng Anh',
            'price': 149000,
            'rating': 4.9,
            'reviews': 512,
            'badge': 'Best Seller',
            'hours': 18,
            'lectures': 65,
            'students': 1800,
            'language': 'Tiếng Anh',
          },
          {
            'id': '8',
            'title': 'Hóa Học Hữu Cơ - Bước Tiến Cơ Bản',
            'instructor': 'Thầy Trần Văn C',
            'category': 'Khoa học',
            'subcategory': 'Hóa học',
            'price': 179000,
            'rating': 4.7,
            'reviews': 189,
            'badge': '',
            'hours': 22,
            'lectures': 88,
            'students': 600,
            'language': 'Tiếng Việt',
          },
          {
            'id': '9',
            'title': 'Vật Lý Điện Từ - Hiểu Sâu Công Thức',
            'instructor': 'Thầy Lê Minh D',
            'category': 'Khoa học',
            'subcategory': 'Vật lý',
            'price': 189000,
            'rating': 4.6,
            'reviews': 276,
            'badge': 'Hot',
            'hours': 16,
            'lectures': 72,
            'students': 800,
            'language': 'Tiếng Việt',
          },
          {
            'id': '10',
            'title': 'Lập Trình Python cho Người Mới Bắt Đầu',
            'instructor': 'Thầy Hoàng Anh E',
            'category': 'Lập trình',
            'subcategory': 'Python',
            'price': 399000,
            'rating': 4.9,
            'reviews': 698,
            'badge': 'Best Seller',
            'hours': 35,
            'lectures': 140,
            'students': 3000,
            'language': 'Tiếng Việt',
          },
        ];

        final data = courseData[index];
        return CourseModel(
          id: data['id'] as String,
          title: data['title'] as String,
          instructorName: data['instructor'] as String,
          thumbnail: 'assets/images/course${(index % 5) + 1}.jpg',
          rating: data['rating'] as double,
          reviewCount: data['reviews'] as int,
          price: (data['price'] as int).toDouble(),
          badge: data['badge'] as String,
          lastUpdated: DateTime.now().subtract(Duration(days: index + 1)),
          totalHours: data['hours'] as int,
          totalLectures: data['lectures'] as int,
          category: data['category'] as String,
          language: data['language'] as String,
          hasSubtitles: true,
          level: 'Intermediate',
          subcategory: data['subcategory'] as String,
          shortDescription: 'Khóa học ${data['category']}',
          totalStudents: data['students'] as int,
          isCompleted: false,
          whatYouWillLearn: ['Kiến thức cơ bản', 'Thực hành'],
          courseIncludes: ['${data['hours']} giờ video', 'Tài liệu'],
          courseSections: [
            CourseSection(
              title: 'Giới thiệu',
              duration: '1:00',
              lectures: [
                CourseLecture(
                  title: 'Bài 1', 
                  duration: '30:00', 
                  type: 'video',
                  hasPreview: true,
                  previewVideoUrl: 'assets/videos/course${(index % 3) + 1}.mp4',
                ),
              ],
            ),
          ],
          relatedCategories: [data['category'] as String, 'Học tập'],
          minidescription: '<p>Học ${data['category']} cơ bản</p>',
          detailDescription: '<p>Mô tả chi tiết về ${data['category']}</p>',
        );
      }),
    ];
  }

  /// Mock data for featured courses (keeping for compatibility)
  static List<CourseModel> mockFeaturedCourses() {
    return mockCourses().take(5).toList();
  }
}
