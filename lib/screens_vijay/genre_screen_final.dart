import 'package:butterflix/common_widgets/carousel_widget.dart';
import 'package:butterflix/onboarding/screens/login_signup_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenreScreenFinal extends StatefulWidget {
  const GenreScreenFinal({super.key});

  @override
  State<GenreScreenFinal> createState() => _GenreScreenFinalState();
}

class _GenreScreenFinalState extends State<GenreScreenFinal> {
  final List<String> genres = [
    "🎭 Drama",
    "🎬 Action",
    "😂 Comedy",
    "👻 Horror",
    "❤️ Romance",
    "🛸 Sci-Fi",
    "📝 Documentary",
  ];

  // Set to track genres
  Set<String> selectedGenres = {};

  // Function to toggle genre selection
  void toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre); // Deselect if already selected
      } else {
        selectedGenres.add(genre); // Select if not selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background_Blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Column(
                children: [
                  30.hh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.semibold,
                            fontSize: 32),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Genres",
                        style: TextStyle(
                            color: AppColors.Button_Yellow,
                            fontFamily: AppFonts.semibold,
                            fontSize: 32),
                      ),
                    ],
                  ),
                  5.hh,
                  Text(
                    "Please select genres from below for best experience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              40.hh,

              // Carousel Section
              CarouselWidget(is_autoplay: true),
              50.hh,

              // Genre Selection Section
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Wrap(
                  spacing: 8.0, // Horizontal space between chips
                  runSpacing: 8.0, // Vertical space between chips
                  children: genres.map((genre) {
                    return GestureDetector(
                      onTap: () =>
                          toggleGenre(genre), // Toggle selection on tap
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: selectedGenres.contains(genre)
                              ? Colors.yellow // Yellow background if selected
                              : Colors
                                  .white, // White background if not selected
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: selectedGenres.contains(genre)
                                ? Colors.black // Black text if selected
                                : Colors.black, // Black text if not selected
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 30),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.setBool('isGuest', false);
                  Navigator.pushNamedAndRemoveUntil(
                      GlobalVariable.navState.currentContext!,
                      AppScreen.dashboard,
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
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.setBool('isGuest', false);
                  Navigator.pushNamedAndRemoveUntil(
                      GlobalVariable.navState.currentContext!,
                      AppScreen.dashboard,
                      (r) => false);
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
    );
  }
}
