import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  Product product = Get.arguments;
  var products = <Product>[].obs;
  var isLoading = true.obs; // Observable for loading state
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    if (product.stock == 0) {
      Get.find<BaseController>().onIncreasePressed(product.id);
    }
    Get.back();
  }

  // Function to fetch products from API
  void fetchProducts() async {
    print(".....................");
    isLoading.value = true; // Start loading
    try {
      final fetchedProducts = await getAllProducts(categoryID: -1);

      products.value = fetchedProducts;
    } catch (e) {
      products.value = [];
    } finally {
      isLoading.value = false; // End loading
    }
  }
}
