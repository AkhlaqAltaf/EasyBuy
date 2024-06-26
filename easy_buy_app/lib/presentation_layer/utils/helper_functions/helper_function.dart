 import 'package:easy_buy_app/presentation_layer/utils/custom_theme/spinkit_theme.dart';
import 'package:flutter/material.dart';
 class HelperFunctions{
  static  getSpinKit(BuildContext buildContext) {
    final isDarkTheme = Theme.of(buildContext).brightness == Brightness.dark;
    return isDarkTheme ? AppSpinKitTheme.darkSpinKit : AppSpinKitTheme.lightSpinKit;
  }

  static bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

 }