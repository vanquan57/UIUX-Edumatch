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

⚠️ **QUAN TRỌNG - Trước khi tạo PR:**
```bash
# 1. Cập nhật và rebase feature branch với develop trong 1 lệnh
git pull --rebase origin develop

# 2. Nếu có conflict, fix rồi tiếp tục rebase
git rebase --continue

# 3. Push lên với force (vì rebase thay đổi history)
git push origin feature/<tên-feature> --force-with-lease

# 4. Mới tạo PR
```

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

## 3. Chuẩn Code & Quy Tắc Dự Án

### Cấu Trúc Project (Clean Architecture)

```
lib/
├── main.dart                 # Entry point
├── core/
│   ├── config/
│   │   ├── constant.dart     # App constants, enums
│   │   └── env.dart          # Environment variables
│   └── router/
│       └── app_router.dart   # Navigation routes
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── views/
│   │           └── login_view.dart
│   └── home/
│       └── presentation/
│           └── views/
│               └── home_view.dart
└── share/
    └── layouts/
        ├── main_layout.dart  # Main layout wrapper
        ├── header.dart
        └── footer.dart
```

### Hướng Dẫn Cho Từng Role

#### 1. **Developer - Coding Standards**

**📁 Tạo Feature Mới:**
```
features/
├── feature_name/
│   ├── presentation/
│   │   ├── views/
│   │   │   └── feature_view.dart      # Main view/page
│   │   ├── widgets/
│   │   │   └── custom_widget.dart     # Reusable widgets
│   │   └── controllers/
│   │       └── feature_controller.dart # Logic (if needed)
```

**✍️ Naming Convention:**
- Files: `snake_case.dart` (e.g., `login_view.dart`)
- Classes: `PascalCase` (e.g., `LoginView`, `UserModel`)
- Variables/Functions: `camelCase` (e.g., `userName`, `getUserData()`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `DEFAULT_TIMEOUT`)

**📝 View/Page Template:**
```dart
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Feature Page'));
  }
}
```

**🧭 Navigation (Go Router):**
```dart
// Đi tới page khác
context.go(AppRouter.home);

// Hoặc sử dụng route constants
GoRoute(
  path: '/feature',
  name: 'feature',
  builder: (context, state) => const FeaturePage(),
)
```

**📐 Responsive Design (Flutter ScreenUtil):**
```dart
// Sử dụng .w (width) và .h (height) cho responsive UI
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  child: Text('Hello', style: TextStyle(fontSize: 18.sp)),
)
```

**🎨 MainLayout — Layout chính của app:**

`MainLayout` là wrapper dùng cho tất cả các màn hình. Hỗ trợ 2 loại layout và nhiều tuỳ chọn linh hoạt.

---

**Tất cả tham số:**

| Tham số | Kiểu | Mặc định | Mô tả |
|---|---|---|---|
| `child` | `Widget` | **bắt buộc** | Nội dung màn hình |
| `layoutType` | `LayoutType` | `normal` | Kiểu layout (`normal` hoặc `fullscreen`) |
| `backgroundColor` | `Color?` | `Colors.white` | Màu nền Scaffold |
| `statusBarColor` | `Color?` | theo `backgroundColor` | Màu vùng status bar (giờ/wifi/pin) |
| `statusBarIconBrightness` | `Brightness` | `Brightness.dark` | Icon status bar: `dark`=đen, `light`=trắng |
| `useSafeArea` | `bool` | `true` | Tránh vùng camera/notch hay không |
| `showHeader` | `bool` | `true` | Hiện header *(chỉ áp dụng với `normal`)* |
| `showFooter` | `bool` | `true` | Hiện footer *(chỉ áp dụng với `normal`)* |
| `customHeader` | `PreferredSizeWidget?` | `null` | AppBar tuỳ chỉnh *(chỉ áp dụng với `normal`)* |
| `padding` | `EdgeInsets?` | auto responsive | Padding nội dung *(chỉ áp dụng với `normal`)* |

---

**Ví dụ sử dụng:**

```dart
// 1. Màn hình thông thường — có header + footer
MainLayout(
  layoutType: LayoutType.normal,
  child: YourPage(),
)

// 2. Thông thường — ẩn footer
MainLayout(
  layoutType: LayoutType.normal,
  showFooter: false,
  child: YourPage(),
)

// 3. Thông thường — header tuỳ chỉnh
MainLayout(
  layoutType: LayoutType.normal,
  customHeader: AppBar(title: Text('Tiêu đề')),
  child: YourPage(),
)

// 4. Fullscreen — nền trắng, icon status bar tối (màn login, onboarding)
MainLayout(
  layoutType: LayoutType.fullscreen,
  backgroundColor: Colors.white,
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  child: YourPage(),
)

// 5. Fullscreen — nền tối, icon status bar sáng (màn splash, dark theme)
MainLayout(
  layoutType: LayoutType.fullscreen,
  backgroundColor: Colors.black,
  statusBarColor: Colors.black,
  statusBarIconBrightness: Brightness.light,
  child: YourPage(),
)

// 6. Fullscreen tuyệt đối — content chạy lên cả vùng camera/notch
MainLayout(
  layoutType: LayoutType.fullscreen,
  useSafeArea: false,
  child: YourPage(),
)
```

> ⚠️ Các tham số `showHeader`, `showFooter`, `customHeader`, `padding` chỉ có tác dụng với `LayoutType.normal`. Với `LayoutType.fullscreen` những tham số này bị bỏ qua.

**✅ Best Practices:**
- ✓ Sử dụng `const` constructor khi có thể
- ✓ Tuân thủ folder structure
- ✓ Tách logic ra khỏi UI widget
- ✓ Sử dụng meaningful variable names
- ✓ Comment cho code phức tạp
- ✗ Không hard-code giá trị → sử dụng constants
- ✗ Không import từ features khác → sử dụng shared components

---


2. Tạo reusable widgets trong `share/widgets/`
   ```
   share/
   └── widgets/
       ├── buttons/
       │   └── primary_button.dart
       ├── inputs/
       │   └── text_field.dart
       └── cards/
           └── feature_card.dart
   ```




## 4. Các Role Cơ Bản

### 1. **PM (Project Manager)**
   - Quản lý roadmap và timeline
   - Review và phê duyệt PR trước khi merge vào develop
   - Cập nhật trạng thái công việc
   - Giao việc cho team
   - Kiểm tra code quality & conventions

### 2. **Developer**
   - Thực hiện các feature dựa trên yêu cầu PM
   - Tuân thủ folder structure & naming convention
   - Tạo feature branch, commit và push code
   - Tạo PR gửi cho PM review
   - Fix issues dựa trên feedback
