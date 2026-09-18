import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/festival_details/model/allalums_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/networks/api_access.dart';

class AllAlumbsScreen extends StatefulWidget {
  const AllAlumbsScreen({super.key});

  @override
  State<AllAlumbsScreen> createState() => _AllAlumbsScreenState();
}

class _AllAlumbsScreenState extends State<AllAlumbsScreen> {
  @override
  void initState() {
    alumbsRxObj.myAlumbs(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: const Color(0xff111013),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
        title: Text(
          "Album",
          style: TextFontStyle.headline24w400cFF4842Montserrat.copyWith(
            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: StreamBuilder(
            stream: allAlumsRxObj.allAlumbs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AlbumGridShimmer();
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              AllAlumsModel model = snapshot.data;
              var data = model.data;

              if (data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Alumbs items found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 0.70.dm,
                  mainAxisExtent: 200.dg,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  var item = data[index];

                  return GestureDetector(
                    onTap: () {
                      // allAlumsDetailsRxObj
                      //     .details(item.id!)
                      //     .waitingForSucess()
                      //     .then((success) {
                      //       NavigationService.navigateTo(
                      //         Routes.pastFestialvalDetailsScreen,
                      //       );
                      //     });
                      NavigationService.navigateToWithArgs(
                        Routes.pastFestialvalDetailsScreen,
                        {'id': item.id},
                      );
                    },
                    child: albumCard(item),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget albumCard(Datum data) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff202123),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          // Image + Overlay + Top Icon + Title/Date
          Stack(
            children: [
              // Album Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  data.artistImage ?? "https://picsum.photos/400/300?random=1",
                  height: 108.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Top-right Lock/Public Icon
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Icon(
                    data.type == "private" ? Icons.lock : Icons.language,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

              // Gradient + Festival Name + Published At
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.festivalName ?? "",
                        style: TextFontStyle.headline16cffffroboto.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        data.publishedAt ?? "",
                        style: TextFontStyle.headline12cffffroboto.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Section: Flames + Favorite + Photos/Videos
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥🔥🔥 + Date
                Row(
                  children: [
                    const Text("🔥🔥🔥🔥🔥", style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data.publishedAt ?? "",
                        style: TextFontStyle.headline12cffffroboto.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Favorite Count
                RichText(
                  text: TextSpan(
                    text: "Favorite: ",
                    style: TextFontStyle.headline12cffffroboto,
                    children: [
                      TextSpan(
                        text: data.totalReview?.toString() ?? "0",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),

                // Photos & Videos Count
                Text(
                  "${data.totalImages ?? 0} Photos • ${data.totalVideos ?? 0} Videos",
                  style: TextFontStyle.headline12cffffroboto.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
