import 'package:easy_buy_app/apis/auth_apis/verify_email_api.dart';
import 'package:easy_buy_app/data_layer/auth/verify_email_model.dart';
import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController? emailController;
  List<TextEditingController> codeControllers =
      List.generate(4, (index) => TextEditingController());

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    userEmail();
  }

  void userEmail() async {
    emailController!.text = (await getUserEmail())!;
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    for (var controller in codeControllers) {
      controller.dispose();
    }
  }

  Future<void> verifyCode() async {
    String code = codeControllers.map((controller) => controller.text).join();
    EmailVerification verificationModel =
        EmailVerification(email: emailController!.text, code: code);
    await verifEmail(verificationModel, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(height: 80),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: codeControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 3) {
                                  FocusScope.of(context).nextFocus();
                                }

                                if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await verifyCode();
                          } catch (e) {
                          } finally {
                            _isLoading = false;
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login, size: 25),
                                  Text(
                                    'Verify',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(height: 20),
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
