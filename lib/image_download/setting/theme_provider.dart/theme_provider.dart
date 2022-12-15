import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  changeToLight() {
    themeMode = ThemeMode.light;
    notifyListeners();
  }

  changeToDark() {
    themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
