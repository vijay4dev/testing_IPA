import 'package:butterflix/forget_password/forget_pass_mail.dart';
import 'package:butterflix/screens_vijay/otp_screen.dart';
import 'package:butterflix/screens_vijay/signup_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showError = false;
  bool _isChecked = false;
  bool _obscureText = true;
  Future<void> validateLogin() async {
    setState(() {
      if (emailController.text != "test@example.com" ||
          passwordController.text != "password") {
        showError = true;
      } else {
        showError = false;
      }
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isGuest', false);
    Navigator.pushNamedAndRemoveUntil(GlobalVariable.navState.currentContext!,
        AppScreen.dashboard, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Log In",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),
        ),
        leading: Icon(
          (Icons.arrow_back_ios), color: Colors.transparent,
          // onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.Background_Blue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.Background_Blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.hh,
              Text("Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              5.hh,
              Container(
                height: 50,
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: AppColors.playlist_btn_color),
                  decoration: InputDecoration(
                    hintText: "Type your Email",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              25.hh,
              Text("Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              5.hh,
              Container(
                height: 50,
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  style: TextStyle(color: AppColors.playlist_btn_color),
                  decoration: InputDecoration(
                    hintText: "Type your Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color.fromARGB(196, 0, 0, 0),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (showError)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: AppColors.warnignRed),
                      SizedBox(width: 5),
                      Text("Password or email is invalid",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          activeColor: AppColors.Button_Yellow,
                          checkColor: AppColors.Background_Blue,
                          side: BorderSide(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          }),
                      Text("Remember me",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassMailScreen()));
                    },
                    child: Text("Forgot password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateLogin,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.Button_Yellow,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Log In",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
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
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: AppFonts.medium,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                            color: AppColors.Button_Yellow,
                            fontSize: 18,
                            fontFamily: AppFonts.medium,
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
