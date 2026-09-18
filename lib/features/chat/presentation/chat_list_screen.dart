// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/chat/model/user_list_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/networks/api_access.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    userChatListRxObj.userList();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000), // Dark background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 34.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    "Chat",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            // Search Field
            Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.5),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          searchQuery = val.toLowerCase();
                        });
                      },
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search friend...",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Chat List
            StreamBuilder(
              stream: userChatListRxObj.allAlumbs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ChatListShimmer();
                } else if (snapshot.hasData) {
                  UserListModel model = snapshot.data;
                  var data = model.data?.users ?? [];

                  if (searchQuery.isNotEmpty) {
                    data =
                        data
                            .where(
                              (chat) => (chat.name ?? "")
                                  .toLowerCase()
                                  .contains(searchQuery),
                            )
                            .toList();
                  }

                  return data.isNotEmpty
                      ? Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final chat = data[index];

                            return InkWell(
                              onTap: () {
                                getChatDataRxObj
                                    .chatData(chat.lastChat!.receiverId!)
                                    .waitingForSucess()
                                    .then((success) {
                                      NavigationService.navigateToWithArgs(
                                        Routes.chatWithFriendScreen,

                                        {
                                          "id": chat.lastChat?.receiverId,
                                          "roomId": chat.lastChat?.roomId,
                                          "name": chat.name ?? "name",
                                          "image": chat.avatar.toString(),
                                        },
                                      );
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 18.h),
                                child: Row(
                                  children: [
                                    //
                                    CustomNetworkImage(
                                      urls: chat.avatar ?? "",
                                      height: 40,
                                      width: 40,
                                      borderRadius: 100.r,
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chat.name.toString(),
                                            style:
                                                TextFontStyle
                                                    .headline14cffffroboto,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            chat.lastChat!.text.toString(),
                                            style:
                                                TextFontStyle
                                                    .headline14cffffroboto,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      chat.lastChat!.humanizeDate.toString(),
                                      style:
                                          TextFontStyle.headline14cffffroboto,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      : Center(
                        child: Text(
                          "No chat Found!",
                          style: TextFontStyle.headline14w400c637381Montserrat,
                        ),
                      );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
