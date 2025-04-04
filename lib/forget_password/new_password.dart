import 'package:butterflix/forget_password/forget_pass_code.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background_Blue,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.Background_Blue,
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white, fontFamily: AppFonts.medium),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              25.hh,
              Text(
                "Enter the email associated with your account and we’ll send an email with code to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.medium,
                    fontSize: 14),
              ),
              30.hh,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              5.hh,
              Container(
                height: 50,
                child: TextField(
                  style: TextStyle(color: AppColors.playlist_btn_color),
                  obscureText: _obscureNewPassword,
                  controller: newPassController,
                  decoration: InputDecoration(
                    hintText: "Type your Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.divider_color,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              20.hh,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Confirm Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              5.hh,
              Container(
                height: 50,
                child: TextField(
                  style: TextStyle(color: AppColors.playlist_btn_color),
                  controller: confirmPassController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Type your Confirm Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.divider_color,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              30.hh,
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      GlobalVariable.navState.currentContext!,
                      AppScreen.LoginScreen,
                      (r) => false);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.Button_Yellow,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style:
                          TextStyle(fontFamily: AppFonts.medium, fontSize: 22),
                    ),
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
