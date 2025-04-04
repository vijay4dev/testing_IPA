import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildDropdownButton(
    String selectedItem, List<String> items, ValueChanged<String?> onChanged) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isDropdownOpen = false;

      final theme = Theme.of(context);
      final isLightTheme = theme.brightness == Brightness.light;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selectedItem == items.first
              ? (isLightTheme
                  ? AppColors.button2_color
                  : const Color.fromARGB(255, 198, 176, 7))
              : (isLightTheme
                  ? AppColors.Background_Blue
                  : AppColors.Button_Yellow),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedItem == items.first
                ? (isLightTheme
                    ? const Color(0xffAFAFAF)
                    : theme.colorScheme.onSurface.withOpacity(0.5))
                : theme.colorScheme.primary,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            icon: Icon(
              Icons.arrow_drop_down,
              color: selectedItem == items.first
                  ? (isLightTheme ? Colors.white : Colors.black)
                  : theme.colorScheme.onPrimary,
            ),
            dropdownColor: isLightTheme
                ? AppColors.Background_Blue
                : AppColors.Button_Yellow,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
            ),
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                isDropdownOpen = false;
              });
              onChanged(newValue);
            },
            onTap: () {
              setState(() {
                isDropdownOpen = true;
              });
            },
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: selectedItem == items.first
                        ? (isLightTheme ? Colors.white : Colors.black)
                        : theme.colorScheme.onPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
