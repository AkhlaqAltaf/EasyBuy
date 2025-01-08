import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../app/routes/app_pages.dart';
import '../../common/flash_message/flash_message.dart';

Future<void> registerUser(Auth model, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(Urls.registerUserUrl),
      body: model.toJson(),
    );

    if (response.statusCode < 300) {
      await storeUserEmail(model.email!);
      flashMessage(context, 'success', response.body.toString());
      Get.offNamed(Routes.LOGIN);
    } else {
      flashMessage(context, 'error', response.body.toString());
    }
  } catch (e) {
    flashMessage(context, 'error', e.toString());
  }
}
