import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  var products = <Product>[].obs;

  @override
  void onInit() {
    getCartProducts();
    super.onInit();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() {
    clearCart();
    Get.back();
    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  /// get the cart products from the product list
  void getCartProducts() async {
    final fetchedProducts = await getAllProducts();
    products.value = fetchedProducts; // Update the observable list
    update();
  }

  /// clear products in cart and reset cart items count
  clearCart() {
    DummyHelper.products.map((p) => p.quantity = 0).toList();
    Get.find<BaseController>().getCartItemsCount();
  }
}
