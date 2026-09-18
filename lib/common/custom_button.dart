import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnName;
  final TextStyle? textStyle;
  final double? borderRadius;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnName,
    this.textStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: GradientColor.primaryGradient,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 99.r),
          ),
        ),
        child: Text(
          btnName,
          style: textStyle ?? TextFontStyle.headline16w700cFFFFFFMontserrat,
        ),
      ),
    );
  }
}
