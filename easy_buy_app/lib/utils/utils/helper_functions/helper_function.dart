import 'package:flutter/material.dart';

import '../custom_theme/spinkit_theme.dart';
 class HelperFunctions{
  static  getSpinKit(BuildContext buildContext) {
    final isDarkTheme = Theme.of(buildContext).brightness == Brightness.dark;
    return isDarkTheme ? AppSpinKitTheme.darkSpinKit : AppSpinKitTheme.lightSpinKit;
  }

  static bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

 }