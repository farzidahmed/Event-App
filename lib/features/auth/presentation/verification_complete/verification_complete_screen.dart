import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/app_icons.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';

class VerificationCompleteScreen extends StatelessWidget {
  const VerificationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.verificationComplete),
              UIHelper.verticalSpace(8.h),
              Text(
                "Verification Complete",
                style: TextFontStyle.headline20w600cFFFFFFMontserrat,
              ),
              Text(
                "Your account has been successfully verified. You'll be redirected to your account in just a moment.",
                style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                onTap: () {
                  NavigationService.navigateToReplacementUntil(
                    Routes.setUpProfileScreen,
                  );
                },
                btnName: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
