import 'package:butterflix/common_widgets/custom_popup.dart';
import 'package:butterflix/home/all_movies_screen.dart';
import 'package:butterflix/home/home_screen.dart';
import 'package:butterflix/movie_detail/movie_detail_screen.dart';
import 'package:butterflix/onboarding/screens/login_signup_screen.dart';
import 'package:butterflix/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchLaterScreen extends StatefulWidget {
  const WatchLaterScreen({super.key});

  @override
  State<WatchLaterScreen> createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkGuestMode();
  }

  Future<void> _checkGuestMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isGuest = prefs.getBool('isGuest') ?? false;
    // Debug: confirm the value from SharedPreferences
    print("Guest mode status: $isGuest");
    if (isGuest && mounted) {
      // Adding a slight delay to ensure the build context is fully ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showCustomDialog(context);
      });
    }
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            // dilog_icon: AppImages.logo,
            message:
                "It seems you're not logged in or signed up yet. Please do so first to add movies or shows to your Watch Later list.",
            buttonText1: 'Log in / Sign Up',
            buttonColor1: AppColors.Button_Yellow,
            onPressed1: () => Navigator.pop(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Watch Later",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 60),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: searchController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).iconTheme.color),
                    hintText: "Search here",
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xffC4C4C4)
                                  : AppColors.divider_color,
                          width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.Background_Blue
                                  : AppColors.Button_Yellow,
                          width: 1.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MovieSection(
                showPadding: true,
                showArrow: true,
                title: "Marvel Movies",
                onSeeAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllMoviesScreen(title: "Marvel Movies"),
                    ),
                  );
                },
              ),
              MovieListWidget(),
              MovieSection(
                showPadding: true,
                showArrow: true,
                title: "Sunday Special",
                onSeeAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllMoviesScreen(title: "Sunday Special"),
                    ),
                  );
                },
              ),
              MovieListWidget(),
              MovieSection(
                showPadding: true,
                showArrow: true,
                title: "Horror Movies",
                onSeeAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllMoviesScreen(title: "Horror Movies"),
                    ),
                  );
                },
              ),
              MovieListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return MovieItemWidget();
          },
        ),
      ),
    );
  }
}

class MovieItemWidget extends StatelessWidget {
  const MovieItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MovieDetailScreen()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[400]
                    : Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              "Parasite",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              "Drama",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ],
      ),
    );
  }
}
