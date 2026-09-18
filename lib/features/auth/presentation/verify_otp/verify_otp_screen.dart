import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int seconds = 60;
  Key countdownKey = UniqueKey();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          "Verification",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "We send you a verification code to abcd@.com. Please click this link to confirm your email address.",
                style: TextFontStyle.headline14w400cA7B0B9Montserrat,
              ),

              UIHelper.verticalSpace(24.h),

              _otpFieldWidget(),

              UIHelper.verticalSpace(24.h),

              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    verifyOtp(widget.email, _otpController.text);
                  }
                },
                btnName: 'Continue',
              ),

              UIHelper.verticalSpace(24.h),

              _expiredTextWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _expiredTextWidget() {
    return seconds == 0
        ? InkWell(
          onTap: () {
            log("Resend Code");
            setState(() {
              seconds = 60;
            });
            // Call your resend code logic here
          },
          child: Text(
            "Resend Code",
            style: TextFontStyle.headline14w400cA7B0B9Montserrat,
          ),
        )
        : Row(
          mainAxisSize: MainAxisSize.min,
          //spacing: 8.w,
          children: [
            Text(
              "This code will expire in",
              style: TextFontStyle.headline14w400cA7B0B9Montserrat,
            ),
            SlideCountdown(
              key: countdownKey,
              duration: Duration(seconds: seconds),
              decoration: BoxDecoration(color: Colors.transparent),
              style: TextFontStyle.headline14w400cA7B0B9Montserrat,
              onDone: () {
                setState(() {
                  seconds = 0;
                });
              },
            ),
            Text("sec", style: TextFontStyle.headline14w400cA7B0B9Montserrat),
          ],
        );
  }

  Widget _otpFieldWidget() {
    return Pinput(
      controller: _otpController,
      length: 4,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your 4 digit otp code";
        }
        return null;
      },
      // preFilledWidget: Text(
      //   "-",
      //   style: TextFontStyle.headline20w400CFFFFFFPoppins.copyWith(
      //     color: AppColors.cB0B2BB,
      //   ),
      // ),
      defaultPinTheme: PinTheme(
        width: 72.w,
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        textStyle: TextStyle(
          color: const Color(0xFFDFE3E8),
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent, // color for empty cells
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 1.w,
            color: AppColor.c212B36, // Default border color
          ),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 72.w,
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        textStyle: TextStyle(
          color: const Color(0xFFDFE3E8),
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent, // color for filled cells
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 1.w,
            color: AppColor.c212B36, // Default border color
          ),
        ),
      ),

      //
      onCompleted: (pin) => log('Completed: $pin'),
      onChanged: (value) {
        log('Changed: $value');
      },
    );
  }

  void verifyOtp(String email, String otp) async {
    await verifyOtpRxObj
        .sendOtp(email: email, otp: otp)
        .waitingForSucess()
        .then((success) {
          NavigationService.navigateToReplacementUntil(
            Routes.verificationCompleteScreen,
          );
        });
  }
}
