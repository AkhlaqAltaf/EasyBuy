import 'dart:async';
import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils/constant/image_strings.dart';
import '../../../utils/utils/helper_functions/helper_function.dart';
import '../../routes/app_pages.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUser() {
    Future.delayed(const Duration(seconds: 4), () async {
      String? token = await getToken();
      if (token != null) {
        Get.offNamed(Routes.BASE);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showEditDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(image: AssetImage(ImagesStrings.splashlogo)),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: HelperFunctions.getSpinKit(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog() {
    final TextEditingController url = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Put IP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: url,
                decoration: const InputDecoration(
                    labelText: 'ipv4 Address', hintText: "192.168.1.1"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  String ipv4 = url.text;
                  Urls.serverUrl = 'http://$ipv4:8000';

                  Navigator.of(context).pop();
                  checkUser();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating product: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
