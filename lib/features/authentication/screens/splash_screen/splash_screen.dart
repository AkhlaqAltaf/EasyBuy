import 'dart:async';

import 'package:easy_buy_ar/features/authentication/screens/login_Screen/login.dart';
import 'package:easy_buy_ar/utils/theme.dart';
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
     Timer( const Duration(seconds: 2), () {
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
            Container( 
              child: const Text("Easy Buy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0), 
               child: AppTheme.getSpinKit(context), 
            ),
          ],
        ),
      ),
    );
  }
}