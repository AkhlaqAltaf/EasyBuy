import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:easy_buy_app/apis/auth_apis/signin_api.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';

class LoginController extends GetxController {
  // Controllers for form fields
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  // Observables for state management
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Sign In method
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      print("LOGIN HIT..");
      isLoading(true);

      try {

        Auth model = Auth(
          email: emailController.value.text,
          password: passwordController.value.text,
        );
        print("PASS REQUEST.");
        await signInUser(model, Get.context!);
      } catch (e) {
        // Handle error here
      } finally {
        isLoading(false);
      }
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
