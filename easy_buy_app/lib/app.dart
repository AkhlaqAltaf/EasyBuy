import 'package:easy_buy_app/presentation_layer/components/app/splash_screen/bindings/splash_bindings.dart';
import 'package:easy_buy_app/presentation_layer/splash_screen/splash_screen.dart';
import 'package:easy_buy_app/presentation_layer/utils/custom_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
