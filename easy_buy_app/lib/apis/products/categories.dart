import 'dart:convert';

import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/product/category.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../common/flash_message/flash_message.dart';

Future<List<Category>> getCategories() async {
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
            // description: data['description']
        );
        categories.add(category);
      });

      // flashMessage(context, 'success', categories.toString());
      return categories;
    } else {
      print("ERROR");
      flashMessage(Get.context!, 'error', response.body);
      return [];
    }
  } catch (e) {
    print("error : ");
    flashMessage(Get.context!, 'error', e.toString());
    return [];
  }
}
