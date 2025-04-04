import 'package:butterflix/common_widgets/custom_buttons.dart';
import 'package:butterflix/onboarding/model/orboarding_model.dart';
import 'package:butterflix/onboarding/screens/login_signup_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardPageData> onBoardPage = [
    OnBoardPageData(
        description:
            "Explore a world of endless entertainment and find your next favorite movie with just a click. Your movie journey starts here.",
        image: AppImages.dashboard1,
        title: "JoyRide - Your hassle-free ride-sharing solution"),
    OnBoardPageData(
        description:
            "personalized movie library. Save your favorite movies and TV shows to your watchlist so you never forget what to watch next.",
        image: AppImages.dashboard2,
        title: "Discover available rides tailored to your needs"),
    OnBoardPageData(
        description:
            "Can't find your favorite movie? Let us know! Request movies or TV shows you’d like to see added to Butterflix.",
        image: AppImages.dashboard3,
        title: "Enjoy a seamless ride-sharing experience."),
  ];

  List<Widget> items = [
    Image.asset(AppImages.banner),
    Image.asset(AppImages.banner),
    Image.asset(AppImages.banner)
  ];

  List<String> onboardingImages = [
    AppImages.dashboard1,
    AppImages.dashboard2,
    AppImages.dashboard3
  ];

  int currentpage = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          GlobalVariable.navState.currentContext!,
                          AppScreen.LoginSignupScreen,
                          (r) => false);
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.Button_Yellow),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: AppColors.Button_Yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.ww,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("currentpage::: ${currentpage}");
                      if (currentpage == 2) {
                        Navigator.pushNamedAndRemoveUntil(
                            GlobalVariable.navState.currentContext!,
                            AppScreen.LoginSignupScreen,
                            (r) => false);
                      } else {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: AppColors.Button_Yellow,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          // ),

          backgroundColor: AppColors.Background_Blue,
          body: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: onBoardPage.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentpage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "Discover Your Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppFonts.semibold,

                                      // fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Movie",
                                  style: TextStyle(
                                      color: AppColors.Button_Yellow,
                                      fontFamily: AppFonts.semibold,
                                      fontSize: 32),
                                ),
                                20.hh,
                                Container(
                                  // color: Colors.amber,
                                  child: CarouselSlider(
                                      items: items,
                                      options: CarouselOptions(
                                        height: context.height * 0.32,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.48,
                                        initialPage: 1,
                                        enableInfiniteScroll: false,
                                        reverse: false,
                                        autoPlay: false,

                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        onPageChanged: (index, reason) {
                                          //  pageController.nextPage(
                                          //                                 duration:
                                          //                                     Duration(milliseconds: 500), // You can adjust the duration
                                          //                                 curve: Curves.ease,
                                          //                               );
                                        },
                                        // onPageChanged: callbackFunction,
                                        scrollDirection: Axis.horizontal,
                                      )),
                                ),
                                30.hh,
                                _buildImages(),
                                20.hh,
                                _buildProgress(),
                                20.hh,
                                _buildTitleAndDis(),
                              ],
                            ),
                          );
                        }))
              ],
            ),
          )),
    );
  }

  Widget _buildCrousal() {
    return Container(
      width: double.infinity,
      child: Center(
        child: Image.asset(
          onBoardPage[currentpage].image!,
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onBoardPage.length,
        (index) => Container(
          height: 7,
          width: 55,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: index == currentpage ? AppColors.Button_Yellow : null,
            border: Border.all(color: const Color(0xff999999)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildImages() {
    return Image.asset(onboardingImages[currentpage]);
  }

  Widget _buildTitleAndDis() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.width * 0.85),
      child: Column(
        children: [
          Text(
            onBoardPage[currentpage].description,
            textAlign: TextAlign.center,
            // maxLines: 5,
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: AppFonts.medium,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
