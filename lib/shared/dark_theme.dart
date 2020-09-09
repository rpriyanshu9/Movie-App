import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier{
  static bool isDark=true;
  ThemeMode myCurrentTheme(){
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    isDark=!isDark;
    notifyListeners();
  }

}