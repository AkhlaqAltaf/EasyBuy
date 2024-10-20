import 'dart:async';
import 'package:easy_buy_app/apis/urls/urls.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/bottomnav.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/helper_functions/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/app/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUser() {
    Future.delayed(const Duration(seconds: 4), () async {
      Get.offNamed(Routes.BASE);
      String? token = await getToken();
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
            Image(image: AssetImage(ImagesStrings.splashlogo)),
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
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              TextField(
                controller: url,
                decoration: InputDecoration(
                    labelText: 'ipv4 Address', hintText: "192.168.1.1"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  String ipv4 = url.text;
                  Urls.serverUrl = 'http://${ipv4}:8000';

                  Navigator.of(context).pop();
                  checkUser();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating product: $e')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
