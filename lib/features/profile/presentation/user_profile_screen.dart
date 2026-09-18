// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/constants/color.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/helpers_method.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: use_full_hex_values_for_flutter_colors
      backgroundColor: Color(0xff0E0F11),
      appBar: AppBar(
        backgroundColor: Color(0xff0E0F11),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: StreamBuilder<UserDetailsModel>(
          stream: userDetailsRxObj.allAlumbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProfileHeaderShimmer();
            } else if (snapshot.hasData) {
              UserDetailsModel? model = snapshot.data;
              var data = model?.data;
              var userName = data?.name ?? "";
              var bio = data?.bio ?? "";
              var avtar = data?.avatar ?? "";
              return Column(
                children: [
                  // UIHelper.verticalSpace(55.h),
                  // GestureDetector(
                  //   onTap: () {
                  //     NavigationService.goBack;
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.topLeft,

                  //     child: SvgPicture.asset(Assets.icons.leftModel),
                  //   ),
                  // ),

                  /// Profile Image
                  // CircleAvatar(
                  //   radius: 55.r,
                  //   backgroundColor: Colors.deepOrangeAccent.withValues(
                  //     alpha: 0.60,
                  //   ),
                  //   child: CircleAvatar(
                  //     radius: 52.r,
                  //     backgroundImage: , // replace
                  //   ),
                  // ),
                  CustomNetworkImage(
                    urls: avtar,
                    borderRadius: 100.r,
                    height: 100.h,
                    width: 100.w,
                  ),
                  UIHelper.verticalSpace(12.h),

                  /// Name
                  Text(
                    userName,
                    style: TextFontStyle.headline12cffffroboto.copyWith(
                      color: AppColor.cFFFFFF,
                      fontSize: 20.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),

                  /// Subtitle
                  Text(
                    bio,
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline12cffffroboto.copyWith(
                      color: AppColor.cFFFFFF.withValues(alpha: 0.80),
                      fontSize: 14.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(43.h),

                  /// Options Group 1
                  buildMenuCard(
                    children: [
                      buildMenuItem(Assets.icons.frameD, "Edit Profile", () {
                        NavigationService.navigateTo(Routes.editProfileScreen);
                      }),
                      buildMenuItem(
                        Assets.icons.blockUser,
                        "Blocked Users",
                        () {
                          NavigationService.navigateTo(Routes.blockUserScreen);
                        },
                      ),
                      // buildMenuItem(Assets.icons.framew, "Subscription", () {}),
                      buildMenuItem(Assets.icons.framea, "Notification", () {
                        NavigationService.navigateTo(Routes.notificationScreen);
                      }),
                      buildMenuItem(Assets.icons.frameD, "Friends", () {
                        NavigationService.navigateTo(
                          Routes.addFriendListScreen,
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Options Group 2
                  buildMenuCard(
                    children: [
                      buildMenuItem(Assets.icons.frame3, "Help & Support", () {
                        NavigationService.navigateTo(
                          Routes.helpAndSupportScreen,
                        );
                      }),
                      buildMenuItem(Assets.icons.frame2, "Privacy", () {
                        NavigationService.navigateTo(
                          Routes.privacyPolicyScreen,
                        );
                      }),
                      buildMenuItem(
                        Assets.icons.frame,
                        "Terms and Condition",
                        () {
                          NavigationService.navigateTo(
                            Routes.termsAndConditionsScreen,
                          );
                        },
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(16.h),

                  /// Logout + Delete
                  buildMenuCard(
                    children: [
                      buildMenuItem(Assets.icons.l, "Log Out", () {
                        logout();
                      }, color: Colors.red),
                      buildMenuItem(Assets.icons.d, "Delete Account", () {
                        showLogoutDialog(
                          context,
                          titile: "Delete Account",
                          buttonName: "Delete",
                          onTap: () {
                            deleteAccount();
                          },
                        );
                      }, color: Colors.red),
                    ],
                  ),
                  UIHelper.verticalSpace(60.h),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void deleteAccount() async {
    await deleteAccountRxObj.delete().waitingForSucess().then((success) {
      NavigationService.navigateTo(Routes.loginScreen);
    });
  }

  /// -----------------------
  ///   MENU CARD WRAPPER
  /// -----------------------
  Widget buildMenuCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.c000000,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(children: children),
    );
  }

  void logout() async {
    await logoutRxObj.logout().waitingForSucess().then((success) {
      NavigationService.navigateToReplacementUntil(Routes.loginScreen);
    });
  }

  /// -----------------------
  ///     MENU ROW ITEM
  /// -----------------------
  Widget buildMenuItem(
    String icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.white,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.c0369A1, width: 0.1),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            //Icon(icon, size: 22, color: color),
            SvgPicture.asset(icon, width: 24.w),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextFontStyle.headline12w400cA7B0B9Montserrat.copyWith(
                  color: AppColor.cFFFFFF,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Image.asset(Assets.images.rightArrow.path),
          ],
        ),
      ),
    );
  }
}
