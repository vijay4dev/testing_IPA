import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLocalUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background_Blue,
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 10,
              child: Image.asset(AppImages.splash_vector)),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(AppImages.logo),
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkLocalUser() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      Navigator.pushNamedAndRemoveUntil(GlobalVariable.navState.currentContext!,
          AppScreen.onBoardingScreen, (r) => false);
    });
  }
}
