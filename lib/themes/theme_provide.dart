import 'package:flutter/material.dart';

import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightMode;

  ThemeData get theme => _theme;

  bool get isDarkMode => _theme == darkMode;

  void toggleTheme() {
    _theme = _theme == darkMode ? lightMode : darkMode;
    notifyListeners();
  }

  void setTheme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
}
