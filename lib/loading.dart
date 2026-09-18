import 'package:flutter/material.dart';
import 'package:llr/features/navigation_screen.dart';
import 'package:llr/features/onborading/onborading_screen.dart';
import 'package:llr/networks/dio/dio.dart';

import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helpers_method.dart';
import 'splash_screen.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  bool _isLoading = true;

  loadInitialData() async {
    await setInitValue();

    bool data = appData.read(kKeyIsLoggedIn) ?? false;
    if (data) {
      String token = appData.read(kKeyAccessToken);

      DioSingleton.instance.update(token);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      return !appData.read(kKeyIsFirstTime)
          ? OnboardingScreenUpdate()
          : appData.read(kKeyIsLoggedIn)
          ? NavigationScreen()
          : OnboardingScreenUpdate();
      // : const OnboardingScreen();
    }
  }
}
