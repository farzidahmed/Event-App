import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:shimmer/shimmer.dart';


class CustomNetworkImage extends StatelessWidget {
  final String urls;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Alignment? alignment;

  const CustomNetworkImage({
    super.key,
    required this.urls,
    this.width,
    this.height,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final imgWidth = width ?? 90.w;
    final imgHeight = height ?? 70.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      child: CachedNetworkImage(
        alignment: alignment ?? Alignment.topCenter,
        imageUrl: urls,
        width: imgWidth,
        height: imgHeight,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: const Color(0xFF2C2C2E),
              highlightColor: const Color(0xFF3A3A3C),
              child: Container(
                width: imgWidth,
                height: imgHeight,
                color: Colors.black,
              ),
            ),
        errorWidget:
            (context, string, url) => Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202123),
              ),
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white54,
                  size: (imgWidth < imgHeight ? imgWidth : imgHeight) * 0.4,
                ),
              ),
            ),
      ),
    );
  }
}
