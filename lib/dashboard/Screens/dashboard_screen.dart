import 'dart:convert';

import 'package:butterflix/dashboard/Screens/bottom_bar_item.dart';
import 'package:butterflix/explore/explore_screen.dart';
import 'package:butterflix/home/home_screen.dart';
import 'package:butterflix/user_profile/profile_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/watch_later/watch_later_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
ValueNotifier<int> selectedNotifier = ValueNotifier<int>(0);

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedNotifier,
        builder: (context, value, child) {
          return WillPopScope(
            onWillPop: () {
              if (pages[value].title == "Home") {
                return Future(() => true);
              } else {
                for (var page in pages) {
                  page.isSelect = false;
                }
                selectedNotifier.value = 0;
                pages[0].isSelect = true;
                setState(() {});
                return Future(() => false);
              }
            },
            child: Scaffold(
              body: pages[value].child,
              bottomNavigationBar: customBottomAppBar(),
              extendBody: true,
              resizeToAvoidBottomInset: false,
            ),
          );
        });
  }

  Widget customBottomAppBar() {
    return BottomAppBar(
      height: 65,
      padding: const EdgeInsets.symmetric(
          vertical: 3), // Adjust padding to reduce height
      elevation: 50,
      shadowColor: const Color.fromRGBO(229, 229, 229, 1),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          pages.length,
          (index) {
            return Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  for (var page in pages) {
                    page.isSelect = false;
                  }
                  selectedNotifier.value = index;
                  pages[index].isSelect = true;
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Ensures a compact height
                  children: [
                    _buildIcon(index),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    String iconPath = pages[index].bottomIcon;
    if (index == 0 && pages[index].isSelect) {
      iconPath = AppImages.home_icon_filled;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: pages[index].isSelect
            ? Theme.of(context).brightness == Brightness.light
                ? AppColors.Background_Blue
                : AppColors.Button_Yellow
            : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          iconPath,
          height: pages[index].isSelect ? 26 : 25,
          width: pages[index].isSelect ? 24 : 20,
          color: pages[index].isSelect
              ? Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black
              : Colors.black,
        ),
      ),
    );
  }
}

List<BottomBarItem> pages = [
  BottomBarItem(
    child: HomeScreen(),
    title: "Home",
    bottomIcon: AppImages.home_icon,
    isSelect: true,
  ),
  BottomBarItem(
    child: ExploreScreen(),
    title: "Explore",
    bottomIcon: AppImages.explore_icon,
    isSelect: false,
  ),
  BottomBarItem(
    child: const WatchLaterScreen(),
    title: "Watch Later",
    bottomIcon: AppImages.watch_later_icon,
    isSelect: false,
  ),
  BottomBarItem(
    child: ProfileScreen(),
    title: "Profile",
    bottomIcon: AppImages.user_icon,
    isSelect: false,
  ),
];
