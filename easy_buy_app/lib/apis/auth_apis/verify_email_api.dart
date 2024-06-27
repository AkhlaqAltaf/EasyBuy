import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/auth/verify_email_model.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_screen/login_screen.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup_screen/signup_screen.dart';
import 'package:easy_buy_app/presentation_layer/common/flash_message/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> verifEmail(EmailVerification model, BuildContext context) async {
  try {
    final response =
        await http.post(Uri.parse(Urls.verifyEmailUrl), body: model.toJson());
    if (response.statusCode < 300) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
      flashMessage(context, 'success', response.body.toString());
    } else {
      flashMessage(context, 'error', response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen(),
          ));
    }
  } catch (e) {
    flashMessage(context, 'error', e.toString());

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ));
  }
}

class AppRoutes {}
