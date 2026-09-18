import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/helpers_method.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.cFFFFFF),
          onPressed: () {
            NavigationService.goBack;
          },
        ),
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Enter the email used for your account.",
                  style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                  textAlign: TextAlign.center,
                ),

                UIHelper.verticalSpace(24.h),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Enter your email",
                    style: TextFontStyle.headline20w600cFFFFFFMontserrat,
                  ),
                ),

                UIHelper.verticalSpace(24.h),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Email",
                    style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                  ),
                ),

                UIHelper.verticalSpace(8.h),

                _emailWidget(),

                UIHelper.verticalSpace(36.h),

                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      NavigationService.navigateToWithArgs(
                        Routes.resetOtpVerifyScreen,
                        {'email': _emailController.text.trim()},
                      );
                    }
                  },
                  btnName: 'Continue',
                ),
                UIHelper.verticalSpace(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailWidget() {
    return CustomFormField(
      hintText: "Enter your Mail",
      controller: _emailController,
      textInputAction: TextInputAction.done,
      inputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email Required";
        }
        if (!emailRegex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (_formKey.currentState!.validate()) {
          NavigationService.navigateToWithArgs(Routes.resetOtpVerifyScreen, {
            'email': _emailController.text.trim(),
          });
        }
      },
    );
  }
}
