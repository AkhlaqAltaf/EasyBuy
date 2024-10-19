import 'package:easy_buy_app/presentation_layer/components/app/modules/auth_screens/login_screen/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
