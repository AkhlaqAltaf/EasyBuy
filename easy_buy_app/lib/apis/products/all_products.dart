import 'dart:convert';
import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:easy_buy_app/presentation_layer/common/flash_message/flash_message.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:http/http.dart' as http;

Future<List<Product>> getAllProducts({int? categoryID}) async {
  try {
    final response = await http.get(Uri.parse(Urls.getProductsUrl));
    if (response.statusCode < 300) {
      print(response.body);
      List<Product> products = [];
      List data = json.decode(response.body);

      data.forEach((data) {
        // Check if categoryID is provided and matches, or if categoryID is null
        if (categoryID == -1 || data['category'] == categoryID) {
          List<ProductImage> images = [];
          data['images'].forEach((image) {
            images.add(ProductImage(
                image: image['image'], is_primary: image['is_primary']));
          });

          var product = Product(images,
              id: data['id'],
              name: data['name'],
              description: data['description'],
              price: data['price'],
              stock: data['stock'],
              category_id: data['category']);
          products.add(product);
        }
      });

      return products;
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
