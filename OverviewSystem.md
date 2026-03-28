# EduMatch Platform - Tổng Quan Hệ Thống

## 📋 Mục Lục
1. [Giới Thiệu](#giới-thiệu)
2. [Mục Tiêu Hệ Thống](#mục-tiêu-hệ-thống)
3. [Kiến Trúc & Cấu Trúc](#kiến-trúc--cấu-trúc)
4. [Các Vai Trò Người Dùng](#các-vai-trò-người-dùng)
5. [Tính Năng Chính Cho Học Sinh](#tính-năng-chính-cho-học-sinh)
6. [Tính Năng Chính Cho Gia Sư](#tính-năng-chính-cho-gia-sư)
7. [Tính Năng Admin & Quản Trị](#tính-năng-admin--quản-trị)
8. [Hình Thức Học Tập](#hình-thức-học-tập)
9. [Các Đặc Điểm Nổi Bật](#các-đặc-điểm-nổi-bật)
10. [Ecosystem Hệ Thống](#ecosystem-hệ-thống)

---

## 🎯 Giới Thiệu

**EduMatch** là một nền tảng giáo dục toàn diện (EdTech Platform) kết hợp hai mô hình kinh doanh chính:

### Marketplace Tìm Gia Sư
- Tương tự như TopCV, VietnamWorks nhưng cho lĩnh vực giáo dục
- Cho phép học sinh tìm kiếm, so sánh và thuê gia sư
- Kết nối trực tiếp giữa học sinh và gia sư
- Hệ thống đánh giá và review 2 chiều

### Nền Tảng E-Learning Online
- Tương tự như Udemy, Coursera
- Số lượng lớn khóa học được tạo bởi các gia sư
- Hệ thống học tập toàn diện: video, bài tập, quiz, chứng chỉ
- Hỗ trợ lớp học trực tuyến theo nhóm

### Lợi Ích Kết Hợp
Nền tảng tạo ra một ecosystem khép kín nơi:
- Học sinh có thể học 1-1 với gia sư hoặc tham gia khóa học online
- Gia sư có thể kiếm thêm thu nhập thông qua việc tạo khóa học
- Quản trị viên kiểm soát toàn bộ chất lượng và giao dịch

---

## 🎪 Mục Tiêu Hệ Thống

### 🎓 Đối Với Học Sinh & Phụ Huynh (Client)

**Mục Tiêu Chính:**
- ✅ Tìm kiếm gia sư phù hợp theo:
  - Môn học
  - Khu vực địa lý
  - Giá cả
  - Đánh giá và điểm số
  - Kinh nghiệm

- ✅ Đặt lịch học linh hoạt:
  - Học 1-1 (online hoặc offline)
  - Lớp học nhóm
  - Khóa học tự học

- ✅ Tham gia khóa học online:
  - Học tập không giới hạn thời gian
  - Đa dạng nội dung từ các gia sư
  - Giá cả phải chăng

- ✅ Quản lý học tập tập trung:
  - Theo dõi tiến độ
  - Quản lý lịch học unificated
  - Xem hết đánh giá từ gia sư

### 👨‍🏫 Đối Với Gia Sư (Tutor)

**Mục Tiêu Chính:**
- ✅ Xây dựng hồ sơ chuyên nghiệp:
  - Bằng cấp, chứng chỉ
  - Portfolio thử nghiệm
  - Video giới thiệu
  - Tiếp cận học sinh tiềm năng

- ✅ Quản lý lịch dạy hiệu quả:
  - Calendar toàn bộ gia sư
  - Dễ dàng chấp nhận/từ chối booking
  - Rescheduling tự động

- ✅ Tạo khóa học online:
  - Xây dựng thương hiệu cá nhân
  - Thu nhập thụ động từ khóa học
  - Công cụ tạo nội dung đầy đủ

- ✅ Tăng thu nhập đa hình thức:
  - Dạy 1-1 (offline/online)
  - Dạy lớp nhóm
  - Bán khóa học online
  - Lớp học live theo lịch

### 🔧 Đối Với Quản Trị Viên (Admin)

**Mục Tiêu Chính:**
- ✅ Kiểm soát chất lượng:
  - Xác minh hồ sơ gia sư
  - Kiểm duyệt nội dung khóa học
  - Quản lý người dùng

- ✅ Quản lý tài chính:
  - Toàn bộ giao dịch
  - Payout cho gia sư
  - Báo cáo doanh thu

- ✅ Phân tích và tối ưu:
  - Dữ liệu người dùng
  - Trends giáo dục
  - Cải thiện trải nghiệm

---

## 🏗️ Kiến Trúc & Cấu Trúc

EduMatch được xây dựng trên 3 hệ sinh thái chính:

```
┌─────────────────────────────────────────────────────────┐
│                    EduMatch Platform                     │
├──────────────────┬──────────────────┬──────────────────┤
│                  │                  │                  │
│   Client App/Web │  Tutor App/Web   │   Admin Panel    │
│  (Student-Parent)│  (Content Creator)│  (Management)    │
│                  │                  │                  │
└──────────────────┴──────────────────┴──────────────────┘
         │                  │                  │
         └──────────────────┴──────────────────┘
                   Backend Services
                   (API/Database)
```

### Các Thành Phần Chính:

| Thành Phần | Mô Tả | Người Dùng |
|-----------|-------|-----------|
| **Client App/Web** | Giao diện cho học sinh và phụ huynh | Học sinh, Phụ huynh |
| **Tutor App/Web** | Giao diện cho gia sư và người dạy | Gia sư, Instructor |
| **Admin Panel** | Bảng điều khiển quản trị hệ thống | Admin, Manager |
| **Backend** | Máy chủ xử lý logic, database, API | Hệ thống nội bộ |

---

## 👥 Các Vai Trò Người Dùng

### 1. **Student (Học Sinh)**
- Người chủ yếu sử dụng marketplace tìm gia sư
- Đặt lịch học 1-1 
- Tham gia khóa học online

### 2. **Parent (Phụ Huynh)**
- Cũng sử dụng marketplace tìm gia sư
- Có thể được assign vào booking của con
- Quản lý chi tiêu học tập

### 3. **Tutor (Gia Sư)**
- Tạo hồ sơ và được xác minh
- Nhận booking từ học sinh
- Dạy 1-1 hoặc lớp nhóm

### 4. **Instructor/Content Creator**
- Gia sư nâng cao tạo khóa học
- Quản lý nội dung giáo dục
- Nhận doanh thu từ khóa học

### 5. **Admin (Quản Trị)**
- Quản lý toàn bộ người dùng
- Kiểm duyệt nội dung
- Quản lý giao dịch và tài chính

---

## 🎓 Tính Năng Chính Cho Học Sinh

### A. MARKETPLACE - TÌM GIA SƯ

#### 1. **Onboarding (Khởi Động)**
Giới thiệu nhanh và cá nhân hóa trải nghiệm ban đầu.

**Chức Năng:**
- Welcome screens giới thiệu giá trị sản phẩm
- Lựa chọn vai trò: học sinh hoặc phụ huynh
- Chọn môn học quan tâm
- Setup hồ sơ ban đầu

**Mục Tiêu:** Thu thập dữ liệu để cá nhân hóa gợi ý gia sư

#### 2. **Authentication (Xác Thực)**
Hệ thống bảo mật tài khoản người dùng.

**Chức Năng:**
- Đăng nhập (Login)
- Đăng ký tài khoản (Sign up)
- Quên mật khẩu (Forgot Password)
- Xác thực OTP (One-Time Password)
- Xác minh email/số điện thoại

#### 3. **Home/Dashboard (Trang Chủ)**
Trang chính được cá nhân hóa cho từng học sinh.

**Nội Dung Hiển Thị:**
- 🎯 Gia sư gợi ý phù hợp (AI recommendation)
- 📚 Khóa học nổi bật trending
- 🟢 Gia sư đang online
- 🎊 Banner khuyến mãi
- ⚡ Quick actions (đặt lịch nhanh, tìm kiếm)

#### 4. **Tutor Marketplace (Tìm Kiếm Gia Sư)**
Core feature - công cụ tìm gia sư chính.

**Tính Năng Danh Sách:**
- Grid/List view gia sư
- Sắp xếp (mới nhất, đánh giá cao, giá...)

**Bộ Lọc Nâng Cao:**
- 🏫 Môn học (Toán, Tiếng Anh, Lý...)
- 💰 Giá tiếng (< 100k, 100-200k, > 200k...)
- ⭐ Rating/Đánh giá (4+, 4.5+...)
- 📍 Khu vực (Hà Nội, TP HCM, Quận 1...)
- 👨‍🎓 Kinh nghiệm
- 📺 Hình thức (Online, Offline, Cả hai)

**Tìm Kiếm:**
- Search theo tên gia sư
- Search theo kỹ năng

**Trang Chi Tiết Gia Sư:**
- 👤 Giới thiệu & kinh nghiệm
- 📜 Bằng cấp, chứng chỉ
- ⭐ Reviews & ratings
- 📅 Lịch trống
- 💬 CTA: Đặt lịch / Nhắn tin

**Tính Năng Nâng Cao:**
- 🔀 So sánh gia sư (2-3 gia sư cùng lúc)
- 🗺️ Map view (tìm gia sư gần khu vực)

#### 5. **Booking 1-1 Session (Đặt Lịch Học)**
Quy trình đặt lịch học từng bước.

**Các Bước Đặt Lịch:**
1. Chọn ngày giờ (từ calendar gia sư)
2. Chọn hình thức:
   - Online (video call)
   - Offline (tại địa điểm)
3. Nhập yêu cầu học chi tiết
4. Review toàn bộ booking
5. Thanh toán (Wallet, Card, Transfer...)
6. Xác nhận booking

**Sau Khi Đặt:**
- Nhận xác nhận booking
- Lịch trình được save vào calendar
- Thông báo nhắc nhở trước giờ

---

### B. E-LEARNING PLATFORM - KHÓA HỌC ONLINE

#### 1. **Courses Marketplace (Duyệt Khóa Học)**
Thư viện khóa học đa dạng từ các gia sư.

**Tính Năng:**
- Duyệt khóa học
- Lọc theo:
  - 📊 Cấp độ (Beginner, Intermediate, Advanced)
  - 🏆 Môn học
  - 💰 Giá tiếng (Free, Paid)
  - ⭐ Rating
  - 👨‍🏫 Instructor
  
**Trang Chi Tiết Khóa Học:**
- 📹 Video giới thiệu (trailer)
- 📋 Curriculum (danh sách bài học)
- ⭐ Reviews & ratings từ học sinh khác
- 👨‍🏫 Thông tin instructor
- 💰 Giá cả & coupons

**Thanh Toán Khóa Học:**
- Thanh toán một lần
- Truy cập vĩnh viễn
- Xem lại không giới hạn

#### 2. **Learning Interface (Giao Diện Học)**
Hệ thống học online hoàn chỉnh.

**Thành Phần:**
- 🎬 Video player (pause, rewind, speed control)
- 📑 Sidebar nội dung khóa học (navigation)
- 📝 Notes & tài liệu tham khảo (downloadable)
- ❓ Quiz / Assignment (kiểm tra kiến thức)
- 💬 Discussion (hỏi đáp, comment)

**Tính Năng Học Tập:**
- Tạm dừng & tiếp tục bất kỳ lúc nào
- Xem lại bài giảng không giới hạn
- Ghi chú cá nhân
- Tải về tài liệu

**Chứng Chỉ:**
- Cấp chứng chỉ sau khi hoàn thành
- Download & chia sẻ chứng chỉ

#### 3. **Live Classes (Lớp Học Trực Tuyến)**
Lớp học theo nhóm theo lịch thực tế.

**Tính Năng:**
- 📅 Xem lịch lớp học sắp diễn ra
- ✍️ Đăng ký lớp nhóm
- 🎥 Virtual classroom realtime (video, chat, screen share)
- 📹 Xem lại recordings (nếu có)
- 🤝 Tương tác trực tiếp với instructor & học sinh khác

---

### C. PERSONAL MANAGEMENT (QUẢN LÝ CÁ NHÂN)

#### 1. **My Learning**
Trung tâm quản lý toàn bộ hoạt động học tập.

**Nội Dung:**
- 📅 Lịch học 1-1 (sắp tới, đã xong)
- 📚 Lớp đã đăng ký (active, completed)
- 🎓 Khóa đang học (progress %)
- 📊 Tracking tiến độ chi tiết
- 🏆 Chứng chỉ đã nhận
- 📜 Lịch sử học tập toàn bộ

#### 2. **Messaging (Nhắn Tin)**
Giao tiếp trực tiếp với gia sư.

**Chức Năng:**
- 💬 Chat text với gia sư
- 📞 Video call (qua app hoặc link external)
- 📸 Chia sẻ file/ảnh
- 🔔 Thông báo tin nhắn mới

#### 3. **Profile & Settings (Hồ Sơ)**
Quản lý thông tin cá nhân và cài đặt.

**Hồ Sơ:**
- 👤 Tên, tuổi, ảnh đại diện
- 📧 Email, số điện thoại
- 📍 Địa chỉ
- 🎯 Môn học quan tâm

**Phương Thức Thanh Toán:**
- Thẻ tín dụng / Visa
- Ví điện tử
- Chuyển khoản ngân hàng
- Lịch sử giao dịch

**Cài Đặt:**
- Thông báo
- Quyền riêng tư
- Ngôn ngữ
- Đăng xuất

---

## 👨‍🏫 Tính Năng Chính Cho Gia Sư

### A. TUTOR MARKETPLACE

#### 1. **Onboarding & Verification (Đăng Ký & Xác Minh)**
Quy trình đăng ký gia sư quy chuẩn.

**Các Bước:**
1. 📝 Đăng ký thông tin cơ bản (tên, email, sdt)
2. 📜 Upload bằng cấp (ảnh hoặc PDF)
3. 🏫 Chọn môn dạy & cấp độ (Tiểu học, THCS, THPT...)
4. 💰 Thiết lập giá theo giờ (có gợi ý từ hệ thống)
5. 🎥 Tạo video giới thiệu cá nhân (nói về bản thân)
6. 📅 Setup calendar sẵn có
7. ⏳ Chờ admin duyệt hồ sơ (24-48 giờ)

**Kết Quả:**
- ✅ Hồ sơ verified → có thể nhận booking
- ❌ Hồ sơ rejected → feedback từ admin

#### 2. **Tutor Dashboard (Trang Chủ Gia Sư)**
Bảng điều khiển trung tâm.

**Widgets Hiển Thị:**
- 💰 **Earnings** - Tổng doanh thu tháng này
  - Doanh thu từ 1-1 booking
  - Doanh thu từ khóa học
  - Số tiền khả dụng
  
- 📋 **Bookings** - Booking gần nhất
  - Upcoming sessions
  - Pending requests
  
- ⭐ **Reviews** - Đánh giá mới
  - Rating trung bình
  - Số bình luận
  
- 📅 **Calendar** - Lịch dạy
  - Quick view tháng hiện tại
  - Upcoming classes
  
- 🔔 **Notifications** - Thông báo
  - New booking
  - New reviews
  - System messages

#### 3. **Profile Management (Quản Lý Hồ Sơ)**
Gia sư quản lý hồ sơ công khai.

**Chức Năng:**
- 👁️ Preview hồ sơ (xem như học sinh thấy)
- ✏️ Edit thông tin cá nhân
- 📚 Quản lý chứng chỉ/bằng cấp
- 🎬 Portfolio / demo lessons (video dạy mẫu)
- 💰 Pricing (điều chỉnh giá)
- 📅 Availability calendar (chỉnh lịch trống)
- 📊 View statistics (số lần view profile, contact)

#### 4. **Booking Management (Quản Lý Booking)**
Xử lý các request từ học sinh.

**Tình Trạng Booking:**
- 🆕 **New Request** - Request mới từ học sinh
  - Thông tin học sinh
  - Yêu cầu học
  - Thời gian đề xuất
  - Accept / Decline button

- ✅ **Upcoming** - Lịch sắp diễn ra
  - Thông tin chi tiết buổi học
  - Nút: Start session, Reschedule, Cancel

- ✔️ **Completed** - Lịch đã hoàn thành
  - Đánh giá từ học sinh
  - Tùy chọn: Remark, Report issue

- ❌ **Cancelled** - Lịch bị hủy
  - Lý do hủy
  - Số tiền hoàn lại (nếu có)

**Chức Năng:**
- Nhận request booking
- Accept / Decline request
- Reschedule / Cancel session
- Mark session completed
- Gửi phản hồi sau buổi học

---

### B. CONTENT CREATOR (TẠO KHÓA HỌC)

#### 1. **Course Creation (Tạo Khóa Học)**
Công cụ tạo nội dung giáo dục.

**Bước 1: Course Info**
- 📝 Tên khóa học
- 📄 Mô tả chi tiết
- 🎬 Video giới thiệu (thumbnail + video)
- 🏆 Cấp độ (Beginner, Intermediate, Advanced)
- 🎯 Mục tiêu học tập
- 💰 Giá khóa học
- 🏷️ Category & tags

**Bước 2: Curriculum Builder (Xây Dựng Nội Dung)**
- 📚 Tạo sections (Chương)
- 🎥 Thêm video bài giảng
  - Upload video từ máy
  - Video description
  - Duration
  - Transcript/subtitle (option)
  
- 📝 Thêm tài liệu (PDF, Word...)
- ❓ Tạo quiz/assignment
- 📊 Kiểm tra độ hoàn chỉnh

**Bước 3: Publish**
- 📋 Review tổng quan
- 🔍 Preview khóa học (như học sinh thấy)
- ✅ Publish (trình duyệt admin)
- 🏷️ Featured (request để promote)

**Bước 4: Management**
- 👥 Xem danh sách học sinh đã mua
- 📊 Analytics doanh thu
  - Số khóa bán được
  - Tổng doanh thu
  - Conversion rate
- 💬 Q&A từ học sinh
- 📢 Promote khóa học

#### 2. **Live Classes Creation (Lớp Học Live)**
Tạo và quản lý lớp học theo nhóm.

**Quy Trình:**
1. 📋 Tạo class info
   - Tên lớp
   - Mô tả
   - Lịch học (ngày, giờ, duration)
   
2. 💰 Thiết lập pricing
   - Giá cho mỗi buổi
   - Hoặc package (5 buổi giảm giá)
   
3. 📅 Publish lịch
   - Học sinh có thể đăng ký
   - Max số học sinh (optional)
   
4. 🎥 Trước buổi học
   - Generate link class
   - Kiểm tra audio/video
   - Chuẩn bị tài liệu
   
5. ▶️ Trong buổi học
   - Video class (tương tự Zoom)
   - Screen share
   - Chat realtime
   - Record class
   
6. 📹 Sau buổi học
   - Upload video replay
   - Học sinh xem lại

---

### C. EARNINGS & PAYMENTS (KIẾM TIỀN & THANH TOÁN)

#### 1. **Earnings Dashboard**
Theo dõi doanh thu chi tiết.

**Hiển Thị:**
- 💵 **Total Earnings** - Tổng doanh thu (all-time, year, month)
- 💰 **Available Balance** - Số tiền sẵn sàng rút
- ⏳ **Pending** - Đợi xác nhận (trước khi vào available)
- 📈 **Revenue Chart** - Biểu đồ doanh thu (không/tháng)
  - From 1-1 sessions
  - From courses
  - From live classes

**Lịch Sử Giao Dịch:**
- 📅 Ngày giao dịch
- 📝 Loại (Session, Course, Live class)
- 👤 Học sinh/Lớp
- 💵 Số tiền
- 🔗 Invoice

#### 2. **Rút Tiền (Payout)**
Chuyển tiền doanh thu vào tài khoản.

**Quy Trình:**
1. 💳 Thiết lập ngân hàng
   - Chọn ngân hàng
   - Số tài khoản
   - Tên chủ tài khoản
   
2. 💰 Yêu cầu rút tiền
   - Số tiền muốn rút
   - Lý do (optional)
   
3. ⏳ Chờ xử lý (1-5 ngày làm việc)
4. ✅ Tiền vào tài khoản

**Chi Phí:**
- Hoa hồng nền tảng: 10-20% per transaction
- Phí ngân hàng (nếu có)

#### 3. **Tax Documents (Hóa Đơn)**
Hỗ trợ lập báo cáo thuế.

**Tài Liệu:**
- 📄 Invoice hàng tháng
- 📊 Annual income report
- 🏛️ Tax documentation

---

### D. REVIEWS (ĐÁNH GIÁ & PHẢN HỒI)

#### 1. **View Reviews**
Xem tất cả đánh giá từ học sinh.

**Nội Dung:**
- ⭐ Rating (1-5 sao)
- 💬 Comment/Review text
- 👤 Tên học sinh
- 📅 Ngày review

#### 2. **Respond to Reviews**
Trả lời đánh giá để xây dựng uy tín.

**Chức Năng:**
- 📝 Viết phản hồi
- ❤️ Like/Pin review tốt

---

### E. MESSAGING & SUPPORT (HỖ TRỢ)**

#### 1. **Chat với Học Sinh**
Giao tiếp trực tiếp qua app.

- 💬 Nhắn tin text
- 📞 Video call
- 📸 Chia sẻ tài liệu
- 🔔 Notification

#### 2. **Support Tickets**
Liên hệ với hỗ trợ nền tảng.

- 📝 Tạo ticket
- 🏷️ Phân loại (Technical, Payment, Content...)
- ⏳ Theo dõi trạng thái

---

## 🔐 Tính Năng Admin & Quản Trị

### 1. **Dashboard (Bảng Điều Khiển)**
Tổng quan hệ thống.

**Widgets Chính:**
- 📊 **Metrics**
  - Tổng users (Students, Tutors, Admins)
  - Tổng transactions
  - Active sessions
  - Total revenue
  
- 📈 **Revenue Chart**
  - Doanh thu theo tháng
  - Breakdown: Sessions vs Courses
  - Trending
  
- 🔔 **Recent Activities**
  - New sign-ups
  - New courses
  - Complaints/Reports
  - Payment issues

---

### 2. **User Management (Quản Lý Người Dùng)**

#### Student Management
- 👥 Danh sách học sinh
- 🔍 Search/Filter
- 📊 Xem chi tiết:
  - Hồ sơ
  - Lịch sử booking
  - Khóa học đã mua
  - Transactions
  - Reports (nếu có)
- ⛔ Ban / Suspend (nếu vi phạm)

#### Tutor Management
- 👥 Danh sách gia sư
- 🔍 Search/Filter
- 📊 Chi tiết:
  - Hồ sơ & chứng chỉ
  - Sessions completed
  - Revenue
  - Reviews & ratings
  - Courses created
- ✅ Approve / ❌ Reject hồ sơ
- ⛔ Suspend/Ban nếu cần

#### Tutor Verification Queue
- ⏳ Gia sư chờ duyệt
- 📋 Review tài liệu
- ✅ Approve & activate
- ❌ Reject với lý do feedback

---

### 3. **Content Management (Quản Lý Nội Dung)**

#### Course Moderation
- 📚 Khóa học chờ duyệt
- 🔍 Review content:
  - Video content
  - Bài tập & quiz
  - Description
  - Kiểm tra vi phạm bản quyền
  
- ✅ Approve for public
- ❌ Reject với feedback
- 🏷️ Feature (promote to homepage)

#### Category Management
- 📝 Tạo/Edit subjects & categories
- 🔢 Sắp xếp thứ tự
- 🏷️ Featured categories

#### Featured Content
- 🌟 Quản lý content nổi bật
- 📌 Pin khóa học/gia sư trending
- 📊 A/B test featured items

---

### 4. **Transactions & Finance (Giao Dịch & Tài Chính)**

#### Transaction Management
- 📋 Toàn bộ giao dịch
- 🔍 Filter: Status, Date, User
- 📊 Chi tiết:
  - Amount
  - Fee
  - Nếu balance (gia sư)
  - Status

#### Payout Management
- 💰 Pending payout requests
- ✅ Approve & process
- 📊 Payout history
- 📈 Payout status tracking

#### Financial Reports
- 📊 Revenue reports
- 💵 Fee collection
- 💸 Payout history
- 📈 Trends & analytics
- 📄 Export (CSV, PDF)

---

### 5. **System Management (Quản Lý Hệ Thống)**

#### Reports & Complaints
- 📋 User complaints
- 🚩 Flagged content
- 📝 Reviewed reports
- ⚠️ Urgent issues
- ✅ Resolution tracking

#### System Settings
- ⚙️ Platform fees (% commission)
- 🔔 Notification templates
- 📱 Push notification settings
- 🌍 Localization settings
- 🔒 Security settings

#### Admin Accounts
- 👥 Quản lý admin users
- 🔑 Access control & permissions
- 📝 Admin activity logs
- 🔐 Role-based access (Super Admin, Moderator, etc.)

---

## 🎓 Hình Thức Học Tập

### 1. **Học 1-1 Offline (Cá Nhân - Ngoài Mạng)**

**Định Nghĩa:** Gia sư đến tận nhà hoặc địa điểm hẹn để dạy

**Đặc Điểm:**
- ✅ Tương tác trực tiếp face-to-face
- ✅ Phù hợp cho những em cần giám sát chặt chẽ
- ✅ Linh hoạt về thời gian và địa điểm
- ❌ Chi phí cao hơn
- ❌ Thời gian di chuyển

**Quy Trình:**
1. Học sinh tìm kiếm gia sư
2. Đặt lịch (chọn ngày, giờ, địa điểm)
3. Thanh toán trước
4. Gia sư đến dạy
5. Mark complete, rate & review

**Tính Năng Hỗ Trợ:**
- 🗺️ Map view gia sư gần
- 📍 Chọn địa điểm gặp
- 🧭 Navigation để gia sư tìm đến
- 🔔 Thông báo nhắc nhở
- 📞 Contact before session

---

### 2. **Học 1-1 Online (Cá Nhân - Trực Tuyến)**

**Định Nghĩa:** Gia sư dạy qua video call từ xa

**Đặc Điểm:**
- ✅ Chi phí rẻ hơn (không tính tiền di chuyển)
- ✅ Tiết kiệm thời gian di chuyển
- ✅ Dễ reschedule
- ✅ Linh hoạt thời gian
- ❌ Cần thiết bị và internet ổn định
- ❌ Kém tương tác so với offline

**Quy Trình:**
1. Đặt lịch học online
2. Thanh toán
3. Trước giờ học, nhận link video call
4. Join video call qua Zoom/Google Meet/etc
5. Học tập qua video
6. Rate & review

**Tính Năng Hỗ Trợ:**
- 💻 Video call integration
- 📞 Call quality monitoring
- 📱 Mobile-friendly interface
- 🔗 Join link gửi trước
- ⏰ Reminder notifications
- 📹 Option ghi hình buổi học

---

### 3. **Lớp Học Nhóm (Group Classes)**

**Định Nghĩa:** Nhóm 5-20 học sinh học cùng một gia sư theo lịch cố định

**Đặc Điểm:**
- ✅ Chi phí tiết kiệm hơn (chia đều)
- ✅ Tương tác bạn học
- ✅ Motivation từ đồng lớp
- ❌ Ít personal attention hơn
- ❌ Lịch cố định (kém linh hoạt)
- ❌ Khó tìm giờ phù hợp cho cả nhóm

**Quy Trình:**
1. Gia sư tạo live class với lịch cụ thể
2. Học sinh tìm kiếm & đăng ký
3. Thanh toán (per session hoặc package)
4. Vào lớp học qua link
5. Học tập & tương tác
6. Video replay sau đó

**Tính Năng Hỗ Trợ:**
- 🎥 Virtual classroom (video, chat, breakroom)
- 📋 Attendance tracking
- 📊 Participation scoring
- 📹 Auto-recording
- 💰 Group pricing & discounts
- 👥 Max class size limit

---

### 4. **Khóa Học Tự Học (Self-Paced Courses)**

**Định Nghĩa:** Học sinh học video bài giảng theo tempo riêng của mình, không có lịch cố định

**Đặc Điểm:**
- ✅ Hoàn toàn linh hoạt thời gian
- ✅ Xem lại video không giới hạn
- ✅ Chi phí rẻ nhất
- ✅ Có thể dừa/tiếp tục bất kỳ lúc nào
- ❌ Thiếu accountability (dễ bỏ dở)
- ❌ Kém tương tác với instructor
- ❌ Cần kỷ luật từ học sinh

**Quy Trình:**
1. Học sinh tìm và mua khóa học
2. Truy cập khóa học
3. Xem video video bài giảng
4. Làm bài tập & quiz
5. Xem lại nếu cần
6. Hoàn thành course → nhận certificate
7. Có thể hỏi instructor trong Q&A

**Tính Năng Hỗ Trợ:**
- 🎬 Video player (playback speed, captions)
- 📝 Downloadable resources
- ❓ Q&A với instructor
- 📊 Progress tracking
- 🏆 Certificate of completion
- 💬 Student discussions
- 📌 Bookmarks & notes

---

## ✨ Các Đặc Điểm Nổi Bật

### 1. **Kết Hợp Marketplace + E-Learning**

**Marketplace Tính Năng:**
- 🔍 Tìm kiếm gia sư thông minh
- 📋 Profile gia sư chi tiết (kinh nghiệm, bằng cấp)
- 🌟 Rating & review 2 chiều
- 💻 So sánh gia sư side-by-side
- 📅 Booking & calendar management
- 💰 Thanh toán tích hợp

**E-Learning Platform Tính Năng:**
- 📚 Thư viện khóa học đa dạng
- 🎥 Video HD + tài liệu
- ❓ Quiz & assignments tương tác
- 👥 Live classes & discussion
- 🏆 Certificate & credentials
- 📊 Learning analytics

---

### 2. **Đa Dạng Hình Thức Học Tập**

| Hình Thức | Tương Tác | Chi Phí | Linh Hoạt | Phù Hợp Cho |
|-----------|-----------|---------|-----------|-------------|
| **1-1 Offline** | Cao nhất | Cao | Vừa | Em gần, cần kiểm soát |
| **1-1 Online** | Cao | Trung | Cao | Em xa, bận rộn |
| **Lớp Nhóm** | Vừa | Thấp | Thấp | Tiết kiệm + xã hội hóa |
| **Khóa Online** | Thấp | Thấp nhất | Cao nhất | Em tự giác, bác cần linh hoạt |

---

### 3. **Hệ Thống Đánh Giá & Tin Cậy**

#### 2-Chiều Rating System:
- ⭐ **Học sinh đánh giá gia sư:**
  - Chất lượng giảng dạy
  - Chuyên môn
  - Đúng giờ
  - Thái độ
  
- ⭐ **Gia sư đánh giá học sinh:**
  - Tập trung, lắng nghe
  - Hoàn thành bài tập
  - Thái độ
  - Thanh toán đúng hạn

**Lợi Ích:**
- ✅ Lọc ra gia sư tốt
- ✅ Động cơ cho cả hai bên
- ✅ Minh bạch & công bằng

---

### 4. **Nền Tảng Xây Dựng Thương Hiệu Cá Nhân**

**Cho Gia Sư:**
- 📱 Hồ sơ chi tiết & public
- 🎥 Video giới thiệu
- 📚 Portfolio (courses & reviews)
- 🏆 Achievements & badges
- 📊 Performance metrics
- 🌟 Featured tutor badge (nếu ranking cao)

**Cho Instructor:**
- 📚 Tạo khóa học dưới tên riêng
- 📊 Analytics sales
- 💬 Student testimonials
- 🏆 Course badges (bestseller, highly rated)

---

### 5. **Lợi Thụ Khác Nhau**

**Học Sinh:**
- 💰 Giá cả đa dạng (rẻ đến cao)
- 📍 Flexibility (offline/online/nhóm/tự học)
- 🎯 Cá nhân hóa học (gợi ý dựa AI)
- 🤝 Cộng đồng học

**Gia Sư:**
- 💵 Thu nhập từ nhiều hình thức
- 🎓 Xây dựng sự nghiệp
- 👥 Tiếp cận học sinh nhiều
- 📊 Analytics doanh thu
- 🏦 Transparent payout

**Admin:**
- 📊 Dữ liệu người dùng & trends
- 💰 Revenue từ commission
- 🎮 Ecosystem ổn định
- 📈 Growth metrics
- 🔒 Quality control tools

---

## 🌍 Ecosystem Hệ Thống

### Sơ Đồ Tương Tác:

```
┌─────────────────────────────────────────────────────────────┐
│              EduMatch Ecosystem                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  STUDENTS & PARENTS              TUTORS                      │
│  ┌──────────────────┐            ┌──────────────────┐       │
│  │ • Tìm gia sư     │──Booking──▶│ • Nhận booking   │       │
│  │ • Đặt lịch 1-1   │            │ • Dạy học        │       │
│  │ • Mua khóa học   │            │ • Tạo khóa học   │       │
│  │ • Tham gia lớp   │◀─Rating────│ • Quản lý thu nhập │      │
│  │ • Rate & Review  │            │ • Rate & Review   │       │
│  └──────────────────┘            └──────────────────┘       │
│         ▲                                ▲                   │
│         │                                │                   │
│    4.99% fee                        10-20% commission       │
│         │                                │                   │
│         └────────────┬────────────────────┘                 │
│                      │                                       │
│              ┌───────▼──────────┐                           │
│              │  ADMIN PANEL     │                           │
│              │ • Verify tutors  │                           │
│              │ • Manage users   │                           │
│              │ • Moderate content                           │
│              │ • Track finance  │                           │
│              │ • Analytics      │                           │
│              └──────────────────┘                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Luồng Doanh Thu:

```
STUDENT/PARENT
      │
      ├─► Payment for 1-1 Booking
      │    └─► 95% → Tutor
      │    └─► 5% → Platform
      │
      ├─► Payment for Course
      │    └─► 80% → Content Creator
      │    └─► 20% → Platform
      │
      └─► Payment for Live Class
           └─► 90% → Tutor
           └─► 10% → Platform
```

### Giá Trị Cho Mỗi Bên:

**👨‍🎓 Student Receives:**
- Tìm kiếm gia sư dễ dàng
- Đảm bảo chất lượng (verified tutors)
- Đa dạng hình thức học
- Minh bạch giá cả
- Support customer service
- Learning history tracking

**👨‍🏫 Tutor Receives:**
- Tiếp cận học sinh (marketing)
- Infrastructure (video, chat, booking)
- Payment processing
- Transparent analytics
- Xây dựng brand
- Community & badge

**🔧 Admin Receives:**
- Commission từ transactions
- Data/Analytics
- User ecosystem
- Quality control tools
- Scalable business model
- Sustainable platform

---

## 📊 Tóm Lược Tính Năng Theo Người Dùng

| Feature | Student | Tutor | Admin |
|---------|---------|-------|-------|
| Tìm gia sư | ✅ | ❌ | ❌ |
| Đặt lịch 1-1 | ✅ | ✅ | ❌ |
| Mua khóa học | ✅ | ❌ | ❌ |
| Tạo khóa học | ❌ | ✅ | ❌ |
| Quản lý thu nhập | ❌ | ✅ | ❌ |
| Verify tutor | ❌ | ❌ | ✅ |
| Manage transactions | ❌ | ❌ | ✅ |
| Analytics | ✅ (Learning) | ✅ (Revenue) | ✅ (Platform) |
| Chat/Messaging | ✅ | ✅ | ❌ |
| Rating & Reviews | ✅ | ✅ | ❌ |

---

## 🎯 Kết Luận

**EduMatch** là nền tảng giáo dục toàn diện kết hợp:

- 🏪 **Marketplace** tìm gia sư (tương tự TopCV, VietnamWorks)
- 📚 **E-Learning Platform** (tương tự Udemy, Coursera)
- 🎥 **Live Classes** (tương tự Zoom)
- 💰 **Thanh toán tích hợp** (Wallet, Card, Transfer)
- 👥 **Cộng đồng learning** (Discussion, Q&A)

**Lợi Thế Cạnh Tranh:**
- ✅ Ecosystem khép kín (không cần đi nhiều nơi)
- ✅ Đa dạng hình thức học (offline/online/tự học/nhóm)
- ✅ Minh bạch giá cả & rating
- ✅ Verified tutors (admin kiểm soát chất lượng)
- ✅ Multiple revenue streams (cho gia sư)
- ✅ Scalable business model (commission-based)

**Hành Trình Người Dùng:**
- 🎓 **Student**: Onboard → Tìm gia sư → Booking → Học → Rate
- 👨‍🏫 **Tutor**: Onboard → Verify → Nhận booking → Dạy → Tạo khóa → Kiếm thêm
- 🔧 **Admin**: Verify users → Moderate → Manage finance → Analyze

Hệ thống này tạo ra một ecosystem bền vững nơi tất cả các bên (học sinh, gia sư, platform) đều được lợi ích!

---

**Tài Liệu Tham Khảo:** description.txt  
**Phiên Bản:** 1.0  
**Ngày Cập Nhật:** 28/03/2026

