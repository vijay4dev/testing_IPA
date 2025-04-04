import 'package:butterflix/forget_password/forget_pass_code.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';

class ForgetPassMailScreen extends StatefulWidget {
  const ForgetPassMailScreen({super.key});

  @override
  State<ForgetPassMailScreen> createState() => _ForgetPassMailScreenState();
}

class _ForgetPassMailScreenState extends State<ForgetPassMailScreen> {
  TextEditingController emailController = TextEditingController();

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
        // foregroundColor: AppColors.Background_Blue,

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
              50.hh,
              Text(
                "Enter the email associated with your account and we’ll send an email with code to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.medium,
                    fontSize: 14),
              ),
              50.hh,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Email",
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
              30.hh,
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassCodeScreen()));
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
