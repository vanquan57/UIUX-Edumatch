import 'package:edu_match/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.borderColor,
      highlightColor: AppColors.bgLight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

class TutorCardSkeleton extends StatelessWidget {
  const TutorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar skeleton
          SkeletonLoader(
            width: double.infinity,
            height: 120.h,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          // Content skeleton
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    width: 120.w,
                    height: 14.h,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  SizedBox(height: 8.h),
                  SkeletonLoader(
                    width: 80.w,
                    height: 12.h,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  SizedBox(height: 16.h),
                  SkeletonLoader(
                    width: 100.w,
                    height: 12.h,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  const Spacer(),
                  SkeletonLoader(
                    width: double.infinity,
                    height: 36.h,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnlineTutorItemSkeleton extends StatelessWidget {
  const OnlineTutorItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar skeleton
        SkeletonLoader(
          width: 80.w,
          height: 80.h,
          borderRadius: BorderRadius.circular(40.r),
        ),
        SizedBox(height: 8.h),
        // Name skeleton
        SkeletonLoader(
          width: 100.w,
          height: 12.h,
          borderRadius: BorderRadius.circular(6.r),
        ),
        SizedBox(height: 8.h),
        // Button skeleton
        SkeletonLoader(
          width: 100.w,
          height: 32.h,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ],
    );
  }
}
