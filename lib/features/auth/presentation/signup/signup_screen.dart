import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/app_icons.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/helpers_method.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';
import 'package:llr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          "Sign Up",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Sign up now to begin an amazing journey",
                      style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                    ),

                    UIHelper.verticalSpace(32.h),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Name",
                        style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    _nameWidget(),

                    UIHelper.verticalSpace(12.h),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Email",
                        style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    _emailWidget(),

                    UIHelper.verticalSpace(12.h),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Password",
                        style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    _passWidget(provider),

                    UIHelper.verticalSpace(12.h),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Confirm password",
                        style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    _confPassWidget(provider),

                    UIHelper.verticalSpace(16.h),

                    _termsAndPrivacyAcceptWidget(provider),

                    UIHelper.verticalSpace(24.h),

                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (!provider.isChecked) {
                            ToastUtil.showErrorMessage(
                              "You must accept the terms and conditions to proceed.",
                            );
                            return;
                          }

                          log("Success");
                          singup(
                            _nameController.text.toString(),
                            _emailController.text.toString(),
                            _passController.text.toString(),
                            _confPassController.text.toString(),
                          );
                        }
                      },
                      btnName: "Sign Up",
                    ),

                    UIHelper.verticalSpace(38.h),

                    // Text(
                    //   "Or sign in with",
                    //   style: TextFontStyle.headline14w400cFFFFFFMontserrat,
                    // ),

                    // UIHelper.verticalSpace(12.h),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   spacing: 12.w,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         // Your onPressed code here
                    //       },
                    //       icon: SvgPicture.asset(Assets.icons.google),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {
                    //         // Your onPressed code here
                    //       },
                    //       icon: SvgPicture.asset(Assets.icons.apple),
                    //     ),
                    //   ],
                    // ),
                    UIHelper.verticalSpace(24.h),

                    _noAccountWidget(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  CustomFormField _nameWidget() {
    return CustomFormField(
      hintText: "Name",
      controller: _nameController,
      textInputAction: TextInputAction.next,
      inputType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name required";
        }

        return null;
      },
    );
  }

  CustomFormField _emailWidget() {
    return CustomFormField(
      hintText: "Email Address",
      controller: _emailController,
      textInputAction: TextInputAction.next,
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
    );
  }

  Widget _passWidget(AuthProvider provider) {
    return CustomFormField(
      hintText: "Password",
      controller: _passController,
      textInputAction: TextInputAction.next,
      isPass: true,
      isObsecure: provider.isPassVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password can not be left empty";
        }
        if (value.length < 8) {
          return "Minimum password length is 8";
        }
        return null;
      },
      suffixIcon: InkWell(
        onTap: () {
          provider.togglePassword();
        },
        child: SvgPicture.asset(
          provider.isPassVisible ? AppIcons.eyeClose : AppIcons.eye,
          width: 16.w,
        ),
      ),
    );
  }

  Widget _confPassWidget(AuthProvider provider) {
    return CustomFormField(
      hintText: "Confirm Password",
      controller: _confPassController,
      textInputAction: TextInputAction.done,
      isPass: true,
      isObsecure: provider.isPassConfirm,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Write your new password";
        }
        if (value != _passController.text) {
          return "Password and confirm password should be same.";
        }
        return null;
      },
      suffixIcon: InkWell(
        onTap: () {
          provider.toggleConfirmPassword();
        },
        child: SvgPicture.asset(
          provider.isPassConfirm ? AppIcons.eyeClose : AppIcons.eye,
          width: 16.w,
        ),
      ),
      onFieldSubmitted: (value) {
        if (_formKey.currentState!.validate()) {
          if (!provider.isChecked) {
            ToastUtil.showErrorMessage(
              "You must accept the terms and conditions to proceed.",
            );
            return;
          }

          log("Success");
          //NavigationService.navigateToReplacementUntil(Routes.navigationScreen);
        }
      },
    );
  }

  InkWell _termsAndPrivacyAcceptWidget(AuthProvider provider) {
    return InkWell(
      onTap: () {
        provider.toggleCheckBox();
      },
      child: Row(
        //spacing: 8.w,
        children: [
          Checkbox(
            checkColor: AppColor.cFFFFFF,
            activeColor: AppColor.c6944AB,
            side: BorderSide(color: AppColor.c6944AB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            value: provider.isChecked,
            onChanged: (value) {
              provider.toggleCheckBox();
            },
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I agree ",
                    style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                  ),
                  TextSpan(
                    text: "Privacy Policy & ",
                    style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.navigateTo(
                              Routes.privacyPolicyScreen,
                            );
                          },
                  ),

                  TextSpan(
                    text: "Terms of Conditions",
                    style: TextFontStyle.headline14w400cA7B0B9Montserrat,

                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.navigateTo(
                              Routes.termsAndConditionsScreen,
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noAccountWidget() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Already have an account? ",
            style: TextFontStyle.headline14w400cA7B0B9Montserrat,
          ),
          TextSpan(
            text: "SIGN IN",
            style: TextFontStyle.headline14w700cFFFFFFMontserrat.copyWith(
              color: AppColor.c6944AB,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    NavigationService.navigateToReplacementUntil(
                      Routes.loginScreen,
                    );
                  },
          ),
        ],
      ),
    );
  }

  void singup(
    String name,
    String email,
    String password,
    String confirmPass,
  ) async {
    await signupRXObj
        .signup(
          name: name,
          email: email,
          password: password,
          confirmPass: confirmPass,
        )
        .waitingForSucess()
        .then((success) {
          if (success) {
            NavigationService.navigateToWithArgs(Routes.verifyOtpScreen, {
              'email': _emailController.text.trim(),
            });
          }
        });
  }
}
