import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/friend/model/add_friend_list_model.dart';
import 'package:llr/features/friend/model/friend_request_model.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class AddFriendListScreen extends StatefulWidget {
  const AddFriendListScreen({super.key});

  @override
  State<AddFriendListScreen> createState() => _AddFriendListScreenState();
}

class _AddFriendListScreenState extends State<AddFriendListScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await friendRequestRxObj.request();
    await addFriendRxObj.addFriend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.cFFFFFF),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add Friend",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                /// Pending Requests Title
                /// List of Pending Requests
                StreamBuilder(
                  stream: friendRequestRxObj.allAlumbs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const FriendListShimmer();
                    } else if (snapshot.hasData) {
                      FriendRequestModel model = snapshot.data;
                      var data = model.data;
                      var person = data?.requests;

                      // যদি person null অথবা empty হয়, তাহলে Title সহ পুরো section hide
                      if (person == null || person.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Pending Requests Title
                          Text(
                            "Pending Requests ",
                            style:
                                TextFontStyle.headline18w600cFFFFFFMontserrat,
                          ),
                          UIHelper.verticalSpace(16.h),

                          /// List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: person.length,
                            itemBuilder: (context, index) {
                              final data = person[index];
                              return _RequestCard(
                                name: data.person?.name ?? "",
                                imageUrl: data.person?.avatar ?? "",
                                time: data.sentAt ?? "",
                                id: data.person!.id.toString(),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),

                /// People You May Know Title
                const Text(
                  "People You May Know",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                /// List - People You May Know
                StreamBuilder(
                  stream: addFriendRxObj.allAlumbs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const FriendListShimmer();
                    } else if (snapshot.hasData) {
                      AddFriendListModel model = snapshot.data;
                      var data = model.data;

                      return data!.isNotEmpty
                          ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var name = data[index].name ?? "";
                              var avatar = data[index].avatar ?? "";
                              var id = data[index].id;
                              return _AddFriendCard(
                                name: name,
                                imageUrl: avatar,
                                id: id.toString(),
                              );
                            },
                          )
                          : Center(child: Text("Not Friend Found"));
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

/// ---------------- Pending Request Card ----------------
class _RequestCard extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;
  final String id;

  const _RequestCard({
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xff212B36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl)),
              CircleAvatar(
                child: CustomNetworkImage(
                  urls: imageUrl,
                  borderRadius: 100.r,
                  height: 48,
                  width: 48.w,
                ),
              ),
              UIHelper.horizontalSpace(12.w),

              /// Name & Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextFontStyle.headline16cffffroboto),
                    Text(time, style: TextFontStyle.headline14cffffroboto),
                  ],
                ),
              ),

              /// Buttons
            ],
          ),

          Column(
            children: [
              UIHelper.verticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90.w,
                    height: 32.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        accept(id);
                      },
                      child: Text(
                        "Accept",
                        style: TextFontStyle.headline16cffffroboto.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  SizedBox(
                    width: 90.w,
                    height: 32.w,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Decline",
                        style: TextFontStyle.headline14cffffroboto,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void accept(String id) async {
    await requestAcceptRxObj.accept(id: id).waitingForSucess().then((success) {
      if (success) {
        friendRequestRxObj.request();
        myAllFriendRxObj.allFriend();
        NavigationService.goBack;
      }
    });
  }
}

/// ---------------- Add Friend Card ----------------
class _AddFriendCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String id;

  const _AddFriendCard({
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xff212B36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl)),
          CustomNetworkImage(
            urls: imageUrl,
            borderRadius: 100.r,
            height: 64,
            width: 64.w,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                SizedBox(
                  width: 90.w,
                  height: 32.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      send(id);
                    },
                    child: Text(
                      "Add Friend",
                      style: TextFontStyle.headline16cffffroboto.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void send(String id) async {
    await requestSenerRxObj.sender(id: id).waitingForSucess().then((success) {
      addFriendRxObj.addFriend();
    });
  }
}
