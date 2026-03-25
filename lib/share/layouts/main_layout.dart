import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/share/layouts/footer.dart';
import 'package:edu_match/share/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final LayoutType layoutType;
  final bool showHeader;
  final bool showFooter;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final PreferredSizeWidget? customHeader;
  final double headerHeight;

  /// Status bar background color (default: matches backgroundColor or white)
  final Color? statusBarColor;

  /// Icon brightness on status bar (dark = icons tối, light = icons sáng)
  final Brightness statusBarIconBrightness;

  /// Có dùng SafeArea hay không (fullscreen thường cần = true)
  final bool useSafeArea;

  const MainLayout({
    super.key,
    required this.child,
    this.layoutType = LayoutType.normal,
    this.showHeader = true,
    this.showFooter = true,
    this.padding,
    this.backgroundColor,
    this.customHeader,
    this.headerHeight = 185,
    this.statusBarColor,
    this.statusBarIconBrightness = Brightness.dark,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? 16.w : 24.w,
      vertical: isMobile ? 12.h : 16.h,
    );

    final effectiveBgColor = backgroundColor ?? Colors.white;
    final effectiveStatusBarColor = statusBarColor ?? effectiveBgColor;

    final overlayStyle = SystemUiOverlayStyle(
      statusBarColor: effectiveStatusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
    );

    if (layoutType == LayoutType.fullscreen) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          backgroundColor: effectiveBgColor,
          body: useSafeArea ? SafeArea(child: child) : child,
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: effectiveBgColor,
        appBar: showHeader ? (customHeader ?? Header()) : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildContent(defaultPadding, context),
                if (showFooter) const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(EdgeInsets defaultPadding, BuildContext context) {
    final effectivePadding = padding ?? defaultPadding;

    return Padding(
      padding: effectivePadding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: child,
      ),
    );
  }
}
