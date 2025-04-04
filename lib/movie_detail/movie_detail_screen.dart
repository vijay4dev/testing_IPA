import 'dart:async';

import 'package:butterflix/common_widgets/checkbox_dialog.dart';
import 'package:butterflix/common_widgets/custom_dropdown.dart';
import 'package:butterflix/common_widgets/custom_popup.dart';
import 'package:butterflix/common_widgets/custom_progress.dart';
import 'package:butterflix/movie_detail/full_screen_movie.dart';
import 'package:butterflix/movie_detail/rating_gauge.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _controller;
  List<String> videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  double _volume = 1.0;
  bool _isFullScreen = false;
  int _selectedIndex = 0;
  String selectedSeason = "Season";
  List<String> seasons = [
    "Season",
    "Season 1",
    "Season 2",
    "Season 3",
    "Season 4",
  ];
  @override
  bool _hasShownLimitAlert = false;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    // Initialize the controller with the selected video URL
    _controller = VideoPlayerController.network(videoUrls[_selectedIndex]);
    await _controller.initialize();
    _controller.play();

    // Add the playback limit listener once initialization is complete.
    _controller.addListener(_checkPlaybackLimit);

    // Update UI after initialization.
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controlsTimer?.cancel();
    _controller.removeListener(_checkPlaybackLimit);
    _controller.dispose();
    super.dispose();
  }

  void _checkPlaybackLimit() {
    // Pause the video if playback reaches 5 minutes.
    if (_controller.value.position >= Duration(minutes: 5)) {
      _controller.pause();
      if (!_hasShownLimitAlert) {
        _hasShownLimitAlert = true;
        _showPlaybackLimitAlert();
      }
      if (mounted) setState(() {});
    }
  }

  void _showPlaybackLimitAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Playback Limit Reached"),
        content: Text("The video has reached its playback limit of 5 minutes."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Optional: Reset the flag if you wish to allow alert on next play
              _hasShownLimitAlert = false;
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _resetControlsTimer() {
    setState(() => _showControls = true);

    _controlsTimer?.cancel();
    _controlsTimer = Timer(Duration(seconds: 3), () {
      setState(() => _showControls = true);
    });
  }

  bool _showControls = true;
  Timer? _controlsTimer;

  void toggleFullScreen(BuildContext context) {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FullScreenVideo(controller: _controller),
      ));
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Navigator.of(context).pop();
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Video Player Container
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.40, // 35% of screen height
                    child: _controller.value.isInitialized
                        ? ClipRRect(
                            child: Stack(
                              children: [
                                // Video Player
                                Positioned.fill(
                                  child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                ),

                                // Tap Gesture to Show/Hide Controls
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showControls =
                                            !_showControls; // Toggle controls
                                        if (_showControls) {
                                          _resetControlsTimer();
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: Colors
                                          .transparent, // Ensures taps are registered
                                    ),
                                  ),
                                ),

                                // Play/Pause & Seek Buttons (Centered)
                                Positioned.fill(
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity: _showControls
                                        ? 1.0
                                        : 0.0, // Hide after timeout
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // 10 sec Backward Button
                                        IconButton(
                                          icon: Icon(Icons.replay_10,
                                              size: 40, color: Colors.white),
                                          onPressed: () {
                                            _controller.seekTo(
                                              Duration(
                                                  seconds: _controller.value
                                                          .position.inSeconds -
                                                      10),
                                            );
                                            _resetControlsTimer();
                                          },
                                        ),

                                        SizedBox(width: 20), // Spacing

                                        // Play/Pause Button
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _controller.value.isPlaying
                                                  ? _controller.pause()
                                                  : _controller.play();
                                              _resetControlsTimer();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black54,
                                            radius: 30,
                                            child: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 20), // Spacing

                                        // 10 sec Forward Button
                                        IconButton(
                                          icon: Icon(Icons.forward_10,
                                              size: 40, color: Colors.white),
                                          onPressed: () {
                                            _controller.seekTo(
                                              Duration(
                                                  seconds: _controller.value
                                                          .position.inSeconds +
                                                      10),
                                            );
                                            _resetControlsTimer();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Bottom Controls (Progress Bar, Volume, Fullscreen)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity: _showControls
                                        ? 1.0
                                        : 0.0, // Hide controls after timeout
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black54,
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Row with Volume, Progress Bar, and Fullscreen Button
                                          Row(
                                            children: [
                                              // Volume Button
                                              IconButton(
                                                icon: Icon(
                                                  _volume == 1.0
                                                      ? Icons.volume_up
                                                      : Icons.volume_off,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _volume = _volume == 1.0
                                                        ? 0.0
                                                        : 1.0;
                                                    _controller
                                                        .setVolume(_volume);
                                                    _resetControlsTimer();
                                                  });
                                                },
                                              ),

                                              // Expanded Progress Bar
                                              Expanded(
                                                child: ValueListenableBuilder<
                                                    VideoPlayerValue>(
                                                  valueListenable: _controller,
                                                  builder:
                                                      (context, value, child) {
                                                    return Slider(
                                                      value: value
                                                          .position.inSeconds
                                                          .toDouble(),
                                                      max: value
                                                          .duration.inSeconds
                                                          .toDouble(),
                                                      onChanged: (newValue) {
                                                        _controller.seekTo(
                                                            Duration(
                                                                seconds: newValue
                                                                    .toInt()));
                                                        _resetControlsTimer();
                                                      },
                                                      activeColor: Colors.red,
                                                      inactiveColor:
                                                          Colors.white30,
                                                    );
                                                  },
                                                ),
                                              ),

                                              // Fullscreen Button
                                              IconButton(
                                                icon: Icon(
                                                  _isFullScreen
                                                      ? Icons.fullscreen_exit
                                                      : Icons.fullscreen,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  toggleFullScreen(context);
                                                },
                                              ),
                                            ],
                                          ),

                                          // Time Labels (Below the Slider)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ValueListenableBuilder<
                                                VideoPlayerValue>(
                                              valueListenable: _controller,
                                              builder: (context, value, child) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _formatDuration(
                                                          value.position),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      _formatDuration(
                                                          value.duration),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),

                  Positioned(
                    top: 45,
                    left: 15,
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white),
                        ),
                        Text(
                          "The Glory",
                          style: TextStyle(
                            fontFamily: AppFonts.medium,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.cast, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 7),
                        child: Row(
                          children: [
                            Text(
                              "The Glory",
                              style: TextStyle(
                                fontFamily: AppFonts.semibold,
                                fontSize: 18,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground, // Adaptive text color
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Share.share(
                                        'check out my website https://example.com');
                                  },
                                  child: Icon(Icons.file_upload_outlined,
                                      color: AppColors.Button_Yellow),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CheckboxDialog(
                                          options: [
                                            "Option 1",
                                            "Option 2",
                                            "Option 3",
                                            "Option 4"
                                          ],
                                          onSelected: (selectedItems) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Selected: ${selectedItems.join(', ')}")),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.add_circle_outline,
                                      color: AppColors.Button_Yellow),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "2022 | 18+ | 1 Season | K-Drama",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "A young woman, bullied to the point of deciding to drop out of school, plans the best way to get revenge. After becoming a primary school teacher, she takes in the son of the man who tormented her the most to enact her vengeance.",
                          maxLines: 5,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Cast",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.semibold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey[400]
                                          : Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 75,
                                    width: 75,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.0),
                                    child: SizedBox(
                                      width: 75,
                                      child: Text(
                                        "Tom Riddle",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      TabBar(
                        labelColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).colorScheme.primary
                                : AppColors.Button_Yellow,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.onSurface,
                        indicatorColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).colorScheme.primary
                                : AppColors.Button_Yellow,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: AppColors.divider_color,
                        tabs: [
                          Tab(text: "Episodes"),
                          Tab(text: "About"),
                          Tab(text: "Review"),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildScrollableContent(EpisodesTab()),
                            _buildScrollableContent(AboutTab()),
                            _buildScrollableContent(ReviewTab()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(Widget child) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }

  Widget EpisodesTab() {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IntrinsicHeight(
            child: Column(
              children: [
                if (index == 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildDropdownButton(selectedSeason, seasons, (value) {
                          setState(() {
                            selectedSeason = value ?? "";
                          });
                        }),
                      ],
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 85,
                        width: MediaQuery.of(context).size.width * .38,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey[400] // Light theme color
                                  : Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant, // Dark theme color
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Vanishing of Will Byers Will Byers",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground, // Adaptive text color
                              fontSize: 14,
                              fontFamily: AppFonts.medium,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "49 minutes",
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6), // Subtle color
                              fontFamily: AppFonts.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "On his way home from a friend’s house, young Will sees something terrifying. Nearby, a sinister secret lurks in the depths of a government lab.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget AboutTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "On his way home from a friend’s house, young Will sees something terrifying. Nearby, a sinister secret ;urks in the depths of a government lab.",
        style: TextStyle(fontSize: 12, color: Color(0xff838383)),
      ),
    );
  }

  Widget ReviewTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.amberAccent,
          height: 280,
          child: RatingGaugeDemo(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                border: Border.all(color: AppColors.divider_color),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Image.asset(AppImages.tomato_icon),
                    Text(
                      "97%",
                      style: TextStyle(
                        fontFamily: AppFonts.semibold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      "Rotten Tomatoes",
                      style: TextStyle(
                        fontFamily: AppFonts.medium,
                        fontSize: 8,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                border: Border.all(color: AppColors.divider_color),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Column(
                  children: [
                    Image.asset(AppImages.imdb_icon),
                    Text(
                      "97%",
                      style: TextStyle(
                        fontFamily: AppFonts.semibold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      "IMDb",
                      style: TextStyle(
                        fontFamily: AppFonts.medium,
                        fontSize: 8,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 85,
              width: 85,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                border: Border.all(color: AppColors.divider_color),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.letterboxd_icon),
                  SizedBox(height: 4),
                  RatingBar.builder(
                    minRating: 1,
                    initialRating: 3,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 12,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Letterboxd",
                    style: TextStyle(
                      fontFamily: AppFonts.medium,
                      fontSize: 8,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _showLimitAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          dilog_icon: AppImages.logo,
          message:
              'You just watched 15 minutes of this movie if you want to watch the complete movie then please.',
          buttonText1: 'Subscribe',
          buttonText2: 'Rent a movie/show',
          buttonColor1: AppColors.Button_Yellow,
          buttonColor2: AppColors.button2_color,
          onPressed1: () => Navigator.pop(context),
          onPressed2: () => Navigator.pop(context),
        );
      },
    );
  }
}
