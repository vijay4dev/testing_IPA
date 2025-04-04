import 'package:butterflix/common_widgets/custom_dropdown.dart';
import 'package:butterflix/home/all_movies_screen.dart';
import 'package:butterflix/home/home_screen.dart';
import 'package:butterflix/movie_detail/movie_detail_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();

  String selectedGenre = "Genres";
  String selectedLanguage = "Language";
  String selectedYear = "Years";

  List<String> genres = ["Genres", "Action", "Romance", "Sci-Fi", "Horror"];
  List<String> languages = ["Language", "English", "Spanish", "French"];
  List<String> years = ["Years", "2022", "2023", "2024", "2025"];

  bool isFilterTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
             backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  surfaceTintColor: Colors.transparent, 

        centerTitle: true,
        title:  Text(
          "Explore",
                   style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
  
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                    hintText: "Search here",
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Color(0xffC4C4C4): AppColors.divider_color, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? AppColors.Background_Blue : AppColors.Button_Yellow, width: 1.5),
                    ),
                  ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        isFilterTapped = !isFilterTapped;
                        setState(() {
                          print("isFilterTapped:::: ${isFilterTapped}");
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: isFilterTapped
                                ? AppColors.Button_Yellow
                                : const Color(0xffDBDBDB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Image.asset(AppImages.filter_icon),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            isFilterTapped
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Last Search",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : AppColors.Button_Yellow,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.medium,
                                    fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                        10.hh,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffC7C8CA)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Avatar",
                                    style: TextStyle(color: Color(0xff96979B)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffC7C8CA)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Stranger Things",
                                    style: TextStyle(color: Color(0xff96979B)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffC7C8CA)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Harry Potter",
                                    style: TextStyle(color: Color(0xff96979B)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffC7C8CA)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Joker",
                                    style: TextStyle(color: Color(0xff96979B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        10.hh,
                        Text(
                          "Top Searches",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        10.hh,
                        Wrap(
                          spacing: 10, // Horizontal space between dropdowns
                          runSpacing: 10, // Vertical space when wrapped
                          children: [
                            buildDropdownButton(selectedLanguage, languages,
                                (value) {
                              setState(() {
                                selectedLanguage = value ?? "";
                              });
                            }),
                            buildDropdownButton(selectedGenre, genres, (value) {
                              setState(() {
                                selectedGenre = value ?? "";
                              });
                            }),
                            buildDropdownButton(selectedYear, years, (value) {
                              setState(() {
                                selectedYear = value ?? "";
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Hot Genres",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.autorenew_rounded,
                                color:Theme.of(context).brightness == Brightness.light ?  AppColors.Background_Blue : AppColors.Button_Yellow,
                              ),
                            ),
                          ],
                        ),
                        10.hh,
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: 12,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.Button_Yellow,
                                            width: 1.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffC4C4C4),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                        "Romantic",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

            const SizedBox(height: 20),

            /// New Movies Section
            MovieSection(
              showPadding: true,
              title: "New Movies",
              onSeeAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMoviesScreen(title: "New Movies"),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: MovieList(),
            ),
            const SizedBox(height: 15),

            const SizedBox(height: 20),

            MovieSection(
              showPadding: true,
              title: "Top Movies",
              onSeeAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMoviesScreen(title: "Top Movies"),
                  ),
                );
              },
            ),

            20.hh,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * .38,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // Align content to the center vertically
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize
                                      .min, // Prevents the Column from taking all available space
                                  children: [
                                    8.hh,
                                    const Text(
                                      "Movie Title",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),

                                    Text("Romance, Drama",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff838383)
                                    ),
                                    ),
                                    
                                 
                                    // const SizedBox(height: 10),
                                    // Wrap(
                                    //   spacing: 6.0,
                                    //   runSpacing: 4.0,
                                    //   children: genres.map((genre) {
                                    //     return GestureDetector(
                                    //       child: Material(
                                    //         borderRadius:
                                    //             BorderRadius.circular(18),
                                    //         elevation: 0.1,
                                    //         child: Container(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 8, vertical: 5),
                                    //           decoration: BoxDecoration(
                                    //             color: Color(0xffF5F5F5),
                                    //             borderRadius:
                                    //                 BorderRadius.circular(18),
                                    //           ),
                                    //           child: Text(
                                    //             genre,
                                    //             style: TextStyle(
                                    //               fontSize: 10,
                                    //               fontWeight: FontWeight.w500,
                                    //               color: Colors.black,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     );
                                    //   }).toList(),
                                    // ),
                                     const Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 18),
                                        SizedBox(width: 4),
                                        Text("4.5",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                               
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
