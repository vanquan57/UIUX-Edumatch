import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/config/app_theme_config.dart';

/// Low-Fidelity Button Component
/// Provides wireframe-style buttons with minimal styling
class LowFiButton extends StatelessWidget {
  const LowFiButton({
    super.key,
    required this.text,
    this.onTap,
    this.type = LowFiButtonType.primary,
    this.size = LowFiButtonSize.medium,
    this.width,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
  });

  final String text;
  final VoidCallback? onTap;
  final LowFiButtonType type;
  final LowFiButtonSize size;
  final double? width;
  final bool isEnabled;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return GestureDetector(
      onTap: (isEnabled && !isLoading) ? onTap : null,
      child: Container(
        width: width,
        padding: _getPadding(),
        decoration: BoxDecoration(
          color: _getBackgroundColor(colors),
          border: Border.all(
            color: _getBorderColor(colors),
            width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(
            AppThemeConfig.isLowFidelityMode ? 4.r : 8.r,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !isLoading) ...[
              Icon(
                icon,
                size: _getIconSize(),
                color: _getTextColor(colors),
              ),
              SizedBox(width: 8.w),
            ],
            if (isLoading) ...[
              SizedBox(
                width: _getIconSize(),
                height: _getIconSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(colors),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: _getFontSize(),
                fontWeight: _getFontWeight(),
                color: _getTextColor(colors),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case LowFiButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
      case LowFiButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
      case LowFiButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h);
    }
  }

  double _getFontSize() {
    switch (size) {
      case LowFiButtonSize.small:
        return 12.sp;
      case LowFiButtonSize.medium:
        return 14.sp;
      case LowFiButtonSize.large:
        return 16.sp;
    }
  }

  double _getIconSize() {
    switch (size) {
      case LowFiButtonSize.small:
        return 16.sp;
      case LowFiButtonSize.medium:
        return 18.sp;
      case LowFiButtonSize.large:
        return 20.sp;
    }
  }

  FontWeight _getFontWeight() {
    return type == LowFiButtonType.primary 
        ? FontWeight.w600 
        : FontWeight.w500;
  }

  Color _getBackgroundColor(AppColorScheme colors) {
    if (!isEnabled) return colors.disabledGray;
    
    switch (type) {
      case LowFiButtonType.primary:
        return AppThemeConfig.isLowFidelityMode 
            ? colors.white 
            : colors.primaryGreen;
      case LowFiButtonType.secondary:
        return colors.white;
      case LowFiButtonType.outline:
        return Colors.transparent;
      case LowFiButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(AppColorScheme colors) {
    if (!isEnabled) return colors.borderColor;
    
    switch (type) {
      case LowFiButtonType.primary:
        return AppThemeConfig.isLowFidelityMode 
            ? colors.textDark 
            : colors.primaryGreen;
      case LowFiButtonType.secondary:
        return colors.borderColor;
      case LowFiButtonType.outline:
        return colors.textDark;
      case LowFiButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor(AppColorScheme colors) {
    if (!isEnabled) return colors.textLightGray;
    
    switch (type) {
      case LowFiButtonType.primary:
        return AppThemeConfig.isLowFidelityMode 
            ? colors.textDark 
            : colors.white;
      case LowFiButtonType.secondary:
        return colors.textDark;
      case LowFiButtonType.outline:
        return colors.textDark;
      case LowFiButtonType.text:
        return colors.primaryGreen;
    }
  }
}

enum LowFiButtonType {
  primary,
  secondary,
  outline,
  text,
}

enum LowFiButtonSize {
  small,
  medium,
  large,
}