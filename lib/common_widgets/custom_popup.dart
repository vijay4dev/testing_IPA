import 'package:butterflix/utils/app_colors.dart';
import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? dilog_icon;
  final String? title;
  final String message;
  final String buttonText1;
  final Color buttonColor1;
  final VoidCallback onPressed1;
  final String? buttonText2; // Optional second button text
  final Color? buttonColor2; // Optional second button color
  final VoidCallback? onPressed2; // Optional second button callback

  const CustomDialog({
    Key? key,
    required this.message,
    required this.buttonText1,
    required this.buttonColor1,
    required this.onPressed1,
    this.dilog_icon,
    this.title,
    this.buttonText2,
    this.buttonColor2,
    this.onPressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.Background_Blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dilog_icon != null ? Image.asset(dilog_icon!) : Container(),
            // const SizedBox(height: 20),
            title != null
                ? Column(
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      20.hh,
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : 20.hh,
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            25.hh,
            // If second button provided, display them in a vertical stack.
            buttonText2 != null && onPressed2 != null
                ? Column(
                    children: [
                      IntrinsicWidth(
                        child: InkWell(
                          onTap: onPressed1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonColor1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15),
                                child: Text(
                                  buttonText1,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      IntrinsicWidth(
                        child: InkWell(
                          onTap: onPressed2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonColor2,
                              border: Border.all(
                                  width: 1, color: AppColors.Button_Yellow),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15),
                                child: Text(
                                  buttonText2!,
                                  style: const TextStyle(
                                      color: AppColors.Button_Yellow,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : IntrinsicWidth(
                    child: InkWell(
                      onTap: onPressed1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            child: Text(
                              buttonText1,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
