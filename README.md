# edu_match

Ứng dụng Flutter dành cho việc kết nối và quản lý giáo dục.

## 1. Clone và Setup Chạy Project

### Yêu cầu
- Flutter SDK (phiên bản 3.0 trở lên)
- Dart SDK
- Android Studio hoặc Xcode (tùy theo nền tảng)
- Git

### Các bước setup

1. **Clone repository:**
   ```bash
   git clone <repository-url>
   cd edu_match
   ```

2. **Cài đặt dependencies:**
   ```bash
   flutter pub get
   ```

3. **Tạo file environment (nếu cần):**
   ```bash
   # Copy file .env.example thành .env nếu có
   cp .env.example .env
   ```

4. **Chạy project:**
   ```bash
   # Chạy trên device kết nối hoặc emulator
   flutter run
   
   # Hoặc chạy trên nền tảng cụ thể
   flutter run -d android  # Android
   flutter run -d ios      # iOS
   ```

5. **Build APK/IPA:**
   ```bash
   flutter build apk       # Build APK cho Android
   flutter build ios       # Build iOS
   ```

## 2. Quy Tắc Code

### Quy trình Git & PR

1. **Checkout develop branch:**
   ```bash
   git checkout develop
   git pull origin develop
   ```

2. **Tạo feature branch từ develop:**
   ```bash
   git checkout -b feature/<tên-feature>
   # Ví dụ: git checkout -b feature/login-screen
   ```

3. **Commit regularly:**
   ```bash
   git add .
   git commit -m "Description chi tiết về thay đổi"
   ```

4. **Push lên repository:**
   ```bash
   git push origin feature/<tên-feature>
   ```

5. **Tạo Pull Request (PR):**
   - Gửi PR từ feature branch tới develop
   - Ghi rõ mô tả thay đổi và liên kết issue (nếu có)
   - Chờ PM hoặc team lead review
   - **Chỉ được merge khi PM/Team Lead phê duyệt**

### Đặt tên branch
- Feature: `feature/tên-tính-năng`
- Bug fix: `bugfix/tên-bug`
- Hotfix: `hotfix/tên-hotfix`

### Đặt tên commit
- ✨ Feature: `feat: mô tả`
- 🐛 Bug fix: `fix: mô tả`
- 📝 Documentation: `docs: mô tả`
- 🎨 Style: `style: mô tả`
- ♻️ Refactor: `refactor: mô tả`
- ✅ Test: `test: mô tả`

## 3. Các Role Cơ Bản

### 1. **PM (Project Manager)**
   - Quản lý roadmap và timeline
   - Review và phê duyệt PR trước khi merge vào develop
   - Cập nhật trạng thái công việc
   - Giao việc cho team

### 2. **Developer**
   - Thực hiện các feature dựa trên yêu cầu PM
   - Tạo feature branch, commit và push code
   - Tạo PR gửi cho PM review
   - Fix issues dựa trên feedback

### 3. **UI/UX Designer**
   - Thiết kế giao diện ứng dụng
   - Cung cấp design system và assets
   - Support developer trong việc implement UI

### 4. **QA/Tester**
   - Test chức năng trên các nhánh
   - Report bugs chi tiết
   - Xác nhận fix trước khi merge

## Tài liệu tham khảo

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language](https://dart.dev/)
- [Git Workflow](https://git-scm.com/)
