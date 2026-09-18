import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/ui_helpers.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ✅ Centered Image (does not move)
          Center(
            child: SvgPicture.asset(
              Assets.icons.a404Error,
              width: 200.w,
              height: 200.w,
              fit: BoxFit.contain,
            ),
          ),

          // ✅ Text + Button Section (positioned near bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sorry, page not found!",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline14w400c637381Montserrat
                        .copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.cFFFFFF,
                        ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 39.h),
                    child: Text(
                      "404 – Page not found. Check the URL and try again.",
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline14w400c637381Montserrat
                          .copyWith(color: AppColor.cA7B0B9, fontSize: 14.sp),
                    ),
                  ),
                  UIHelper.verticalSpace(170.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B61FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back to Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
