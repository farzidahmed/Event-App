import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/common/customAppbar.dart';
import 'package:llr/common/custom_tab_bar.dart'; // Added custom tab bar
import 'package:llr/common/event_card.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/festival_details/model/allalums_model.dart';
import 'package:llr/features/search/presentation/search_screen.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/helpers_method.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/networks/api_access.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initial fetch for the default selected tab (Albums)
    allAlumsRxObj.all();
  }

  Widget _buildAlbumsList() {
    return StreamBuilder(
      stream: allAlumsRxObj.allAlumbs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const FestivalListShimmer();
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        AllAlumsModel alumsModel = snapshot.data as AllAlumsModel;

        if (alumsModel.data == null || alumsModel.data!.isEmpty) {
          return Text(
            "Albums Not Found",
            style: TextFontStyle.headline14w400c637381Montserrat,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: alumsModel.data?.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = alumsModel.data?[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                onTap: () {
                  NavigationService.navigateToWithArgs(
                    Routes.pastFestialvalDetailsScreen,
                    {"id": item?.id},
                  );
                },
                child: EventCard(
                  imageUrl: item?.artistImage ?? "",
                  title: item?.festivalName ?? "",
                  location: item?.locations ?? "",
                  date: item?.publishedAt ?? "",
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFestivalsList() {
    return StreamBuilder(
      stream: festivalSearchRx.dataFetcher.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const FestivalListShimmer();
        } else if (snapshot.hasData) {
          final response = snapshot.data!;
          final festivals = response.data ?? [];

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: festivals.length,
            itemBuilder: (context, index) {
              final data = festivals[index];
              return FestivalCardWidget(
                onTap: () {
                  NavigationService.navigateToWithArgs(
                    Routes.pastFestialvalDetailsScreen,
                    {'id': data.id},
                  );
                },
                imageUrl: data.image ?? "",
                title: data.festivalName ?? "",
                location: data.location ?? "",
                date:
                    "${data.startDate != null ? formatDate(data.startDate!) : ''} - ${data.endDate != null ? formatDate(data.endDate!) : ''}",
                category: "Indie Rock",
                rating: 4.5,
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleImage: Assets.images.appIcon.path,
        titleText: "Event App",
        sufixImage: Assets.images.notification.path,
        settingIcon: Assets.images.setting.path,
      ),
      backgroundColor: const Color(0xFF0E0E0E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTabBar(
            tabs: const ["Albums", "Festivals"],
            initialIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
              if (index == 0) {
                allAlumsRxObj.all();
              } else {
                festivalSearchRx.searchFestival(search: "");
              }
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (selectedIndex == 0) {
                  await allAlumsRxObj.all();
                } else {
                  await festivalSearchRx.searchFestival(search: "");
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ).copyWith(top: 10.h),
                child:
                    selectedIndex == 0
                        ? _buildAlbumsList()
                        : _buildFestivalsList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
