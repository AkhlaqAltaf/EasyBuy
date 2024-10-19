import 'package:easy_buy_app/presentation_layer/components/app/splash_screen/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
