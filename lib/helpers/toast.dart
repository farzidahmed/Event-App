import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';

final class ToastUtil {
  ToastUtil._();

  static void showErrorMessage(String message) {
    Get.snackbar(
      titleText: Text(
        "Warning",
        style: TextFontStyle.headline20w600cDFE3E8Montserrat,
      ),
      messageText: Text(message, style: TextFontStyle.headline16cffffroboto),
      "",
      message,
      backgroundColor: Colors.red,
      borderRadius: 26.r,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 12.h),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showSuccessMessage(String message) {
    Get.snackbar(
      titleText: Text(
        "Successful",
        style: TextFontStyle.headline20w600cDFE3E8Montserrat.copyWith(
          color: AppColor.cEDF1F8,
        ),
      ),
      messageText: Text(message, style: TextFontStyle.headline16cffffroboto),
      "",
      message,
      backgroundColor: AppColor.cEDF1F8,
      borderRadius: 26.r,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 10.h),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showShortToast(String message) {
    Fluttertoast.showToast(msg: message.tr, toastLength: Toast.LENGTH_SHORT);
  }

  static void showLongToast(String message) {
    String trn = message.tr;
    Fluttertoast.showToast(msg: trn, toastLength: Toast.LENGTH_LONG);
  }

  static void showSuccess(String s) {}
}
