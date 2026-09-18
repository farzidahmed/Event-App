// ignore_for_file: deprecated_member_use, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custm_banner_widget.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _fetchAlbumsIfNeeded(selectedTab);
  }

  void _fetchAlbumsIfNeeded(int index) {
    if (index == 0) {
      final currentData = alumbsRxObj.allAlbumsStream.valueOrNull;
      if (currentData == null || (currentData as dynamic).data == null) {
        alumbsRxObj.myAlumbs(0);
      }
    } else if (index == 1) {
      final currentData = getPublicAlbumsRxObj.publicAlbumsStream.valueOrNull;
      if (currentData == null || (currentData as dynamic).data == null) {
        getPublicAlbumsRxObj.getPublicAlbums();
      }
    } else if (index == 2) {
      final currentData = getPrivateAlbumsRxObj.privateAlbumsStream.valueOrNull;
      if (currentData == null || (currentData as dynamic).data == null) {
        getPrivateAlbumsRxObj.getPrivateAlbums();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f14),
      body: StreamBuilder(
        stream: userDetailsRxObj.allAlumbs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProfileHeaderShimmer();
          }

          if (snapshot.hasData) {
            final data = snapshot.data!.data;
            if (data == null) return const SizedBox.shrink();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(data),
                      _buildStats(data),
                      UIHelper.verticalSpace(23.h),
                      UIHelper.verticalSpace(8.h),
                      _headerText("Top Artists"),
                      UIHelper.verticalSpace(15.h),
                      _buildArtistScroll(data),
                      (data.wishlist?.isEmpty ?? true)
                          ? const SizedBox.shrink()
                          : UIHelper.verticalSpace(30.h),
                      (data.wishlist?.isEmpty ?? true)
                          ? const SizedBox.shrink()
                          : _buildWishlistSection(data),
                      UIHelper.verticalSpace(20.h),
                      _buildRecentAlbumsSection(),
                      UIHelper.verticalSpace(15.h),
                      _buildSegmentTabs(),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 15.h,
                  ),
                  sliver: _buildAlbumGrid(),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      UIHelper.verticalSpace(15.h),
                      UIHelper.verticalSpace(40.h),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: CustomButton(
          onTap: () {
            NavigationService.navigateTo(Routes.createAlumbs);
          },
          btnName: "+ Create Album",
        ),
      ),
    );
  }

  Widget _buildHeader(Data data) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.userProfileScreen);
      },
      child: Container(
        width: double.infinity,
        height: 256.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.backgorundImage.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.15),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60.h,
              right: 30.w,
              child: SvgPicture.asset(Assets.icons.settingIcon),
            ),
            Positioned(
              left: 16.w,
              bottom: 40.w,
              right: 16.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: CustomNetworkImage(
                      urls: data.avatar ?? "",
                      borderRadius: 100.r,
                    ),
                  ),
                  UIHelper.horizontalSpace(10.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.name ?? "",
                          style: TextFontStyle.headline20w600cDFE3E8Montserrat,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          data.username ?? "",
                          style: TextFontStyle.headline14w400cA7B0B9Montserrat
                              .copyWith(color: const Color(0xff9810FA)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.bio ?? "",
                          maxLines: 2,
                          style: TextFontStyle.headline14w400c637381Montserrat
                              .copyWith(color: AppColor.cFFFFFF),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(Data data) {
    return Container(
      // height: .h,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff202123),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(data.days?.toString() ?? "0", "Days"),
          _buildDivider(),
          _buildStatItem(data.totalFestables?.toString() ?? "0", "Festivals"),
          _buildDivider(),
          _buildStatItem(data.states?.toString() ?? "0", "States"),
          _buildDivider(),
          _buildStatItem(data.totalAlbums?.toString() ?? "0", "Albums"),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      height: 60.h,
      child: VerticalDivider(color: AppColor.cFFFFFF),
    );
  }

  Widget _buildStatItem(String number, String title) {
    return Column(
      children: [
        Text(
          number,
          style: TextFontStyle.headline14w400c637381Montserrat.copyWith(
            color: const Color(0xff9810FA),
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AchievementCard(
                icon: Image.asset(Assets.images.music.path),
                title: "Festival Explorer",
                subtitle: "Attended your first festival",
              ),
              const AchievementCard(
                icon: Text("🔥", style: TextStyle(fontSize: 28)),
                title: "Memory Keeper",
                subtitle: "Attended your first festival",
              ),
            ],
          ),
        ),
        UIHelper.verticalSpace(12.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AchievementCard(
                icon: Image.asset(Assets.images.updateStar.path),
                title: "State Hopper",
                subtitle: "8 states visited",
              ),
              AchievementCard(
                icon: Image.asset(Assets.images.edm.path),
                title: "EDM Veteran",
                subtitle: "47 days at festivals",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArtistScroll(Data data) {
    final topArtists = data.topArtists ?? [];
    if (topArtists.isEmpty) {
      return const Center(child: Text("No Artists Found"));
    }
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: topArtists.length,
        itemBuilder: (context, index) {
          final item = topArtists[index];
          return ArtistAvatarCard(
            imageUrl: item.avatar ?? "https://picsum.photos/400/300?random=2",
            name: item.name ?? "",
          );
        },
      ),
    );
  }

  Widget _buildWishlistSection(Data data) {
    final wishlist = data.wishlist ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _headerText("Wishlist"),
              _viewAllButton(Routes.allwishlistScreen),
            ],
          ),
        ),
        UIHelper.verticalSpace(15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SizedBox(
            height: 190,
            child:
                wishlist.isEmpty
                    ? const Center(
                      child: Text(
                        "No wishlist items found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wishlist.length,
                      itemBuilder: (context, index) {
                        final item = wishlist[index];
                        return SizedBox(
                          width: 260.w,
                          child: BannerWidgetScreen(
                            imageUrl:
                                item.avatar?.toString() ??
                                "https://picsum.photos/400/300?random=3",
                            title: item.festivalName ?? "",
                            location: item.locations ?? "",
                            date: item.publishedAt ?? "",
                            review:
                                item.totalReview?.toString() ?? "(0 reviews)",
                          ),
                        );
                      },
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAlbumsSection() {
    return Padding(
      padding: EdgeInsets.only(right: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerText("Recent Albums"),
          _viewAllButton(Routes.allAlumbsScreen),
        ],
      ),
    );
  }

  Widget _viewAllButton(String route) {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(route),
      child: Text(
        "View All",
        style: TextFontStyle.headline12w400cA7B0B9Montserrat.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.c7E4ECD,
        ),
      ),
    );
  }

  Widget _headerText(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Text(
        title,
        style: TextFontStyle.headline20w600cFFFFFFMontserrat.copyWith(
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildSegmentTabs() {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: const Color(0xff202123),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pill("All Albums", 0),
          _pill("Public", 1),
          _pill("Private", 2),
        ],
      ),
    );
  }

  Widget _pill(String label, int index) {
    final bool active = selectedTab == index;
    return InkWell(
      onTap: () {
        if (selectedTab != index) {
          setState(() => selectedTab = index);
          _fetchAlbumsIfNeeded(index);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active ? const Color(0xff8a4bff) : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          label,
          style: TextStyle(color: active ? Colors.white : Colors.white70),
        ),
      ),
    );
  }

  Widget _buildAlbumGrid() {
    Stream<dynamic>? activeStream;
    if (selectedTab == 0) activeStream = alumbsRxObj.allAlbumsStream;
    if (selectedTab == 1) {
      activeStream = getPublicAlbumsRxObj.publicAlbumsStream;
    }
    if (selectedTab == 2) {
      activeStream = getPrivateAlbumsRxObj.privateAlbumsStream;
    }

    return StreamBuilder<dynamic>(
      stream: activeStream,
      builder: (context, snapshot) {
        final data = snapshot.data?.data;
        List<dynamic> albums = data ?? [];

        if (albums.isEmpty) {
          String message = "No combined albums found";
          if (selectedTab == 1) message = "No public albums found";
          if (selectedTab == 2) message = "No private albums found";

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(child: AlbumGridShimmer());
          }

          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                ),
              ),
            ),
          );
        }
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            // mainAxisExtent: 180.dg,
            crossAxisSpacing: 15.h,
            mainAxisSpacing: 20.h,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final dynamic album = albums[index];
            return _buildAlbumCard(album);
          }, childCount: albums.length),
        );
      },
    );
  }

  Widget _buildAlbumCard(dynamic data) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateToWithArgs(
          Routes.pastFestialvalDetailsScreen,
          {'id': data.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff202123),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  urls:
                      data.artistImage ??
                      "https://picsum.photos/400/300?random=1",
                  height: 108.h,
                  width: double.infinity,
                  borderRadius: 14.r,
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      log("Album ID: ${data.id}");
                      postWishRxObj
                          .postWish(id: int.tryParse(data.id.toString()) ?? 0)
                          .waitingForSucess()
                          .then((success) {
                            if (success) {
                              if (selectedTab == 0) {
                                alumbsRxObj.myAlumbs(0);
                              } else if (selectedTab == 1) {
                                getPublicAlbumsRxObj.getPublicAlbums();
                              } else if (selectedTab == 2) {
                                getPrivateAlbumsRxObj.getPrivateAlbums();
                              }
                            }
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        data.type == "private"
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      data.type == "private" ? Icons.lock : Icons.language,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(14),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
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
                            color: Colors.white.withOpacity(0.7),
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
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "🔥" * (data.averageRating?.toInt() ?? 0),
                        style: const TextStyle(fontSize: 14),
                      ),
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
                  Text(
                    "${data.totalImages ?? 0} Photos • ${data.totalVideos ?? 0} Videos",
                    style: TextFontStyle.headline12cffffroboto.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;

  const AchievementCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w, // Matches screenshot 2 per row with spacing
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xff202123), // exact dark card color
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon, // emoji or icon
          const SizedBox(height: 14),

          Text(
            title,
            style: TextFontStyle.headline16w700cFFFFFFMontserrat.copyWith(
              fontSize: 14.sp,
            ),
            maxLines: 1,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            subtitle,
            style: TextFontStyle.headline12w400cA7B0B9Montserrat,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class ArtistAvatarCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ArtistAvatarCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133.w,
      decoration: BoxDecoration(
        color: Color(0xff202123),
        borderRadius: BorderRadius.circular(14.r),
      ),

      margin: EdgeInsets.only(right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Outer Circle Border
          Container(
            padding: const EdgeInsets.all(3), // border thickness
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xffDF485E), // exact reddish-pink border
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 28.r, // same in screenshot
              child: CustomNetworkImage(
                urls: imageUrl,
                height: 64.2.h,
                width: 64.2.w,
                borderRadius: 100.r,
              ),
            ),
          ),

          UIHelper.verticalSpace(8.h),

          // Name text
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextFontStyle.headline12w400cA7B0B9Montserrat.copyWith(
              color: AppColor.cFFFFFF,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
