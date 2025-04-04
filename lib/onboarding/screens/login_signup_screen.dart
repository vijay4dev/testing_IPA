import 'package:butterflix/common_widgets/custom_buttons.dart';
import 'package:butterflix/screens_vijay/login_screen.dart';
import 'package:butterflix/screens_vijay/signup_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: AppColors.Background_Blue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(AppImages.logo),
            ),
            50.hh,
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.Button_Yellow,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(fontFamily: AppFonts.medium, fontSize: 22),
                  ),
                ),
              ),
            ),
            25.hh,
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.Background_Blue,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: AppColors.Button_Yellow),
                ),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: AppFonts.medium,
                      color: AppColors.Button_Yellow,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            30.hh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white10,
                            Colors.white54,
                            AppColors.Button_Yellow
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Or",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: AppFonts.semibold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.Button_Yellow,
                            Colors.white54,
                            Colors.white10,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            30.hh,
            RichText(
              text: TextSpan(
                text: "Watch Movie / Show as ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: AppFonts.medium,
                ),
                children: [
                  TextSpan(
                    text: "Guest",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setBool('isGuest', true);
                        Navigator.pushNamedAndRemoveUntil(
                            GlobalVariable.navState.currentContext!,
                            AppScreen.dashboard,
                            (r) => false);
                      },
                    style: TextStyle(
                      color: AppColors.Button_Yellow,
                      fontSize: 18,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
