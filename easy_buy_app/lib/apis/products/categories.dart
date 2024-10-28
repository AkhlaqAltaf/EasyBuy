import 'dart:convert';

import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/product/category.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_screen/login_screen.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup_screen/signup_screen.dart';
import 'package:easy_buy_app/presentation_layer/common/flash_message/flash_message.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/category_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Category>> getCategories(BuildContext context) async {
  try {
    final response = await http.get(Uri.parse(Urls.getCategoriesUrl));
    if (response.statusCode < 300) {
      print(response.body);
      List<Category> categories = [];
      List data = json.decode(response.body);
      data.forEach((data) {
        print(data);
        var category = Category(
            id: data['id'],
            image: data['image'],
            name: data['name'],
            description: data['description']);
        categories.add(category);
      });

      // flashMessage(context, 'success', categories.toString());
      return categories;
    } else {
      print("ERROR");
      flashMessage(context, 'error', response.body);
      return [];
    }
  } catch (e) {
    print("error : ");
    flashMessage(context, 'error', e.toString());
    return [];
  }
}
