import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system); // Start with system theme

  /// Toggle between light and dark mode
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  /// Set theme to system default
  void setSystemTheme() {
    state = ThemeMode.system;
  }

  /// Set theme to light mode
  void setLightTheme() {
    state = ThemeMode.light;
  }

  /// Set theme to dark mode
  void setDarkTheme() {
    state = ThemeMode.dark;
  }
}

/// Riverpod provider for theme management
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
