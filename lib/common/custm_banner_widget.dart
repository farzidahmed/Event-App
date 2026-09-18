import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/gen/assets.gen.dart';

class BannerWidgetScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String date;
  final String review;

  const BannerWidgetScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE + OVERLAY
        SizedBox(
          height: 150.h,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child:
                //  Image.network(
                //   imageUrl,
                //   width: 235.w,
                //   fit: BoxFit.cover,
                // ),
                CustomNetworkImage(
                  urls: imageUrl,
                  width: 235.w,
                  //  fit: BoxFit.cover,
                ),
              ),

              //Positioned(child: SvgPicture.asset(Assets.icons.heart)),

              /// GRADIENT & DETAILS
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.black.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      /// Location
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.location, height: 14.h),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      /// Date
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.time, height: 14.h),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              date,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      /// Review
                      Row(
                        children: [
                          Image.asset(
                            Assets.images.fireIcon.path,
                            height: 16.h,
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Text(
                              review,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
