import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/features/festival_details/data/festival_details_rx/model/alumbs_details_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';

class FestivalInfoCard extends StatelessWidget {
  final Experience? experience;
  final List<Document>? documents;

  const FestivalInfoCard({super.key, this.experience, this.documents});

  bool _isVideo(String? url) {
    if (url == null || url.isEmpty) return false;
    final lower = url.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.mkv') ||
        lower.endsWith('.webm') ||
        lower.endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    log("documents count: ${documents?.length ?? 0}");

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff1A1B1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Experience Section ---
          Text(
            "Experience",
            style: TextFontStyle.headline18cffffroboto.copyWith(
              color: AppColor.cFFFFFF,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            experience?.campExperience ?? "No experience provided.",
            style: TextFontStyle.headline18cffffroboto.copyWith(
              color: const Color(0xFF919EAB),
              fontSize: 14.sp,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: 16.h),

          // --- Divider ---
          Divider(
            color: Colors.white.withValues(alpha: 0.08),
            height: 1,
            thickness: 1,
          ),
          UIHelper.verticalSpace(16.h),

          // --- Additional Info ---
          _buildInfoRow("Favourite Set", experience?.favouriteSet),
          _buildInfoRow("Favourite Day", experience?.favouriteDay),
          _buildInfoRow("Festive Story", experience?.festiveStory),
          _buildInfoRow("Location", experience?.location),

          // --- Unified Albums / Media Section ---
          if (documents != null && documents!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  CupertinoIcons.photo_on_rectangle,
                  color: AppColor.cFFFFFF,
                  size: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  "Photos & Videos",
                  style: TextFontStyle.headline18cffffroboto.copyWith(
                    color: AppColor.cFFFFFF,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "${documents!.length} items",
                  style: TextFontStyle.headline18cffffroboto.copyWith(
                    color: const Color(0xFF919EAB),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            if (documents!.length == 1)
              _buildMediaTile(
                context,
                doc: documents!.first,
                index: 0,
                height: 180,
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _buildMediaTile(
                      context,
                      doc: documents![0],
                      index: 0,
                      height: 120,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _buildMediaTile(
                      context,
                      doc: documents![1],
                      index: 1,
                      height: 120,
                      showMoreOverlay: documents!.length > 2,
                      extraCount: documents!.length - 2,
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMediaTile(
    BuildContext context, {
    required Document doc,
    required int index,
    double height = 120,
    bool showMoreOverlay = false,
    int extraCount = 0,
  }) {
    final url = doc.fileUrl ?? "";
    final isVideo = _isVideo(url);

    return GestureDetector(
      onTap: () {
        NavigationService.navigateToWithArgs(Routes.albumMediaScreen, {
          'documents': documents!,
          'initialIndex': index,
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          height: height.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Media Content (Image or Video Frame)
              if (isVideo)
                _VideoThumbnailTile(videoUrl: url)
              else
                CustomNetworkImage(urls: url),

              // Video Play Icon Overlay
              if (isVideo)
                Container(
                  color: Colors.black.withValues(alpha: 0.25),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.8),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 26.sp,
                      ),
                    ),
                  ),
                ),

              // Video badge at top-left
              if (isVideo)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          "VIDEO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // +N MORE MEDIA Overlay
              if (showMoreOverlay)
                Container(
                  color: Colors.black.withValues(alpha: 0.65),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.photo_on_rectangle,
                        color: AppColor.cFFFFFF,
                        size: 22.sp,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "+$extraCount",
                        style: TextFontStyle.headline18cffffroboto.copyWith(
                          color: AppColor.cFFFFFF,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "MORE MEDIA",
                        style: TextFontStyle.headline18cffffroboto.copyWith(
                          color: AppColor.cFFFFFF,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.headline18cffffroboto.copyWith(
              color: AppColor.cFFFFFF,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextFontStyle.headline18cffffroboto.copyWith(
              color: const Color(0xFF919EAB),
              fontSize: 14.sp,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoThumbnailTile extends StatelessWidget {
  final String videoUrl;
  const _VideoThumbnailTile({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF2C2D35), const Color(0xFF191A20)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.white.withValues(alpha: 0.35),
          size: 36.sp,
        ),
      ),
    );
  }
}
