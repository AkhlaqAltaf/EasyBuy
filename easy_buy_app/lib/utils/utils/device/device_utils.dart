import 'package:flutter/material.dart';

class AppDeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
