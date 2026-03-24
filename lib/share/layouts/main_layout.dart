import 'package:edu_match/core/config/constant.dart';
import 'package:edu_match/share/layouts/footer.dart';
import 'package:edu_match/share/layouts/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  const MainLayout({
    required this.child,
    this.layoutType = LayoutType.normal,
    this.showHeader = true,
    this.showFooter = true,
    this.padding,
    this.backgroundColor,
    this.customHeader,
    this.headerHeight = 185,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? 16.w : 24.w,
      vertical: isMobile ? 12.h : 16.h,
    );

    if (layoutType == LayoutType.fullscreen) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(child: child),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
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
