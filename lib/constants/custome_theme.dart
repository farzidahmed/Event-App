import 'package:flutter/material.dart';
import 'package:llr/assets_helper/color.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFF2953A5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF2953A5), //10%
      100: Color(0xFF2953A5), //20%
      200: Color(0xFF2953A5), //30%
      300: Color(0xFF2953A5), //40%
      400: Color(0xFF2953A5), //50%
      500: Color(0xFF2953A5), //60%
      600: Color(0xFF2953A5), //70%
      700: Color(0xFF2953A5), //80%
      800: Color(0xFF2953A5), //80%
      900: Color(0xFF2953A5), //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColor.primaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColor.scaffoldColor,
      useMaterial3: true,
    );
  }
}
