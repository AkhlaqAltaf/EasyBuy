import 'package:easy_buy_app/apis/products/all_products.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs; // Observable for loading state
  int categoryID = Get.arguments;
  var filteredProducts = <Product>[].obs; // Filtered product list
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Function to fetch products from API
  void fetchProducts() async {
    print(".....................");
    isLoading.value = true; // Start loading
    try {
      final fetchedProducts;
      if (categoryID != Null) {
        print("IN TO THE NOT -NULL");

        fetchedProducts = await getAllProducts(categoryID: categoryID);
        products.value = fetchedProducts;
        filteredProducts.assignAll(products); // Initially, display all products
      } else {
        print("IN TO THE NULL");
        fetchedProducts = await getAllProducts();
        products.value = fetchedProducts;

        filteredProducts.assignAll(products); // Initially, display all products
      }
      products.value = fetchedProducts;
    } catch (e) {
      products.value = [];
    } finally {
      isLoading.value = false; // End loading
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products); // Show all if query is empty
    } else {
      filteredProducts.assignAll(products.where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
