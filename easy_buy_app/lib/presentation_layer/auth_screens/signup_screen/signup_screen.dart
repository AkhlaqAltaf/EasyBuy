import 'package:easy_buy_app/apis/auth_apis/signup_api.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_screen/login_screen.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool isVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController!.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: _emailValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              obscureText: !isVisible,
                              validator: _passwordValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              decoration: const InputDecoration(
                                label: Text("Confirm Password"),
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: !isVisible,
                              validator: _confirmPasswordValidator,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Auth auth = Auth(
                              email: emailController!.text,
                              password: passwordController!.text,
                            );
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await registerUser(auth, context);
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.app_registration,
                                    size: 25,
                                  ),
                                  Text(
                                    'Register',
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.LOGIN);
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: "If You have An Account",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
