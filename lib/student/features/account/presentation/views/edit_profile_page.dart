import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();
  
  String _selectedGender = 'Nam';
  DateTime? _selectedBirthDate;
  String _selectedProvince = 'TP. Hồ Chí Minh';
  String _selectedWard = 'Phường Bến Nghé';
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Fake data - trong thực tế sẽ load từ API hoặc local storage
    _nameController.text = 'Nguyễn Văn An';
    _emailController.text = 'nguyenvanan@gmail.com';
    _phoneController.text = '0987654321';
    _addressController.text = 'Số 123, Đường ABC';
    _bioController.text = 'Tôi là học sinh lớp 12, đam mê học tập và khám phá kiến thức mới.';
    _selectedBirthDate = DateTime(2005, 6, 15);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header
        _buildCustomHeader(context),
        
        Divider(height: 1.h, color: AppColors.dividerColor),
        
        // Form content
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar section
                _buildAvatarSection(),
                
                SizedBox(height: 32.h),
                
                // Personal information
                _buildPersonalInfoSection(),
                
                SizedBox(height: 24.h),
                
                // Contact information
                _buildContactInfoSection(),
                
                SizedBox(height: 24.h),
                
                // Bio section
                _buildBioSection(),
                
                SizedBox(height: 40.h),
                
                // Save button
                _buildSaveButton(),
                
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDark,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Chỉnh sửa hồ sơ',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage('assets/images/have_login.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Thay đổi ảnh đại diện',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin cá nhân'),
        SizedBox(height: 16.h),
        
        // Full name
        _buildTextFormField(
          controller: _nameController,
          label: 'Họ và tên',
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập họ và tên';
            }
            return null;
          },
        ),
        
        SizedBox(height: 16.h),
        
        // Gender
        _buildGenderField(),
        
        SizedBox(height: 16.h),
        
        // Birth date
        _buildBirthDateField(),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin liên hệ'),
        SizedBox(height: 16.h),
        
        // Email
        _buildTextFormField(
          controller: _emailController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Email không hợp lệ';
            }
            return null;
          },
        ),
        
        SizedBox(height: 16.h),
        
        // Phone
        _buildTextFormField(
          controller: _phoneController,
          label: 'Số điện thoại',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
              return 'Số điện thoại không hợp lệ';
            }
            return null;
          },
        ),
        
        SizedBox(height: 16.h),
        
        // Address detail
        _buildTextFormField(
          controller: _addressController,
          label: 'Địa chỉ chi tiết',
          icon: Icons.location_on_outlined,
          hintText: 'Số nhà, tên đường...',
        ),
        
        SizedBox(height: 16.h),
        
        // Ward
        _buildWardField(),
        
        SizedBox(height: 16.h),
        
        // Province
        _buildProvinceField(),
      ],
    );
  }

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Giới thiệu bản thân'),
        SizedBox(height: 16.h),
        
        _buildTextFormField(
          controller: _bioController,
          label: 'Mô tả về bản thân',
          icon: Icons.description_outlined,
          maxLines: 4,
          hintText: 'Hãy chia sẻ về bản thân, sở thích và mục tiêu học tập của bạn...',
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primaryGreen, size: 20.sp),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textGray,
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textLightGray,
        ),
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
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới tính',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Icon(Icons.person_outline, color: AppColors.primaryGreen, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGender,
                      dropdownColor: AppColors.white,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                      items: ['Nam', 'Nữ', 'Khác'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textDark,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBirthDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngày sinh',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _selectBirthDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: AppColors.primaryGreen, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _selectedBirthDate != null
                        ? '${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
                        : 'Chọn ngày sinh',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: _selectedBirthDate != null ? AppColors.textDark : AppColors.textLightGray,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: AppColors.textGray, size: 20.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWardField() {
    List<String> wards;
    
    if (_selectedProvince == 'TP. Hồ Chí Minh') {
      wards = [
        'Phường Bến Nghé',
        'Phường Bến Thành',
        'Phường Cầu Kho',
        'Phường Cầu Ông Lãnh',
        'Phường Cô Giang',
        'Phường Đa Kao',
        'Phường Nguyễn Cư Trinh',
        'Phường Nguyễn Thái Bình',
        'Phường Phạm Ngũ Lão',
        'Phường Tân Định',
      ];
    } else if (_selectedProvince == 'Hà Nội') {
      wards = [
        'Phường Trung tâm',
        'Phường Hàng Bài',
        'Phường Hàng Bồ',
        'Phường Hàng Gai',
        'Phường Hoàn Kiếm',
        'Phường Lý Thái Tổ',
        'Phường Phan Chu Trinh',
        'Phường Tràng Tiền',
      ];
    } else {
      wards = [
        'Phường Trung tâm',
        'Phường 1',
        'Phường 2',
        'Phường 3',
        'Xã Tân An',
        'Xã Tân Bình',
        'Xã Tân Phú',
      ];
    }
    
    // Ensure selected ward exists in current province's wards
    if (!wards.contains(_selectedWard)) {
      _selectedWard = wards.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phường/Xã',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Icon(Icons.location_city_outlined, color: AppColors.primaryGreen, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedWard,
                      dropdownColor: AppColors.white,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedWard = newValue!;
                        });
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                      items: wards.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textDark,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProvinceField() {
    final provinces = [
      'TP. Hồ Chí Minh',
      'Hà Nội',
      'Đà Nẵng',
      'Hải Phòng',
      'Cần Thơ',
      'An Giang',
      'Bà Rịa - Vũng Tàu',
      'Bắc Giang',
      'Bắc Kạn',
      'Bạc Liêu',
      'Bắc Ninh',
      'Bến Tre',
      'Bình Định',
      'Bình Dương',
      'Bình Phước',
      'Bình Thuận',
      'Cà Mau',
      'Cao Bằng',
      'Đắk Lắk',
      'Đắk Nông',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tỉnh/Thành phố',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Icon(Icons.map_outlined, color: AppColors.primaryGreen, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedProvince,
                      dropdownColor: AppColors.white,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedProvince = newValue!;
                          // Reset ward when province changes
                          if (newValue == 'TP. Hồ Chí Minh') {
                            _selectedWard = 'Phường Bến Nghé';
                          } else if (newValue == 'Hà Nội') {
                            _selectedWard = 'Phường Trung tâm';
                          } else {
                            _selectedWard = 'Phường Trung tâm';
                          }
                        });
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                      items: provinces.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textDark,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Lưu thay đổi',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: AppColors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Hiển thị loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryGreen,
          ),
        ),
      );

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Đóng loading
        
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cập nhật hồ sơ thành công!',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.successGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            margin: EdgeInsets.all(16.w),
          ),
        );
        
        // Quay lại trang trước
        context.pop();
      });
    }
  }
}