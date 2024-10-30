import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/apis/products/categories.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:easy_buy_app/data_layer/product/category.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/product_categories.dart';
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
  var categories = <Category>[].obs;
  var isLoadingCategories = true.obs;
  var isLoadingProducts = true.obs; // New loading state for products
  var username = "".obs;
  var filteredProducts = <Category>[].obs; // Filtered product list

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for home screen cards
  var cards = [Constants.card1_, Constants.card2_, Constants.card3_];

  // for app theme

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
    fetchUserName();
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

  fetchUserName() async {
    username.value = (await getToken())!;
  }

  void fetchCategories() async {
    isLoadingCategories.value = true;
    try {
      final fetchedCategories = await getCategories();
      categories.value = fetchedCategories;
      filteredProducts.assignAll(categories);
    } catch (e) {
      print("Error fetching categories: $e");
      categories.value = [];
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void fetchProducts() async {
    isLoadingProducts.value = true; // Start loading
    try {
      final fetchedProducts = await getAllProducts();
      products.value = fetchedProducts;
    } catch (e) {
      Get.snackbar("error", "Error fetching products");
      print("Error fetching products: $e");
      products.value = [];
    } finally {
      isLoadingProducts.value = false; // End loading
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(categories); // Show all if query is empty
    } else {
      filteredProducts.assignAll(categories.where((category) =>
          category.name.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
