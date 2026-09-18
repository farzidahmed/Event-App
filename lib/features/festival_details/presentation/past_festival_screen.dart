// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_widget_pop_button.dart';
import 'package:llr/common/festival_inCard.dart';
import 'package:llr/common/pastEven_card.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/festival_details/data/festival_details_rx/model/alumbs_details_model.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class PastFestivalDetailsScreen extends StatefulWidget {
  final int id;
  const PastFestivalDetailsScreen({super.key, required this.id});

  @override
  State<PastFestivalDetailsScreen> createState() =>
      _PastFestivalDetailsScreenState();
}

class _PastFestivalDetailsScreenState extends State<PastFestivalDetailsScreen> {
  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    allAlumsDetailsRxObj.clean();
    allAlumsDetailsRxObj.details(widget.id);
    super.initState();
  }

  // @override
  // void dispose() {
  //   allAlumsDetailsRxObj.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    log("Building PastFestivalDetailsScreen with ID: ${widget.id}");
    return Scaffold(
      backgroundColor: const Color(0xff0E0E10),
      appBar:
      // CustomFestivalAppBar(
      //   title: "Past Festival Details",
      //   onBack: () {
      //     NavigationService.goBack;
      //   },
      // ),
      AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
        title: Text(
          "Past Festival Details",
          style: TextFontStyle.headline20w600cDFE3E8Montserrat.copyWith(
            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => ActionDialog(
                      id: widget.id,
                      onReportSuccess: () {
                        reportContentRxObj
                            .reportUser(widget.id, _textController.text)
                            .waitingForSucess()
                            .then((success) {
                              if (success) {
                                ToastUtil.showLongToast(
                                  "Content reported successfully",
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              }
                            });
                      },
                      textController: _textController,
                    ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: StreamBuilder(
          stream: allAlumsDetailsRxObj.allAlumbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return PastFestivalShimmer();
            } else if (snapshot.hasData) {
              AllAlumbsDetailsModel model = snapshot.data!;
              var data = model.data;
              var reviews = data?.reviews;
              log("/////////////////////////${data?.artistImage ?? ""}");

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Image
                  PastEventWidget(
                    imageUrl: data?.artistImage ?? "",
                    title: data?.festivalName ?? "",
                    location: data?.experience?.location ?? "",
                    date: data?.publishedAt ?? "",
                    review: "${data?.totalReview} reviews",
                  ),
                  UIHelper.verticalSpace(12.h), // EventCard(
                  //   imageUrl: data?.artistImage ?? "",
                  //   title: data?.festivalName ?? "",
                  //   location: data?.experience?.location ?? "",
                  //   date: data?.publishedAt ?? "",
                  //   review: "${data?.totalReview} reviews",
                  // ),
                  FestivalInfoCard(
                    experience: data?.experience,
                    documents: data?.documents,
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) =>
                                    WriteReviewDialog(id: data?.id.toString()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 6.h,
                          ),
                          child: Text(
                            "Write Review",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(14.h),

                  // 🔥 FIXED: Correct Review + Reply rendering
                  if (reviews != null)
                    ...reviews.map((review) {
                      return _buildQuestionCard(
                        id: review.id,
                        festivalId: data?.id ?? 0,
                        name: review.userName ?? "Unknown User",
                        question: review.comment ?? "",
                        likes: review.likesCount.toString(),
                        replies:
                            review.replies?.map((reply) {
                              return {
                                "user": reply.userName ?? "Unknown",
                                "answer": reply.comment ?? "",
                                "likes": reply.likesCount.toString(),
                                "replyId": reply.id.toString(),
                                "reviewId": review.id.toString(),
                              };
                            }).toList() ??
                            [],
                      );
                    }),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // =====================================================================
  Widget _buildQuestionCard({
    int? id,
    required String name,
    required String question,
    required String likes,
    required List<Map<String, dynamic>> replies,
    required int festivalId,
  }) {
    bool isAnswering = false;
    bool isLike = false;
    final TextEditingController answerController = TextEditingController();

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xff1A1B1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar + Name
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

              // Review Text
              Text(
                question,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 10.h),

              // Like + Answer Buttons
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      reviewLikeRxObj.reviewLike(id!).then((success) {
                        if (success.status ?? false) {
                          setState(() {
                            isLike = true;
                          });
                          allAlumsDetailsRxObj.details(festivalId);
                        }
                      });
                    },
                    child: Icon(
                      Icons.thumb_up_alt_outlined,
                      color: isLike ? AppColor.c0369A1 : Colors.white54,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    likes,
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => setState(() => isAnswering = !isAnswering),
                    child: Icon(
                      Icons.mode_comment_outlined,
                      color: isAnswering ? AppColor.c0369A1 : Colors.white54,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${replies.length}",
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                ],
              ),

              // Write Reply Section
              if (isAnswering) ...[
                SizedBox(height: 10.h),
                TextField(
                  controller: answerController,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Write your answer...",
                    filled: true,
                    fillColor: const Color(0xff2C2D31),
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 12.sp,
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
                        if (answerController.text.trim().isEmpty) return;
                        reviewCommentRxOj
                            .comment(
                              id: id.toString(),
                              review: answerController.text.trim(),
                            )
                            .then((success) async {
                              if (success) {
                                answerController.clear();
                                setState(() => isAnswering = false);
                                await Future.delayed(
                                  const Duration(milliseconds: 500),
                                );
                                allAlumsDetailsRxObj.details(festivalId);
                              }
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff7A5AF8),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "Post Answer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
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
                        ),
                      ),
                    ),
                  ],
                ),

                // Replies
                ...replies.map((reply) {
                  return Padding(
                    padding: EdgeInsets.only(left: 30.w, top: 14.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/44.jpg",
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reply["user"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                reply["answer"],
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.thumb_up_alt_outlined,
                              //       color: Colors.white54,
                              //       size: 14.sp,
                              //     ),
                              //     SizedBox(width: 4.w),
                              //     Text(
                              //       reply["likes"].toString(),
                              //       style: TextStyle(
                              //         color: Colors.white54,
                              //         fontSize: 11.sp,
                              //       ),
                              //     ),
                              //     SizedBox(width: 16.w),
                              //     // Icon(
                              //     //   Icons.mode_comment_outlined,
                              //     //   color: Colors.white54,
                              //     //   size: 14.sp,
                              //     // ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        );
      },
    );
  }
}

// =====================================================================
//                          Custom App Bar
// =====================================================================

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
      leadingWidth: 40.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 14.w),
        child: GestureDetector(
          onTap: onBack ?? () => Navigator.pop(context),
          child: SvgPicture.asset(
            Assets.icons.arrowBack,
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
