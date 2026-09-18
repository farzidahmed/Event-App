import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/event_card.dart';
import 'package:llr/common/festival_inCard.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/navigation_service.dart';

class FestivalDetailsScreen extends StatefulWidget {
  const FestivalDetailsScreen({super.key});

  @override
  State<FestivalDetailsScreen> createState() => _FestivalDetailsScreenState();
}

class _FestivalDetailsScreenState extends State<FestivalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0E10),
      appBar: CustomFestivalAppBar(
        title: "Upcoming Festival Details",
        onBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header Image =====
            EventCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2",

              title: "Blinding Lights",
              location: "Los Angeles, CA",
              date: "Jan 6 2025 8:00pm ",
            ),
            FestivalInfoCard(),

            // ===== Festival Info Card =====
            SizedBox(height: 24.h),

            // ===== Q&A Section =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Q&A",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ask Question feature coming soon."),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          "Ask Question",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            _buildQuestionCard(
              name: "Chris Taylor",
              question:
                  "What are the best camping spots near the festival grounds?",
              likes: 15,
              replies: [
                {
                  "user": "David Kim",
                  "answer": "Can you bring your own food and drinks?",
                  "likes": 22,
                  "replies": [
                    {
                      "user": "Sophie Anderson",
                      "answer":
                          "Yes! Sealed bottles and snacks are allowed. Great food vendors too.",
                      "likes": 8,
                    },
                  ],
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildChip(String name) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
  //     decoration: BoxDecoration(
  //       color: const Color(0xff2C2D31),
  //       borderRadius: BorderRadius.circular(6.r),
  //     ),
  //     child: Text(
  //       name,
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 12.sp,
  //         fontWeight: FontWeight.w400,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildQuestionCard({
    required String name,
    required String question,
    required int likes,
    required List<Map<String, dynamic>> replies,
  }) {
    bool isAnswering = false;
    final TextEditingController answerController = TextEditingController();

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xff1A1B1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header (Avatar + Name)
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/32.jpg",
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // ===== Question Text
              Text(
                question,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 10.h),

              // ===== Like + Answer Button Row
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.white54,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "$likes",
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => setState(() => isAnswering = !isAnswering),
                    child: Text(
                      "Answer",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              // ===== TextField (Visible Only When Answering)
              if (isAnswering) ...[
                SizedBox(height: 10.h),
                TextField(
                  controller: answerController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Write your answer...",
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 12.sp,
                    ),
                    filled: true,
                    fillColor: const Color(0xff2C2D31),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (answerController.text.trim().isNotEmpty) {
                          setState(() {
                            replies.add({
                              "user": "You",
                              "answer": answerController.text.trim(),
                              "likes": 0,
                            });
                            isAnswering = false;
                            answerController.clear();
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff7A5AF8),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        child: Text(
                          "Post Answer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () => setState(() => isAnswering = false),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              // ===== Replies
              ...replies.map((reply) {
                return Padding(
                  padding: EdgeInsets.only(left: 32.w, top: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar + Name
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/44.jpg",
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            reply["user"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        reply["answer"],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white38,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            reply["likes"].toString(),
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class CustomFestivalAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomFestivalAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 40.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 14.w),
        child: GestureDetector(
          onTap: onBack ?? () => Navigator.pop(context),
          child: SvgPicture.asset(
            Assets
                .icons
                .arrowBack, // change path to your Assets.icons.arrowBack
            width: 14.w,
            height: 14.h,
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextFontStyle.headline14w400c637381Montserrat.copyWith(
          color: AppColor.cFFFFFF,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
