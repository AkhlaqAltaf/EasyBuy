import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';

class SplashController extends GetxController {
  final TextEditingController urlController = TextEditingController();

  @override
  void onInit() {
    print("......................................................");
    super.onInit();
    Get.offNamed(Routes.BASE); // Navigate to Bottom Navigation

    Future.delayed(Duration.zero, checkUser);
  }

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 4));
    String? token = await getToken();
    Get.offNamed(Routes.BASE); // Navigate to Bottom Navigation
  }

  void _showEditDialog() {
    Get.defaultDialog(
      title: 'Edit Product',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: urlController,
            decoration: const InputDecoration(
              labelText: 'ipv4 Address',
              hintText: "192.168.1.1",
            ),
          ),
        ],
      ),
      textConfirm: 'Save',
      onConfirm: () {
        try {
          String ipv4 = urlController.text;
          Urls.serverUrl = 'http://$ipv4:8000';
          Get.back(); // Close dialog
          checkUser(); // Start user checking after saving URL
        } catch (e) {
          Get.snackbar('Error', 'Error updating product: $e');
        }
      },
    );
  }
}
