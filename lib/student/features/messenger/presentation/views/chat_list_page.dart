import 'package:edu_match/core/config/app_colors.dart';
import 'package:edu_match/core/router/app_router.dart';
import 'package:edu_match/student/data/models/chat_tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  static const int _stepLoad = 5;
  final TextEditingController _searchController = TextEditingController();
  final List<ChatTutorModel> _allTutors = ChatTutorModel.mockData();
  int _visibleCount = _stepLoad;
  String _searchKeyword = '';

  List<ChatTutorModel> get _filteredTutors {
    if (_searchKeyword.trim().isEmpty) return _allTutors;
    final keyword = _searchKeyword.toLowerCase();
    return _allTutors
        .where((item) => item.name.toLowerCase().contains(keyword))
        .toList();
  }

  List<ChatTutorModel> get _visibleTutors {
    final filtered = _filteredTutors;
    return filtered.take(_visibleCount).toList();
  }

  bool get _canLoadMore => _visibleCount < _filteredTutors.length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchKeyword = value;
      _visibleCount = _stepLoad;
    });
  }

  void _onLoadMore() {
    setState(() {
      _visibleCount += _stepLoad;
    });
  }

  void _goToChatDetail(ChatTutorModel tutor) {
    context.go(
      '${AppRouter.messengerChatDetail}/${tutor.id}',
      extra: tutor.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tin nhắn',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Trao đổi nhanh với gia sư của bạn',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 16.h),
        _buildSearchBox(),
        SizedBox(height: 14.h),
        _buildTutorList(),
      ],
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: 'Tìm theo tên gia sư...',
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textLightGray,
          fontSize: 13.sp,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textGray,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primaryGreen),
        ),
      ),
    );
  }

  Widget _buildTutorList() {
    final items = _visibleTutors;
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Text(
          'Không tìm thấy gia sư phù hợp',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: AppColors.textGray,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final item = items[index];
            return _TutorCard(
              tutor: item,
              onTap: () => _goToChatDetail(item),
            );
          },
        ),
        if (_canLoadMore) ...[
          SizedBox(height: 14.h),
          OutlinedButton(
            onPressed: _onLoadMore,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryGreen),
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Xem thêm',
              style: GoogleFonts.poppins(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _TutorCard extends StatelessWidget {
  final ChatTutorModel tutor;
  final VoidCallback onTap;

  const _TutorCard({required this.tutor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.lightGreen,
              child: Text(
                tutor.shortName,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGreenDark,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tutor.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: tutor.hasUnreadMessage
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    tutor.subject,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tutor.hasUnreadMessage)
                  Container(
                    width: 10.w,
                    height: 10.w,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textLightGray,
                  size: 22.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
