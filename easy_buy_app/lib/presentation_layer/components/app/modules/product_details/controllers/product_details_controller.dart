import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  Product product = Get.arguments;

  /// when the user press on add to cart button
  onAddToCartPressed() {
    if (product.stock == 0) {
      Get.find<BaseController>().onIncreasePressed(product.id);
    }
    Get.back();
  }
}
