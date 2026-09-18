import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/constants/color.dart';
import 'package:llr/helpers/ui_helpers.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;
  final int initialIndex;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    this.initialIndex = 0,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.tabs.length, (index) {
          final isSelected = index == selectedIndex;

          final textStyle = TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14.sp,
          );

          // Calculate text width for underline
          final textWidth = _calculateTextWidth(widget.tabs[index], textStyle);

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onTabSelected(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tabs[index],
                    style: TextFontStyle.headline14w400c637381Montserrat
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? AppColor.cFFFFFF : Color(0xff919EAB),
                        ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    height: 2.h,
                    width: isSelected ? textWidth : 0,
                    color: isSelected ? AppColor.cFFFFFF : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
