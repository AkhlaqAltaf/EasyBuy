import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  // to hold categories & products
  var products = <Product>[].obs;

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for home screen cards
  var cards = [Constants.card1_, Constants.card2_, Constants.card3_];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// get products from dummy helper
  void fetchProducts() async {
    final fetchedProducts = await getAllProducts();
    products.value = fetchedProducts; // Update the observable list
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}
