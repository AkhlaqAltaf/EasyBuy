import 'dart:convert';

import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:easy_buy_app/presentation_layer/common/flash_message/flash_message.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> signInUser(Auth model, BuildContext context) async {
  try {
    final response =
        await http.post(Uri.parse(Urls.signinUserUrl), body: model.toJson());

    if (response.statusCode < 300) {
      var decodedResponse = await jsonDecode(response.body);
      String token = decodedResponse['key'];
      String email = decodedResponse['email'];
      String username = email.split('@')[0];
      await storeToken(username);

      Get.offNamed(Routes.BASE);
    } else {
      flashMessage(context, 'error', response.body.toString());
    }
  } catch (e) {
    flashMessage(context, 'error', e.toString());
  }
}
