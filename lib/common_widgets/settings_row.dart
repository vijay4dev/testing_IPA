import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final String? subtitle;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool isDisabled;

  const SettingsItem({
    Key? key,
    this.icon,
    this.imagePath,
    required this.title,
    this.subtitle,
    this.iconColor = AppColors.txtcolor,
    this.onTap,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon,
                  color: isDisabled
                      ? Colors.grey
                      : isDisabled
                          ? Colors.white
                          : Theme.of(context).brightness == Brightness.light
                              ? AppColors.playlist_btn_color
                              : AppColors.divider_color,
                  size: 35),
            if (imagePath != null)
              Image.asset(imagePath!,
                  color: isDisabled
                      ? Theme.of(context).brightness == Brightness.light
                          ? AppColors.playlist_btn_color
                          : AppColors.divider_color
                      : Theme.of(context).brightness == Brightness.light
                          ? AppColors.playlist_btn_color
                          : AppColors.divider_color,
                  height: 35),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppFonts.medium,
                    fontSize: 16,
                    color: isDisabled
                        ? Theme.of(context).brightness == Brightness.light
                            ? AppColors.playlist_btn_color
                            : AppColors.divider_color
                        : Theme.of(context)
                            .colorScheme
                            .onBackground, // Adaptive text color
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7), // Subtle text contrast
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
