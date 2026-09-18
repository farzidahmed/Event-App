import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/constants/color.dart';
import 'package:llr/features/friend/model/my_all_friend_model.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class AllFriendPage extends StatefulWidget {
  const AllFriendPage({super.key});

  @override
  State<AllFriendPage> createState() => _AllFriendPageState();
}

class _AllFriendPageState extends State<AllFriendPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void fetchData() async {
    await myAllFriendRxObj.allFriend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,

        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.chatListScreen);
            },

            child: SvgPicture.asset(Assets.icons.message, width: 24.w),
          ),
          UIHelper.horizontalSpace(16.w),
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.addFriendListScreen);
            },
            child: SvgPicture.asset(Assets.icons.friend, width: 24.w),
          ),
          UIHelper.horizontalSpace(20.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: RefreshIndicator(
            onRefresh: () async {
              await myAllFriendRxObj.allFriend();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search bar
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xff212B36),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val.toLowerCase();
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search friend...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.friend),
                    UIHelper.horizontalSpace(8.w),

                    Text(
                      "All friend",
                      style: TextFontStyle.headline14w400c637381Montserrat
                          .copyWith(
                            color: AppColor.cFFFFFF,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                StreamBuilder(
                  stream: myAllFriendRxObj.allAlumbs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const FriendListShimmer();
                    } else if (snapshot.hasData) {
                      MyAllFriendModel model = snapshot.data;
                      var data = model.data ?? [];

                      if (searchQuery.isNotEmpty) {
                        data =
                            data
                                .where(
                                  (friend) => (friend.name ?? "")
                                      .toLowerCase()
                                      .contains(searchQuery),
                                )
                                .toList();
                      }

                      return data.isNotEmpty
                          ? Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final friend = data[index];
                                return FriendCard(
                                  onTap: () {
                                    getChatDataRxObj
                                        .chatData(friend.id ?? 0)
                                        .waitingForSucess()
                                        .then((success) {
                                          NavigationService.navigateToWithArgs(
                                            Routes.chatWithFriendScreen,

                                            {
                                              "id": friend.id,
                                              "roomId": appData.read(KkuserId),
                                              "name": friend.name ?? "name",
                                              "image": friend.avatar.toString(),
                                            },
                                          );
                                        });
                                  },
                                  name: friend.name ?? "",
                                  time: friend.friendSinceHuman ?? "",
                                  imageUrl: friend.avatar ?? "",
                                  onBlock: () {
                                    blockUserRxObj
                                        .blockUser(friend.id)
                                        .waitingForSucess()
                                        .then((success) {
                                          if (success) {
                                            myAllFriendRxObj.allFriend();
                                            ToastUtil.showLongToast(
                                              "blocked successfully",
                                            );
                                          }
                                        });
                                  },
                                  onUnfriend: () {
                                    unFriendRxObj
                                        .unFriend(friend.id)
                                        .waitingForSucess()
                                        .then((success) {
                                          if (success) {
                                            myAllFriendRxObj.allFriend();
                                            ToastUtil.showLongToast(
                                              "Unfriended successfully",
                                            );
                                          }
                                        });
                                  },
                                );
                              },
                            ),
                          )
                          : Padding(
                            padding: EdgeInsets.only(top: 150.h),
                            child: Center(
                              child: Text(
                                "No friend found",
                                style: TextFontStyle.headline16cffffroboto,
                              ),
                            ),
                          );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🧩 Friend Card Custom Widget
class FriendCard extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;
  final VoidCallback? onBlock;
  final VoidCallback? onUnfriend;
  final VoidCallback? onTap;

  const FriendCard({
    super.key,
    required this.name,
    required this.time,
    required this.imageUrl,
    this.onBlock,
    this.onUnfriend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xff212B36),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          trailing: PopupMenuButton<String>(
            color: const Color(0xff212B36),
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onSelected: (value) {
              if (value == 'Block') {
                onBlock?.call();
              } else if (value == 'Unfriend') {
                onUnfriend?.call();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Block', 'Unfriend'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
