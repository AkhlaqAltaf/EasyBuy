import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
