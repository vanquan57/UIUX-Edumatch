import 'dart:convert';

import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailPage extends StatefulWidget {
  final String tutorId;
  final String? tutorName;

  const ChatDetailPage({
    super.key,
    required this.tutorId,
    this.tutorName,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String? _selectedImagePath;

  static const List<String> _imageOptions = [
    'assets/images/banner4.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final messages = _fakeMessages;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }
                  context.go(AppRouter.messengerChatList);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: AppColors.textDark,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  widget.tutorName ?? 'Gia sư',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1.h, color: AppColors.dividerColor),
        Expanded(
          child: Container(
            color: AppColors.bgLight,
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      'Bắt đầu trò chuyện ngay',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGray,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      return _MessageBubble(message: message);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    itemCount: messages.length,
                  ),
          ),
        ),
        _ComposerBar(
          selectedImagePath: _selectedImagePath,
          onPickImage: _openImagePickerSheet,
          onRemoveImage: () => setState(() => _selectedImagePath = null),
        ),
      ],
    );
  }

  List<_ChatMessage> get _fakeMessages {
    const String jsonSeed = '''
[
  {
    "sender": "tutor",
    "text": "Chào em, hôm nay mình ôn lại chủ đề hệ phương trình nhé.",
    "time": "08:30"
  },
  {
    "sender": "student",
    "text": "Dạ thầy, em đang gặp khó phần đặt ẩn phụ.",
    "time": "08:31"
  },
  {
    "sender": "tutor",
    "text": "Không sao, thầy gửi em một ví dụ đơn giản rồi nâng dần.",
    "time": "08:32"
  },
  {
    "sender": "student",
    "text": "Tuyệt vời ạ, thầy gửi em với.",
    "time": "08:33"
  },
  {
    "sender": "tutor",
    "text": "Buổi tối em chụp bài làm gửi lại, thầy xem cho nhanh.",
    "time": "08:35"
  }
]
''';

    final decoded = jsonDecode(jsonSeed) as List<dynamic>;
    return decoded
        .map(
          (item) => _ChatMessage(
            sender: item['sender'] as String,
            text: item['text'] as String,
            time: item['time'] as String,
          ),
        )
        .toList();
  }

  Future<void> _openImagePickerSheet() async {
    final chosenImage = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn hình ảnh demo',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imageOptions.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final imagePath = _imageOptions[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(imagePath),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          imagePath,
                          width: 150.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (chosenImage != null && mounted) {
      setState(() => _selectedImagePath = chosenImage);
    }
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender == 'student';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 260.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryGreen : AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 6.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isMe ? AppColors.white : AppColors.textDark,
                height: 1.4,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              message.time,
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                color: isMe ? AppColors.lightGreen : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  final String? selectedImagePath;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  const _ComposerBar({
    required this.selectedImagePath,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedImagePath != null)
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      selectedImagePath!,
                      width: 56.w,
                      height: 56.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Đã chọn 1 hình ảnh',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onRemoveImage,
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textGray,
                  ),
                ],
              ),
            ),
          Row(
            children: [
              _CircleIconButton(
                icon: Icons.attach_file_rounded,
                onTap: onPickImage,
              ),
              SizedBox(width: 8.w),
              _CircleIconButton(
                icon: Icons.photo_camera_outlined,
                onTap: onPickImage,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tin nhắn...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.textLightGray,
                    ),
                    filled: true,
                    fillColor: AppColors.bgLight,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 42.w,
                height: 42.w,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_rounded,
                    size: 18.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Icon(icon, color: AppColors.textGray, size: 18.sp),
      ),
    );
  }
}

class _ChatMessage {
  final String sender;
  final String text;
  final String time;

  const _ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
  });
}
