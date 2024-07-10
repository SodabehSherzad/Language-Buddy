import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../methods/shared_preferences.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  // Add other dark mode theme properties here
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  // Add other light mode theme properties here
);

class ThemeNotifier with ChangeNotifier {
  ThemeNotifier() {
    _loadThemePreference();
  }

  bool get isDarkModeEnabled => SharedPreferencesManager.getIsDarkModeEnabled();

  ThemeData get currentTheme {
    return isDarkModeEnabled ? darkTheme : lightTheme;
  }

  void _loadThemePreference() async {
    await SharedPreferencesManager.init();
    notifyListeners();
  }

  void toggleTheme() async {
    final isDarkModeEnabled = !this.isDarkModeEnabled; // Toggle the dark mode
    SharedPreferencesManager.setIsDarkModeEnabled(isDarkModeEnabled);
    notifyListeners();
  }
}
