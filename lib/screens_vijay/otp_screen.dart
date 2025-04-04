import 'dart:async';
import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _secondsRemaining = 57;
  late String _otp;
  Timer? _timer; // Store the timer instance

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        if (mounted) { // ✅ Check if widget is still in the tree
          setState(() {
            _secondsRemaining--;
          });
        }
      } else {
        timer.cancel(); // Stop the timer when countdown ends
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Cancel the timer to prevent setState after dispose
    super.dispose();
  }

  void _verifyOtp() {
    Navigator.pushNamedAndRemoveUntil(
      GlobalVariable.navState.currentContext!,
      AppScreen.GenreScreen,
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Verify OTP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: AppColors.Background_Blue,
        elevation: 0,
      ),
      backgroundColor: AppColors.Background_Blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            50.hh,
            Text(
              "Enter your OTP which has been sent to your email and completely verify your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            50.hh,
            OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.yellow,
              cursorColor: Colors.white,
              showFieldAsBox: false,
              borderWidth: 1.0,
              fieldWidth: 40,
              focusedBorderColor: Colors.yellow,
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
              onSubmit: (code) {
                setState(() {
                  _otp = code;
                });
              },
            ),
            50.hh,
            Text(
              "A code has been sent to your phone",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              "Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            40.hh,
            ElevatedButton(
              onPressed: _verifyOtp,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.Button_Yellow,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Confirm",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
