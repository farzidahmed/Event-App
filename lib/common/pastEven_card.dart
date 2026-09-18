import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/ui_helpers.dart';

class PastEventWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String date;
  final String review;

  const PastEventWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + LOCATION OVERLAY
          Stack(
            children: [
              /// Background Image
              // ClipRRect(
              //   borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(16),
              //     topRight: Radius.circular(16),
              //   ),
              //   child: Image.network(
              //     imageUrl,
              //     height: 190,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              CustomNetworkImage(
                urls: imageUrl,
                height: 180.h,
                width: double.infinity,
                borderRadius: 16.r,
              ),

              /// Location Overlay (bottom left)
              Positioned(
                child: Container(
                  width: 400.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 40.h,
                  ),

                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.52, 0.77),
                      end: Alignment(0.52, 0.29),
                      colors: [
                        Colors.black.withValues(alpha: 0.50),
                        Colors.black.withValues(alpha: 0.30),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UIHelper.verticalSpace(50.h),

                          Text(
                            title,
                            style: TextFontStyle.headline18cffffroboto,
                          ),
                        ],
                      ),

                      // Row(
                      //   children: [
                      //     SvgPicture.asset(Assets.icons.location),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       location,
                      //       style: TextFontStyle.headline14w400c637381Montserrat
                      //           .copyWith(
                      //             color: AppColor.cFFFFFF,
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          UIHelper.verticalSpace(35.h),

                          SvgPicture.asset(Assets.icons.time),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: TextFontStyle.headline14w400c637381Montserrat
                                .copyWith(
                                  color: AppColor.cFFFFFF,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(Assets.images.fireIcon.path),
                          const SizedBox(width: 8),
                          Text(
                            review,
                            style: TextFontStyle.headline14w400c637381Montserrat
                                .copyWith(
                                  color: AppColor.cFFFFFF,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
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

          /// EVENT DETAILS
        ],
      ),
    );
  }
}
