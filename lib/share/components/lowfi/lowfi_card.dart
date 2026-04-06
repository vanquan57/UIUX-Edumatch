import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/config/app_theme_config.dart';

/// Low-Fidelity Card Component
/// Provides wireframe-style cards with minimal styling
class LowFiCard extends StatelessWidget {
  const LowFiCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.elevation = 0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    Widget cardWidget = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.white,
        border: Border.all(
          color: borderColor ?? colors.borderColor,
          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(
          AppThemeConfig.isLowFidelityMode ? 4.r : 8.r,
        ),
        boxShadow: AppThemeConfig.isLowFidelityMode 
            ? null 
            : elevation > 0 
                ? [
                    BoxShadow(
                      color: colors.shadowColor,
                      blurRadius: elevation * 2,
                      offset: Offset(0, elevation),
                    ),
                  ]
                : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}

/// Low-Fidelity Image Placeholder
class LowFiImagePlaceholder extends StatelessWidget {
  const LowFiImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.icon = Icons.image_outlined,
    this.text,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final IconData icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppThemeConfig.isLowFidelityMode 
            ? colors.bgLight 
            : colors.borderColor,
        border: AppThemeConfig.isLowFidelityMode 
            ? Border.all(
                color: colors.borderColor,
                width: 1.5,
              )
            : null,
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24.sp,
            color: colors.textLightGray,
          ),
          if (text != null) ...[
            SizedBox(height: 4.h),
            Text(
              text!,
              style: TextStyle(
                fontSize: 10.sp,
                color: colors.textLightGray,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Low-Fidelity Avatar Component
class LowFiAvatar extends StatelessWidget {
  const LowFiAvatar({
    super.key,
    this.size = 40,
    this.name,
    this.imageUrl,
    this.backgroundColor,
  });

  final double size;
  final String? name;
  final String? imageUrl;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.bgLight,
        border: Border.all(
          color: colors.borderColor,
          width: AppThemeConfig.isLowFidelityMode ? 1.5 : 1,
        ),
        shape: BoxShape.circle,
      ),
      child: AppThemeConfig.isLowFidelityMode
          ? Icon(
              Icons.person_outline,
              size: size * 0.5,
              color: colors.textLightGray,
            )
          : (imageUrl != null
              ? ClipOval(
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.person,
                      size: size * 0.5,
                      color: colors.textLightGray,
                    ),
                  ),
                )
              : Icon(
                  Icons.person,
                  size: size * 0.5,
                  color: colors.textLightGray,
                )),
    );
  }
}

/// Low-Fidelity Rating Display
class LowFiRating extends StatelessWidget {
  const LowFiRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16,
    this.showNumber = true,
  });

  final double rating;
  final int maxRating;
  final double size;
  final bool showNumber;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeConfig.colors;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (AppThemeConfig.isLowFidelityMode) ...[
          // Low-fi: Just show rating number with star outline
          Icon(
            Icons.star_outline,
            size: size,
            color: colors.textSecondary,
          ),
          SizedBox(width: 4.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.8,
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ] else ...[
          // Full design: Show star rating
          ...List.generate(maxRating, (index) {
            return Icon(
              index < rating.floor()
                  ? Icons.star
                  : index < rating
                      ? Icons.star_half
                      : Icons.star_border,
              size: size,
              color: Colors.amber,
            );
          }),
          if (showNumber) ...[
            SizedBox(width: 4.w),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: size * 0.8,
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ],
    );
  }
}