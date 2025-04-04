import 'package:butterflix/forget_password/new_password.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgetPassCodeScreen extends StatefulWidget {
  const ForgetPassCodeScreen({super.key});

  @override
  State<ForgetPassCodeScreen> createState() => _ForgetPassCodeScreenState();
}

class _ForgetPassCodeScreenState extends State<ForgetPassCodeScreen> {
  TextEditingController emailController = TextEditingController();
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
        _startCountdown();
      }
    });
  }

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
                "Enter the verification code sent to the email ID you provided.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.medium,
                    fontSize: 14),
              ),
              40.hh,
              Text("Verification code",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.semibold)),
              25.hh,
              OtpTextField(
                numberOfFields: 4,
                textStyle: TextStyle(
                    fontFamily: AppFonts.semibold,
                    fontSize: 18,
                    color: AppColors.playlist_btn_color),
                fillColor: Colors.white,
                fieldWidth: 50,
                filled: true,
                showFieldAsBox: true,
                borderWidth: 2.0,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {},
              ),
              30.hh,
              RichText(
                text: TextSpan(
                  text: "Resend in 00:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: AppFonts.medium,
                  ),
                  children: [
                    TextSpan(
                      text: " ${_secondsRemaining.toString().padLeft(2, '0')}",
                      style: TextStyle(
                        color: AppColors.Button_Yellow,
                        fontSize: 18,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ],
                ),
              ),
              30.hh,
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewPasswordScreen()));
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
