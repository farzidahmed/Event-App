import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/app_icons.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPassController = TextEditingController();
  final _confPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _confPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reset Password",
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
                      "At least 9 characters, with uppercase and lowercase letters",
                      style: TextFontStyle.headline14w400cA7B0B9Montserrat,
                      textAlign: TextAlign.center,
                    ),

                    UIHelper.verticalSpace(32.h),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "New password",
                        style: TextFontStyle.headline14w500cDFE3E8Montserrat,
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    _newPassWidget(provider),

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

                    UIHelper.verticalSpace(24.h),

                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          NavigationService.navigateToReplacementUntil(
                            Routes.verificationCompleteScreen,
                          );
                        }
                      },
                      btnName: 'Reset password',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _newPassWidget(AuthProvider provider) {
    return CustomFormField(
      hintText: "New password",
      controller: _newPassController,
      textInputAction: TextInputAction.next,
      isPass: true,
      isObsecure: provider.isNewPassVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Write your new password";
        }
        if (value.length < 8) {
          return "Minimum password length is 8";
        }
        return null;
      },
      suffixIcon: InkWell(
        onTap: () {
          provider.toggleNewPassword();
        },
        child: SvgPicture.asset(
          provider.isNewPassVisible ? Assets.icons.eye : Assets.icons.eyeClose,
        ),
      ),
    );
  }

  Widget _confPassWidget(AuthProvider provider) {
    return CustomFormField(
      hintText: "Confirm new password",
      controller: _confPassController,
      textInputAction: TextInputAction.done,
      isPass: true,
      isObsecure: provider.isConfNewPassVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Write your new password";
        }
        if (value != _newPassController.text) {
          return "Password and confirm password should be same.";
        }
        return null;
      },
      suffixIcon: InkWell(
        onTap: () {
          provider.toggleConfNewPass();
        },
        child: SvgPicture.asset(
          provider.isConfNewPassVisible ? AppIcons.eye : AppIcons.eyeClose,
        ),
      ),
      onFieldSubmitted: (value) {
        if (_formKey.currentState!.validate()) {
          NavigationService.navigateToReplacementUntil(
            Routes.verificationCompleteScreen,
          );
        }
      },
    );
  }
}
