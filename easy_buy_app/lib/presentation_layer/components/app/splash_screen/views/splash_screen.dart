import 'package:easy_buy_app/presentation_layer/components/app/splash_screen/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/helper_functions/helper_function.dart';

class SplashScreenView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    print("BUILD..............................");
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
}
