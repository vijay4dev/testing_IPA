import 'package:butterflix/screens_vijay/otp_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  bool showError = false;
  bool _obscureText = true;
  void validateLogin() {
    setState(() {
      confirmpasswordController.text = passwordController.text;
      print(
          "emailController:: ${emailController.text}   ${passwordController.text}");
      if (emailController.text != "test@gmail.com" ||
          passwordController.text != "password") {
        showError = true;
      } else if (passwordController.text != confirmpasswordController.text) {
        showError = true;
      } else {
        showError = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtpVerificationScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.Background_Blue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.Background_Blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              25.hh,
              Text("Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              5.hh,
              TextField(
                controller: emailController,
                style: TextStyle(color: AppColors.playlist_btn_color),
                decoration: InputDecoration(
                  hintText: "Type your Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              20.hh,
              Text("Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              5.hh,
              TextField(
                controller: passwordController,
                style: TextStyle(color: AppColors.playlist_btn_color),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Type your Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              20.hh,
              Text("Confirm Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              5.hh,
              TextField(
                controller: confirmpasswordController,
                style: TextStyle(color: AppColors.playlist_btn_color),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Type your Password again",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.playlist_btn_color,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              if (showError)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning, color: AppColors.warnignRed),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                            "Make sure Both password are same to continue",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
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
                child: Text("Sign Up",
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
              Column(
                children: [
                  _buildSocialButton(
                    text: "Continue With Google",
                    imagePath: "assets/images/Google.png",
                    onTap: () {
                      // Handle Google login
                    },
                  ),
                  15.hh,
                  _buildSocialButton(
                    text: "Continue With Facebook",
                    imagePath: "assets/images/Facebook.png",
                    onTap: () {
                      // Handle Facebook login
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSocialButton({
  required String text,
  required String imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath,
              height: 22), // Add Google/Facebook icon in assets
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
