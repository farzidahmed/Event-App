import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';

void showPickImageBottomSheet(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier, {
  bool showCameraOption = true,
}) {
  // final textTheme = Theme.of(
  //   context,
  // ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),

    // showDragHandle: false,
    context: context,
    backgroundColor: const Color(0xFF202123),
    builder:
        (BuildContext context) => Container(
          padding: EdgeInsets.all(24.sp),
          height: 140.h,
          decoration: BoxDecoration(
            color: const Color(0xFF202123),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  selectImageFromCamera(context, imageFileNotifier);
                  NavigationService.goBack;
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 24.w,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "Take a Photo",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  selectImageFromGallery(context, imageFileNotifier);
                  NavigationService.goBack;
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                      size: 24.w,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "Choose from Album",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}

Future<void> selectImageFromCamera(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
  }
  // Collapse the modal popup menu for hiding bottom sheet
  if (context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> selectImageFromGallery(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
    // Collapse the modal popup menu for hiding bottom sheet
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key, required this.name, required this.style});

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.sp),
      child: Text(name, style: style.copyWith(letterSpacing: 1.0)),
    );
  }
}

imagePickerDialog(BuildContext context, ValueNotifier<File?> imageNotifier) {
  return showModalBottomSheet(
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    context: context,
    backgroundColor: const Color(0xFF202123),
    builder:
        (_) => Container(
          height: 130.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF202123),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  pickImage(imageNotifier, ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 24.w,
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      "Take a Photo".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  pickImage(imageNotifier, ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                      size: 24.w,
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      "Choose from Album".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}

Future<void> pickImage(
  ValueNotifier<File?> imageNotifier,
  ImageSource source,
) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    imageNotifier.value = File(pickedFile.path); // Update the ValueNotifier
  }
}
