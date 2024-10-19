import 'package:easy_buy_app/presentation_layer/components/app/modules/auth_screens/signup_screen/controllers/signup_controller.dart';
import 'package:get/get.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
