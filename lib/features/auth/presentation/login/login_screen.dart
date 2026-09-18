import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/app_icons.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/helpers_method.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';
import 'package:llr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          "Sign In",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  // spacing: 14.h,
                  children: [
                    Text(
                      "Sign in now to begin an amazing journey",
                      style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                    ),
                    UIHelper.verticalSpace(32.h),

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
                    _passwordWidget(provider),

                    UIHelper.verticalSpace(16.h),

                    _forgotPasswordWidget(),
                    UIHelper.verticalSpace(24.h),

                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          log("Success");
                          login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      btnName: 'Sign In',
                    ),

                    UIHelper.verticalSpace(40.h),

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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _noAccountWidget() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account? ",
            style: TextFontStyle.headline14w400cA7B0B9Montserrat,
          ),
          TextSpan(
            text: "SIGN UP",
            style: TextFontStyle.headline14w700cFFFFFFMontserrat.copyWith(
              color: AppColor.c6944AB,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    NavigationService.navigateToReplacementUntil(
                      Routes.signupScreen,
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordWidget() {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.forgetPasswordScreen);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forgot Password",
          style: TextFontStyle.headline14w700cFFFFFFMontserrat.copyWith(
            foreground:
                Paint()
                  ..shader = GradientColor.primaryGradient.createShader(
                    const Rect.fromLTWH(0, 0, 150, 20),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _passwordWidget(AuthProvider provider) {
    return CustomFormField(
      hintText: "Password",
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      isPass: true,
      isObsecure: provider.isPassVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password can not be left empty";
        } else if (value.length < 8) {
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
        ),
      ),
      onFieldSubmitted: (value) {
        if (_formKey.currentState!.validate()) {
          log("Success");
          //NavigationService.navigateToReplacementUntil(Routes.navigationScreen);
        }
      },
    );
  }

  Widget _emailWidget() {
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

  void login(String email, String password) async {
    await loginRXObj
        .login(email: email, password: password)
        .waitingForSucess()
        .then((success) {
          NavigationService.navigateToReplacementUntil(Routes.navigationScreen);
        });
  }
}
