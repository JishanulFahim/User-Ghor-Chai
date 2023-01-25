// ignore_for_file: constant_identifier_names, unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool(THEME_STATUS) ?? false;
    return  false;
  }
}
