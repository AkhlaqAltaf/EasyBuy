import 'package:easy_buy_app/presentation_layer/client/route/route_constants.dart';
import 'package:easy_buy_app/presentation_layer/client/route/router.dart';
import 'package:easy_buy_app/presentation_layer/client/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Thanks for using our template. You are using the free version of the template.
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Template by The Flutter Way',
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: generateRoute,
      initialRoute: onbordingScreenRoute,
    );
  }
}
