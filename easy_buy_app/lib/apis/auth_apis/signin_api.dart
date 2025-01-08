import 'dart:convert';

import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app/routes/app_pages.dart';
import '../../common/flash_message/flash_message.dart';

Future<void> signInUser(Auth model, BuildContext context) async {
  print("REACHED");
  try {
    final response =
        await http.post(Uri.parse(Urls.signinUserUrl), body: model.toJson());
    print("RESPONSE"+response.body);

    if (response.statusCode < 300) {
      var decodedResponse = await jsonDecode(response.body);
      print(decodedResponse);
      String token = decodedResponse['token'];
      print("TOKEN");
      String? name = decodedResponse['user']['name'];
      print("TOKEN : ," );

      await storeToken(token);

      Get.offNamed(Routes.BASE);
    } else {
      flashMessage(context, 'error', response.body.toString());
    }
  } catch (e) {
    print("ERROR"+e.toString());
    flashMessage(context, 'error', e.toString());
  }
}
