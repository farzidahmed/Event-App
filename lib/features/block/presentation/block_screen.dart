import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/block/model/block_user_response.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/api_access.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  @override
  void initState() {
    blockUserListRxObj.blockUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c0E0F11,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
        title: Text(
          "Blocked Users",
          style: TextFontStyle.headline20w600cDFE3E8Montserrat,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            StreamBuilder(
              stream: blockUserListRxObj.blockUserList,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const FriendListShimmer();
                } else if (snapShot.hasData) {
                  BlockUserModelResponse response = snapShot.data!;

                  if (response.data == null || response.data!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 200.h),
                      child: Center(
                        child: Text(
                          "No Blocked Users",
                          style: TextFontStyle.headline20w600cDFE3E8Montserrat
                              .copyWith(color: AppColor.cFFFFFF),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: response.data!.length,
                      itemBuilder: (context, index) {
                        final user = response.data![index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.c212B36,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            spacing: 12.w,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomNetworkImage(
                                urls: user.avatar ?? "",
                                borderRadius: 100.r,
                                height: 48.h,
                                width: 48.w,
                              ),

                              Expanded(
                                child: Text(
                                  user.name ?? "",
                                  style: TextFontStyle.headline16cffffroboto
                                      .copyWith(
                                        color: AppColor.cFFFFFF,
                                        fontSize: 16.sp,
                                      ),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  unBlockUserRxObj
                                      .unBlockUser(user.id)
                                      .waitingForSucess()
                                      .then((success) {
                                        if (success) {
                                          ToastUtil.showLongToast(
                                            "User Unblocked Successfully",
                                          );
                                          blockUserListRxObj.blockUser();
                                          myAllFriendRxObj.allFriend();
                                        }
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.cFFFFFF),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  child: Text(
                                    "Unblock",
                                    style: TextFontStyle.headline16cffffroboto
                                        .copyWith(
                                          color: AppColor.cFFFFFF,
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
