import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custm_banner_widget.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/networks/api_access.dart';

class AllWishlistScreen extends StatefulWidget {
  const AllWishlistScreen({super.key});

  @override
  State<AllWishlistScreen> createState() => _AllWishlistScreenState();
}

class _AllWishlistScreenState extends State<AllWishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff111013),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),

        title: Text(
          "Wishlist",
          style: TextFontStyle.headline24w400cFF4842Montserrat.copyWith(
            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: StreamBuilder<UserDetailsModel>(
            stream: userDetailsRxObj.allAlumbs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              UserDetailsModel? model = snapshot.data;
              var data = model?.data;

              if (data?.wishlist == null || data!.wishlist!.isEmpty) {
                return const Center(
                  child: Text(
                    "No wishlist items found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.wishlist!.length,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.2.dm,
                  mainAxisExtent: 180.dg,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  var item = data.wishlist![index];

                  var imageUrl = item.avatar ?? "";
                  var title = item.festivalName ?? "";
                  var location = item.locations ?? "";
                  var date = item.publishedAt ?? "";
                  var review = item.totalReview ?? "";

                  return SizedBox(
                    width: 260.w,
                    child: BannerWidgetScreen(
                      imageUrl: imageUrl.toString(),
                      title: title,
                      location: location,
                      date: date,
                      review: review.toString(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
