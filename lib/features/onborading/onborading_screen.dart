import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';

import '../../common/custom_button.dart';

class OnboardingScreenUpdate extends StatefulWidget {
  const OnboardingScreenUpdate({super.key});

  @override
  State<OnboardingScreenUpdate> createState() => _OnboardingScreenUpdateState();
}

class _OnboardingScreenUpdateState extends State<OnboardingScreenUpdate> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingItems = [
    {"imageTitle": Assets.images.onboarding4.path},
    {"imageTitle": Assets.images.onboarding5.path},
    {"imageTitle": Assets.images.onboarding6.path},
  ];

  void _goToNextPage() {
    if (_currentPage < onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      NavigationService.navigateToReplacementUntil(Routes.loginScreen);
    }
  }

  void _skipToEnd() {
    NavigationService.navigateToReplacementUntil(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingItems.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final item = onboardingItems[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              /// Fullscreen background image
              Image.asset(item["imageTitle"]!, fit: BoxFit.cover),

              /// Optional overlay (for text/buttons later)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Page indicator dots
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 0.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _skipToEnd,
                            child: Text(
                              "Skip",
                              style: TextFontStyle
                                  .headline24w400cFFFFFFMontserrat
                                  .copyWith(
                                    color: AppColor.cFFE6FEE6,
                                    fontSize: 16.sp,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 96.w,
                            height: 48.h,
                            child: CustomButton(
                              onTap: _goToNextPage,
                              btnName: 'Next',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next button
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
