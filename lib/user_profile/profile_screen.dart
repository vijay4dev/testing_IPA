import 'dart:io';

import 'package:butterflix/common_widgets/custom_buttons.dart';
import 'package:butterflix/common_widgets/image_pick.dart';
import 'package:butterflix/common_widgets/settings_row.dart';
import 'package:butterflix/home/home_screen.dart';
import 'package:butterflix/movie_detail/movie_detail_screen.dart';
import 'package:butterflix/onboarding/screens/login_signup_screen.dart';
import 'package:butterflix/request_movie/request_movie.dart';
import 'package:butterflix/user_profile/plans_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String userName = 'Alison Parker';
  String userEmail = 'Alisonparker2025@gmail.com';
  bool isGuest = true;

  @override
  void initState() {
    checkIsGuest();

    super.initState();
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
          "Account",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.Button_Yellow),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('isGuest');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                (route) => false,
              );
              print("Settings icon tapped");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12,
                  top: 18,
                ),
                child: isGuest
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.Background_Blue
                                        : AppColors.Button_Yellow),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff464646),
                                  ),
                                  child: Image.asset(AppImages.guest_icon),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Guest User",
                                    style: TextStyle(
                                        fontFamily: AppFonts.semibold,
                                        fontSize: 18),
                                  ),
                                  3.hh,
                                  Text(
                                    "Created on 12/01/2005",
                                    style: TextStyle(
                                        fontFamily: AppFonts.medium,
                                        fontSize: 12,
                                        color: Color(0xff6A6868)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.primary
                                  : AppColors
                                      .Button_Yellow, // Adaptive primary color
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCustomBottomSheet(
                                      context, userName, userEmail);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 78,
                                          width: 78,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          child: _selectedImage != null
                                              ? ClipOval(
                                                  child: Image.file(
                                                    _selectedImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  AppImages.user_icon),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alison Parker",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontFamily: AppFonts.semibold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "Alisonparker2025@gmail.com",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withOpacity(0.8),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              20.hh,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(
                      "Recent Watch",
                      style: TextStyle(
                          fontFamily: AppFonts.semibold, fontSize: 18),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.Button_Yellow,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              isGuest
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                                text:
                                    "To get access to recent watched movies and shows, to purchase a subscription plan please first ",
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                )),
                            TextSpan(
                              text: "register / login",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.Background_Blue
                                      : Colors.white,
                                  fontFamily: AppFonts.medium,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Register Clicked");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginSignupScreen()),
                                    (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      // color: Colors.blueAccent,
                      height: 240,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailScreen()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 8.0 : 2),
                                    child: Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 8.0 : 2),
                                      child: const Text(
                                        "Movie Title",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: AppFonts.semibold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 8.0 : 2),
                                      child: const Text(
                                        "Subtitle",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 12, right: 18, bottom: 20),
                child: Divider(
                  color: AppColors.divider_color,
                ),
              ),
              SettingsItem(
                icon: Icons.notifications,
                title: "Notifications",
                onTap: () => print("Notifications Clicked"),
              ),
              15.hh,
              SettingsItem(
                  icon: Icons.star_rounded,
                  title: "Subscribe Now",
                  subtitle: "(Enjoy unlimited movies & shows)",
                  iconColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.Background_Blue
                      : AppColors.Button_Yellow,
                  onTap: () {
                    if (isGuest) {
                      showCustomToast();
                    } else {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return Material(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor, // Adapts to theme
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header Row
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Subscription",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.color,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: Icon(Icons.close, size: 30),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    // Plan Selection Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary, // Adapt color
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: const Text(
                                            "Gold Plan",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary, // Dark mode color
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: Text(
                                            "Premium",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),

                                    // Subscription Details
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Price header
                                          Container(
                                            width: double.infinity,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColorDark, // Adapt color
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                width: 1,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$9.99 USD',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontSize: 30,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                Text(
                                                  '/ MO',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.color,
                                                    fontSize: 30,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Features container
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .cardColor, // Adapt to dark mode
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                                width: 1,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                _buildFeatureItem(
                                                  'Free Installation With Remote Assistance On Your\n4K (Ultra HD) Amazon Fire TV With Alexa App',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  '24-Hour Technical Support To Assist You At\nAny Time',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  'Right To Request Additional Exclusive Content\nPer Month',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  'Enjoy Butterflix On All Your Devices At The\nSame Time And Without Ads',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  'New Movies And Series Every Week',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  'Early Access To New Releases And Special\nContent Before Other Users',
                                                ),
                                                const SizedBox(height: 22),
                                                _buildFeatureItem(
                                                  'HD Surround Sound For A Home Theater\nExperience',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),

                                          // Bottom Button
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary, // Adapt color
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 10),
                                            child: const Text(
                                              "Gold Plan",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 12, right: 18, bottom: 20),
                child: Divider(
                  color: AppColors.divider_color,
                ),
              ),
              SettingsItem(
                imagePath: AppImages.language_icon,
                title: "Language",
                onTap: () => print("Language Clicked"),
              ),
              15.hh,
              SettingsItem(
                imagePath: AppImages.request_movie_icon,
                title: "Request a movie",
                isDisabled: isGuest,
                onTap: () {
                  print("tapping here>>");
                  if (isGuest) {
                    showCustomToast();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestMovieScreen()));
                  }
                },
              ),
              15.hh,
              SettingsItem(
                icon: Icons.settings,
                title: "Settings",
                onTap: () => print("Settings Clicked"),
              ),
              15.hh,
              SettingsItem(
                imagePath: AppImages.privacy_icon,
                title: "Privacy & Security",
                onTap: () => print("Privacy & Security Clicked"),
              ),
              15.hh,
              SettingsItem(
                imagePath: AppImages.WhatsApp_icon,
                title: "Contact Us",
                iconColor: Color(0xff25D366),
                onTap: () => print("Whatsapp redirect"),
              ),
              80.hh,
            ],
          ),
        ),
      ),
    );
  }

  void showCustomToast() {
    FToast fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: AppColors.Background_Blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Subscription and request movie are disabled for guest users.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.Button_Yellow,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void showCustomBottomSheet(BuildContext context, String name, String email) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _BottomSheetContent(
          email: email,
          name: name,
        );
      },
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Non-toggleable checkbox
        SizedBox(
          width: 15,
          height: 15,
          child: Checkbox(
            value: true,
            onChanged: null, // Null makes it non-interactive
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  Theme.of(context).primaryColor, // Adapts to theme
            ),
            checkColor: Theme.of(context).colorScheme.secondary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),

        const SizedBox(width: 18),

        // Feature text
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color, // Adapts to theme
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> checkIsGuest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('isGuest');
    isGuest = repeat ?? false;

    setState(() {});
  }
}

