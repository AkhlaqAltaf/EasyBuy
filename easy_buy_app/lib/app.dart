import 'package:easy_buy_app/utils/utils/custom_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/splash_screen/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GetMaterialApp(
      // initialBinding: SplashScreenBinding(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
