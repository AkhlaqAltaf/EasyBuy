import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../utils/utils/constant/image_strings.dart';
import '../../../utils/utils/helper_functions/helper_function.dart';
import '../../modules/splash/controllers/splash_controller.dart';

class SplashScreenView extends GetView<SplashController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    print("BUILD..............................");
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
}
