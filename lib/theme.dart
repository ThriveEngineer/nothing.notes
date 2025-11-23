import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightMode = ThemeData(
  fontFamily: "Nothing",
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: "Nothing",
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(25, 25, 25, 25),
    primary: const Color.fromARGB(255, 77, 77, 77),
    secondary: const Color.fromARGB(255, 30, 30, 30),
    tertiary: const Color.fromARGB(255, 47, 47, 47),
    inversePrimary: Colors.grey.shade300,
  )
);

class ThemeProvider extends ChangeNotifier {

  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final preferences = await SharedPreferences.getInstance();
    String theme = this.isDarkMode ? "dark" : "light";
    await preferences.setString("theme", theme);
  }

  Future<void> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    String? theme = preferences.getString("theme");
    if (theme == null) {
      theme = "dark";
      await preferences.setString("theme", "dark");
    }

    if (theme == "dark") {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }

    saveTheme();
  }
}