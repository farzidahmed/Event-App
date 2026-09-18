import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleImage;
  final String? titleText;
  final String? sufixImage;
  final String? settingIcon;
  const CustomAppBar({
    super.key,
    this.titleImage,
    this.titleText,
    this.sufixImage,
    this.settingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: purple music icon + title
            Row(
              children: [
                Container(
                  height: 38.w,
                  width: 38.h,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(titleImage.toString()),
                ),
                const SizedBox(width: 10),
                Text(
                  titleText ?? "",
                  style: TextFontStyle.headline24w400cFFFFFFMontserrat.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            // Right side: search icon
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.notificationScreen);
                  },
                  child: Image.asset(
                    sufixImage.toString(),
                    width: 25.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.userProfileScreen);
                  },
                  child: Image.asset(
                    settingIcon.toString(),
                    width: 25.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}
