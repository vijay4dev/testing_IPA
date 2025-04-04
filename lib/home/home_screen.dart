import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:butterflix/common_widgets/custom_buttons.dart';
import 'package:butterflix/home/all_movies_screen.dart';
import 'package:butterflix/movie_detail/movie_detail_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final List<String> genres = [
    "Romance",
    "Sci-Fi",
    "Documentary",
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Column(
            children: [
              const MovieHeader(),
              const SizedBox(height: 00),
              const ActionButtons(),
              const SizedBox(height: 20),
              MovieSection(
                title: "New Movies",
                onSeeAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllMoviesScreen(title: "New Movies"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const MovieList(),
              ),
              const SizedBox(height: 20),
              MovieSection(
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const MovieList(),
              ),
              30.hh,
            ],
          ),
        ),
      ),
    );
  }
}

class MovieHeader extends StatefulWidget {
  const MovieHeader({super.key});

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  Widget buildProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        items.length,
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

  List<String> categories = ["All", "Romance", "Horror", "Sports"];
  int selectedIndex = 1;
  int currentpage = 0;
  List<Widget> items = [
    Image.asset(
      AppImages.joker,
      fit: BoxFit.cover,
    ),
    Image.asset(
      AppImages.joker,
      fit: BoxFit.cover,
    ),
    Image.asset(
      AppImages.joker,
      fit: BoxFit.cover,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40, // Set height
              width: double.infinity,
              child: CarouselSlider(
                items: [
                  for (var image in [
                    AppImages.joker,
                    AppImages.joker,
                    AppImages.joker,
                  ])
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                ],
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.40,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    print("currentpage::: $index");
                  },
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth = constraints.maxWidth;
                        int categoryCount = categories.length;
                        bool shouldScroll = categoryCount * 100 >
                            maxWidth; // Estimate width per item

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: maxWidth * 0.01,
                                sigmaY: maxWidth * 0.01),
                            child: Container(
                              width: double.infinity,
                              height: 50, // Fixed height to prevent growth
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: shouldScroll
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            categories.length, (index) {
                                          return _buildCategoryItem(index,
                                              isExpanded: false);
                                        }),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(categories.length,
                                          (index) {
                                        return Expanded(
                                          child: _buildCategoryItem(index,
                                              isExpanded: true),
                                        );
                                      }),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors:  Theme.of(context).brightness == Brightness.light ?   [Colors.white.withOpacity(1), Colors.transparent] :[Colors.black.withOpacity(1), Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Helper function to build category item
  Widget _buildCategoryItem(int index, {required bool isExpanded}) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 1), // Reduce horizontal padding
        margin: const EdgeInsets.symmetric(
            horizontal: 4), // Reduce horizontal margin
        width: isExpanded ? null : 90, // Adjust width slightly if needed
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            categories[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          text: "Add to playlist",
          color: AppColors.playlist_btn_color,
          txtcolor: AppColors.txtcolor,
          onTap: () {},
        ),
        CustomButton(
          text: "Details",
          color: AppColors.Button_Yellow,
          txtcolor: AppColors.playlist_btn_color,
          onTap: () {},
        ),
      ],
    );
  }
}


class MovieSection extends StatelessWidget {
  final String title;
  bool showPadding;
  bool showArrow;
  final VoidCallback onSeeAllPressed;

  MovieSection(
      {super.key,
      required this.title,
      required this.onSeeAllPressed,
      this.showPadding = true,
      this.showArrow = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
              InkWell(
            onTap: onSeeAllPressed,
            child: showArrow
                ? Icon(Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).brightness == Brightness.light ?Colors.black : AppColors.Button_Yellow,
                )
                : Text(
                    "See More",
                    style: TextStyle(
                      fontFamily: AppFonts.medium,
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.light ?Color(0xff004AAD) : AppColors.Button_Yellow,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}


class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MovieCard(
            index: index,
          );
        },
      ),
    );
  }
}

class MovieCard extends StatefulWidget {
  int? index;
  MovieCard({super.key, this.index});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieDetailScreen()));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12.0, left: widget.index == 0 ? 7 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.21,
              width: MediaQuery.of(context).size.width * 0.36,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
              child: const Text(
                "Movie Title",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: AppFonts.medium, fontSize: 13),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
              child: const Text(
                "Subtitle",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text("4.5"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
