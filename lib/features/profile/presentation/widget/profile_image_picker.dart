import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/gen/assets.gen.dart';

class ProfileImagePicker extends StatelessWidget {
  final ValueNotifier<XFile?> imageNotifier;
  final VoidCallback onTap;
  final String placeholderUrl;
  final double size;

  const ProfileImagePicker({
    super.key,
    required this.imageNotifier,
    required this.onTap,
    required this.placeholderUrl,
    this.size = 96.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: imageNotifier,
        builder: (context, value, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child:
                    value == null
                        ? CustomNetworkImage(
                          width: size.h,
                          height: size.h,
                          borderRadius: 100.r,
                          urls: placeholderUrl,
                        )
                        : Image.file(
                          File(value.path),
                          width: 96.h,
                          height: 96.h,
                          fit: BoxFit.cover,
                        ),
              ),
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 26.h,
                    width: 26.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.cFFFFFF),
                      color: const Color(0xFF9F4FFB),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(Assets.images.editIcon.path),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
