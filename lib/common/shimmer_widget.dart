import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GenericShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const GenericShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2C2C2E),
      highlightColor: const Color(0xFF3A3A3C),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class AlbumGridShimmer extends StatelessWidget {
  const AlbumGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 180.dg,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GenericShimmer(
              width: double.infinity,
              height: 108.h,
              borderRadius: 14,
            ),
            SizedBox(height: 8.h),
            GenericShimmer(width: 100.w, height: 12.h),
            SizedBox(height: 4.h),
            GenericShimmer(width: 60.w, height: 10.h),
          ],
        );
      },
    );
  }
}

class FestivalListShimmer extends StatelessWidget {
  const FestivalListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericShimmer(
                width: double.infinity,
                height: 160.h,
                borderRadius: 16,
              ),
              SizedBox(height: 12.h),
              GenericShimmer(width: 200.w, height: 18.h),
              SizedBox(height: 8.h),
              GenericShimmer(width: 150.w, height: 14.h),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GenericShimmer(width: 80.w, height: 24.h, borderRadius: 12),
                  GenericShimmer(width: 40.w, height: 14.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericShimmer(width: double.infinity, height: 256.h, borderRadius: 0),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: GenericShimmer(
            width: double.infinity,
            height: 90.h,
            borderRadius: 14,
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            SizedBox(width: 18.w),
            GenericShimmer(width: 100.w, height: 18.h),
          ],
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (context, index) {
              return Container(
                width: 133.w,
                margin: EdgeInsets.only(right: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GenericShimmer(
                      width: 64.w,
                      height: 64.h,
                      borderRadius: 100,
                    ),
                    SizedBox(height: 8.h),
                    GenericShimmer(width: 80.w, height: 12.h),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChatListShimmer extends StatelessWidget {
  const ChatListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: Row(
            children: [
              GenericShimmer(width: 40.w, height: 40.h, borderRadius: 100),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GenericShimmer(width: 120.w, height: 14.h),
                    SizedBox(height: 6.h),
                    GenericShimmer(width: 200.w, height: 12.h),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              GenericShimmer(width: 40.w, height: 10.h),
            ],
          ),
        );
      },
    );
  }
}

class FriendListShimmer extends StatelessWidget {
  const FriendListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF212B36),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              GenericShimmer(width: 48.w, height: 48.h, borderRadius: 100),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GenericShimmer(width: 100.w, height: 14.h),
                    SizedBox(height: 6.h),
                    GenericShimmer(width: 60.w, height: 12.h),
                  ],
                ),
              ),
              GenericShimmer(width: 24.w, height: 24.h, borderRadius: 4),
            ],
          ),
        );
      },
    );
  }
}

class GenericListShimmer extends StatelessWidget {
  final int itemCount;
  const GenericListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: GenericShimmer(
            width: double.infinity,
            height: 50.h,
            borderRadius: 12,
          ),
        );
      },
    );
  }
}

class PastFestivalShimmer extends StatelessWidget {
  const PastFestivalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericShimmer(width: double.infinity, height: 160.h, borderRadius: 16),
        SizedBox(height: 16.h),
        GenericShimmer(width: double.infinity, height: 80.h, borderRadius: 12),
        SizedBox(height: 24.h),
        GenericShimmer(width: 100.w, height: 20.h),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF212B36),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  GenericShimmer(width: 40.w, height: 40.h, borderRadius: 100),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GenericShimmer(width: 120.w, height: 14.h),
                        SizedBox(height: 6.h),
                        GenericShimmer(width: 180.w, height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
