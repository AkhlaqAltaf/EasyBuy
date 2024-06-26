import 'dart:async';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_Screen/login.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/helper_functions/helper_function.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image(image: AssetImage(ImagesStrings.splashlogo)),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: HelperFunctions.getSpinKit(context),
            ),
          ],
        ),
      ),
    );
  }
}
