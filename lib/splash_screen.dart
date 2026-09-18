import 'package:flutter/material.dart';
import 'package:llr/gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.llrSplashScreen.path),
          ),
        ),
      ),
    );
  }
}
