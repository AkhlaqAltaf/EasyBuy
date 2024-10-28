import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  // To hold the products
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Call fetchProducts here
  }

  // Function to fetch products from API
  void fetchProducts() async {
    try {
      final fetchedProducts = await getAllProducts();
      if (fetchedProducts.isNotEmpty) {
        products.value = fetchedProducts; // Update the observable list
      } else {
        // Optionally handle the empty state
        products.value = [];
      }
    } catch (e) {
      print("Error fetching products: $e");
      // Optionally set an empty list or handle the error state
      products.value = [];
    }
  }
}