class _BottomSheetContent extends StatefulWidget {
  final String name;
  final String email;

  _BottomSheetContent({required this.name, required this.email});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode(); // FocusNode to control focus

  TextEditingController emailController = new TextEditingController();

  TextEditingController passController = new TextEditingController();

  final List<String> genres = [
    "🎭 Drama",
    "🎬 Action",
    "😂 Comedy",
    "👻 Horror",
    "❤️ Romance",
    "🛸 Sci-Fi",
    "📝 Documentary",
  ];

  Set<String> selectedGenres = {};

  void toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  @override
  void initState() {
    nameController.text = widget.name;
    emailController.text = widget.email;
    passController.text = "password";

    nameFocusNode.addListener(() => _handleFocusChange("name"));
    emailFocusNode.addListener(() => _handleFocusChange("email"));
    passwordFocusNode.addListener(() => _handleFocusChange("password"));
    super.initState();
  }

  void _handleFocusChange(String field) {
    if (field == "name" && !nameFocusNode.hasFocus) {
      setState(() => _isEditingName = false);
    } else if (field == "email" && !emailFocusNode.hasFocus) {
      setState(() => _isEditingEmail = false);
    } else if (field == "password" && !passwordFocusNode.hasFocus) {
      setState(() => _isEditingPassword = false);
    }
  }

  void _enableEditing(String field) {
    setState(() {
      if (field == "name") _isEditingName = true;
      if (field == "email") _isEditingEmail = true;
      if (field == "password") _isEditingPassword = true;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      if (field == "name") nameFocusNode.requestFocus();
      if (field == "email") emailFocusNode.requestFocus();
      if (field == "password") passwordFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 10),
        decoration: BoxDecoration(
          color:
              Theme.of(context).scaffoldBackgroundColor, // Dynamic background
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color, // Adapts to theme
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context)
                            .iconTheme
                            .color, // Adapts to theme
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).dividerColor ??
                              Colors.grey, // Theme border color
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 78,
                          width: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Dynamic color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: _buildButton(
                          "Edit Photo",
                          Theme.of(context).brightness == Brightness.light
                              ? AppColors.Background_Blue
                              : AppColors.Button_Yellow
                          // Dynamic button color
                          ),
                    ),
                    SizedBox(width: 15),
                    _buildButton(
                      "Remove",
                      AppColors.warnignRed, // Dynamic error color
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                    color: Theme.of(context).dividerColor), // Dynamic divider
                SizedBox(height: 20),

                _buildEditableField(
                  label: "FULL NAME",
                  field: "name",
                  controller: nameController,
                  focusNode: nameFocusNode,
                  isEditing: _isEditingName,
                ),
                _buildEditableField(
                  label: "EMAIL",
                  field: "email",
                  controller: emailController,
                  focusNode: emailFocusNode,
                  isEditing: _isEditingEmail,
                ),
                _buildEditableField(
                  label: "PASSWORD",
                  field: "password",
                  isObscure: true,
                  controller: passController,
                  focusNode: passwordFocusNode,
                  isEditing: _isEditingPassword,
                ),

                SizedBox(height: 10),
                Text(
                  "Favourite Genres",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontFamily: AppFonts.medium,
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 15.0,
                  children: genres.map((genre) {
                    bool isSelected = selectedGenres.contains(genre);
                    return GestureDetector(
                      onTap: () => toggleGenre(genre),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).dividerColor ?? Colors.grey,
                          ),
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "Update Profile",
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).primaryColor
                          : AppColors.Button_Yellow,
                      txtcolor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomButton(
                      text: "Delete Profile",
                      color: AppColors.warnignRed,
                      txtcolor: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }

  Widget _buildEditableField({
    required String label,
    required String field,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isEditing,
    bool isObscure = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color, // Adapts to theme
              fontFamily: AppFonts.medium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  focusNode.requestFocus();
                  controller.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: controller.text.length,
                  );
                  _enableEditing(field);
                },
                child: Text(
                  "Edit",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.Background_Blue
                        : Colors.white,
                    fontFamily: AppFonts.medium,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText:
                isObscure && !focusNode.hasFocus, // Show text when focused
            readOnly: !isEditing,

            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(bottom: 20, left: isEditing ? 5 : 0),
              hintText: "Enter ${label.toLowerCase()}",
              hintStyle: TextStyle(
                color: Theme.of(context).hintColor, // Adapts hint text color
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor ??
                      Colors.grey, // Theme-based border color
                  width: 1.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.Background_Blue
                      : AppColors.Button_Yellow, // Uses primary color for focus
                  width: 1.0,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor ??
                      Colors.grey, // Default to divider color
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.txtcolor),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    File? image = await ImagePickerHelper.showImagePicker(context);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }
}

File? _selectedImage;
