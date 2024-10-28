import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/auth/verify_email_model.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_screen/login_screen.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup_screen/signup_screen.dart';
import 'package:easy_buy_app/presentation_layer/common/flash_message/flash_message.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> verifEmail(EmailVerification model, BuildContext context) async {
  try {
    final response =
        await http.post(Uri.parse(Urls.verifyEmailUrl), body: model.toJson());
    if (response.statusCode < 300) {
      Get.offNamed(Routes.LOGIN);

      flashMessage(context, 'success', response.body.toString());
    } else {
      flashMessage(context, 'error', response.body);
      Get.offNamed(Routes.SIGNUP);
    }
  } catch (e) {
    flashMessage(context, 'error', e.toString());
    Get.offNamed(Routes.SIGNUP);
  }
}

class AppRoutes {}
