import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color; // Button color
  final Color txtcolor;
  final String text; // Button text
  final VoidCallback onTap;
  final double fontsize;
  final bool fullWidth;
  const CustomButton({
    super.key,
    required this.color,
    required this.txtcolor,
    required this.text,
    required this.onTap,
    this.fullWidth = false,
    this.fontsize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .4,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: txtcolor,
                fontFamily: AppFonts.semibold,
                fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}
