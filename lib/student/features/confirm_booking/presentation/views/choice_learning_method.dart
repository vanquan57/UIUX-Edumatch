import 'package:edu_match/core/config/app_theme_config.dart';
import 'package:edu_match/student/data/models/booking_model.dart';
import 'package:edu_match/student/data/models/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class ChoiceLearningMethodPage extends StatefulWidget {
  const ChoiceLearningMethodPage({super.key});

  @override
  State<ChoiceLearningMethodPage> createState() =>
      _ChoiceLearningMethodPageState();
}

class _ChoiceLearningMethodPageState extends State<ChoiceLearningMethodPage> {
  late BookingModel booking;
  late TutorModel mockTutor;
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Use mock tutor data for prototype
    mockTutor = TutorModel.mockTutors().first;
    booking = BookingModel(
      tutorId: mockTutor.id,
      tutorName: mockTutor.name,
      tutorAvatar: mockTutor.avatar,
      tutorSubjects: mockTutor.subjects,
      type: 'online',
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _onSelectType(String type) {
    setState(() {
      booking = booking.copyWith(type: type);
      if (type == 'online') {
        booking = booking.copyWith(address: null);
        _addressController.clear();
      }
    });
  }

  void _onAddressChanged(String value) {
    setState(() {
      booking = booking.copyWith(address: value);
    });
  }

  void _onMapPickerPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildMapPickerSheet(),
    );
  }

  void _onContinuePressed() {
    if (booking.type == 'offline' && (booking.address == null || booking.address!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập địa chỉ'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }

    // Navigate to next step (select date/time) - no data needed for prototype
    context.pushNamed('bookingSelectTimeSlot');
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return AppThemeConfig.isLowFidelityMode
        ? _buildLowFiLayout(colors)
        : _buildFullLayout();
  }

  Widget _buildLowFiLayout(AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tutor info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[TUTOR INFO]',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  mockTutor.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            'Chọn hình thức học',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textDark,
            ),
          ),
          SizedBox(height: 8.h),

          // Options
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _onSelectType('online'),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: booking.type == 'online' ? colors.textDark : colors.borderColor,
                        width: booking.type == 'online' ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: booking.type == 'online' ? colors.bgLight : colors.white,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.crop_square,
                          size: 20.sp,
                          color: colors.textLightGray,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Online',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.textDark,
                          ),
                        ),
                        Text(
                          'Video call',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => _onSelectType('offline'),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: booking.type == 'offline' ? colors.textDark : colors.borderColor,
                        width: booking.type == 'offline' ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: booking.type == 'offline' ? colors.bgLight : colors.white,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.crop_square,
                          size: 20.sp,
                          color: colors.textLightGray,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.textDark,
                          ),
                        ),
                        Text(
                          'Địa điểm',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Address section for offline
          if (booking.type == 'offline') ...[
            Text(
              'Địa chỉ dạy học',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                booking.address?.isEmpty ?? true ? '[NHẬP ĐỊA CHỈ]' : booking.address!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: booking.address?.isEmpty ?? true ? colors.textSecondary : colors.textDark,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '[CHỌN VỊ TRÍ TRÊN BẢN ĐỒ]',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Continue button
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: _onContinuePressed,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: colors.textDark, width: 1.5),
                borderRadius: BorderRadius.circular(4.r),
                color: colors.textDark,
              ),
              child: Center(
                child: Text(
                  'Tiếp tục',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    // Tutor info card
                    _buildTutorInfoCard(),
                    SizedBox(height: 32.h),

                    // Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chọn hình thức học',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppThemeConfig.colors.textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Xác định loại session: Online (video call) hoặc Offline (địa điểm)',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppThemeConfig.colors.textGray,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Option Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildOptionCard(
                            title: 'Online',
                            description: 'Video call',
                            icon: Icons.videocam_outlined,
                            isSelected: booking.type == 'online',
                            onTap: () => _onSelectType('online'),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildOptionCard(
                            title: 'Offline',
                            description: 'Địa điểm',
                            icon: Icons.location_on_outlined,
                            isSelected: booking.type == 'offline',
                            onTap: () => _onSelectType('offline'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // Address input (show when offline is selected)
                    if (booking.type == 'offline') ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Địa chỉ dạy học',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppThemeConfig.colors.textDark,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildAddressInput(),
                      SizedBox(height: 16.h),
                      _buildMapPickerButton(),
                    ],
                    SizedBox(height: 120.h), // Space for sticky button
                  ],
                ),
              ),
            ],
          ),
        ),

        // Sticky Continue Button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildStickyButton(),
        ),
      ],
    );
  }

  Widget _buildTutorInfoCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.bgLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppThemeConfig.colors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppThemeConfig.colors.primaryGreen,
            ),
            child: ClipOval(
              child: Image.asset(
                mockTutor.avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppThemeConfig.colors.primaryGreen,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: AppThemeConfig.colors.white,
                        size: 28.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mockTutor.name,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppThemeConfig.colors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AppThemeConfig.colors.warningOrange,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${mockTutor.rating} (${mockTutor.reviewCount} đánh giá)',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppThemeConfig.colors.textGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppThemeConfig.colors.lightGreen : AppThemeConfig.colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppThemeConfig.colors.primaryGreen : AppThemeConfig.colors.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppThemeConfig.colors.primaryGreen
                    : AppThemeConfig.colors.bgLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppThemeConfig.colors.white : AppThemeConfig.colors.textGray,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppThemeConfig.colors.textDark,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppThemeConfig.colors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressInput() {
    return TextFormField(
      controller: _addressController,
      onChanged: _onAddressChanged,
      decoration: InputDecoration(
        hintText: 'Nhập địa chỉ dạy học',
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppThemeConfig.colors.textLightGray,
        ),
        prefixIcon: Icon(
          Icons.location_on_outlined,
          color: AppThemeConfig.colors.textGray,
          size: 20.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppThemeConfig.colors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppThemeConfig.colors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppThemeConfig.colors.primaryGreen, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        filled: true,
        fillColor: AppThemeConfig.colors.white,
      ),
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppThemeConfig.colors.textDark,
      ),
    );
  }

  Widget _buildMapPickerButton() {
    return GestureDetector(
      onTap: _onMapPickerPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppThemeConfig.colors.bgLight,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppThemeConfig.colors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              color: AppThemeConfig.colors.primaryGreen,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Chọn vị trí trên bản đồ',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppThemeConfig.colors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeConfig.colors.white,
        border: Border(
          top: BorderSide(color: AppThemeConfig.colors.dividerColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppThemeConfig.colors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: GestureDetector(
        onTap: _onContinuePressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: AppThemeConfig.colors.primaryGreen,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              'Tiếp tục',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppThemeConfig.colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Map Picker Sheet
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildMapPickerSheet() {
    double mapLatitude = booking.latitude ?? 16.0544;
    double mapLongitude = booking.longitude ?? 108.2022;
    final mapController = MapController();
    final latController = TextEditingController(text: mapLatitude.toStringAsFixed(6));
    final lngController = TextEditingController(text: mapLongitude.toStringAsFixed(6));

    return StatefulBuilder(
      builder: (context, setMapState) {
        void onMapTap(LatLng point) {
          setMapState(() {
            mapLatitude = point.latitude;
            mapLongitude = point.longitude;
            latController.text = mapLatitude.toStringAsFixed(6);
            lngController.text = mapLongitude.toStringAsFixed(6);
          });
        }

        void updateFromLatInput(String value) {
          if (value.isNotEmpty) {
            try {
              final newLat = double.parse(value);
              setMapState(() {
                mapLatitude = newLat;
                mapController.move(LatLng(mapLatitude, mapLongitude), 13);
              });
            } catch (_) {
              // Invalid input, ignore
            }
          }
        }

        void updateFromLngInput(String value) {
          if (value.isNotEmpty) {
            try {
              final newLng = double.parse(value);
              setMapState(() {
                mapLongitude = newLng;
                mapController.move(LatLng(mapLatitude, mapLongitude), 13);
              });
            } catch (_) {
              // Invalid input, ignore
            }
          }
        }

        void onConfirm() {
          setState(() {
            booking = booking.copyWith(
              latitude: mapLatitude,
              longitude: mapLongitude,
            );
          });
          Navigator.pop(context);
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppThemeConfig.colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppThemeConfig.colors.dividerColor, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Chọn vị trí trên bản đồ',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppThemeConfig.colors.textDark,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            color: AppThemeConfig.colors.textGray,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Map
                  Expanded(
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            initialCenter: LatLng(mapLatitude, mapLongitude),
                            initialZoom: 13,
                            onTap: (tapPosition, point) => onMapTap(point),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                              subdomains: const ['a', 'b', 'c', 'd'],
                              userAgentPackageName: 'com.example.app',
                              maxZoom: 19,
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(mapLatitude, mapLongitude),
                                  width: 40.w,
                                  height: 40.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppThemeConfig.colors.primaryGreen,
                                      border: Border.all(
                                        color: AppThemeConfig.colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: AppThemeConfig.colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Instruction overlay
                        Positioned(
                          top: 12.h,
                          left: 12.w,
                          right: 12.w,
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppThemeConfig.colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppThemeConfig.colors.borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: AppThemeConfig.colors.shadowColor,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Nhấn vào bản đồ để chọn vị trí',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppThemeConfig.colors.primaryGreen,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Coordinates Input
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppThemeConfig.colors.dividerColor, width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tọa độ',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppThemeConfig.colors.textDark,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Latitude Input
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vĩ độ (Latitude)',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppThemeConfig.colors.textGray,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  TextFormField(
                                    controller: latController,
                                    onChanged: updateFromLatInput,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: true,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '-90 đến 90',
                                      hintStyle: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppThemeConfig.colors.textLightGray,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.borderColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.borderColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.primaryGreen,
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      filled: true,
                                      fillColor: AppThemeConfig.colors.white,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppThemeConfig.colors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),

                            // Longitude Input
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kinh độ (Longitude)',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppThemeConfig.colors.textGray,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  TextFormField(
                                    controller: lngController,
                                    onChanged: updateFromLngInput,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: true,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '-180 đến 180',
                                      hintStyle: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppThemeConfig.colors.textLightGray,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.borderColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.borderColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: AppThemeConfig.colors.primaryGreen,
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      filled: true,
                                      fillColor: AppThemeConfig.colors.white,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppThemeConfig.colors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Confirm Button
                        GestureDetector(
                          onTap: onConfirm,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: AppThemeConfig.colors.primaryGreen,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                'Xác nhận',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppThemeConfig.colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
