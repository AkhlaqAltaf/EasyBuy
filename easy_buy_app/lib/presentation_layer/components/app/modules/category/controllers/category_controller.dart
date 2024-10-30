import 'package:get/get.dart';
import 'package:easy_buy_app/apis/products/categories.dart';
import 'package:easy_buy_app/data_layer/product/category.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      final fetchedCategories = await getCategories();
      categories.value = fetchedCategories;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
