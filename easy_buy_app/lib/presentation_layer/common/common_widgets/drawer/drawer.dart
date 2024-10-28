import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_screen/login_screen.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Drawer drawer(BuildContext context, {bool isLogin = false}) {
  print("IS LOGIN $isLogin");
  void checkUser() async {
    String? token = await getToken();
    if (token != null) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  checkUser();
  return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Expanded(
            child: DrawerHeader(
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 0, 0, 0),
                  ),
              child: Image(
                image: AssetImage('assets/logo/logo.png'),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home, size: 24),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.offNamed(Routes.HOME);
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.list,
                    size: 24,
                  ),
                  title: const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.offNamed(Routes.PRODUCTS);
                  },
                ),
                isLogin
                    ? ListTile(
                        leading: const RotationTransition(
                          turns: AlwaysStoppedAnimation(180 / 360),
                          child: Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                  'Would you like to logout?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Logout'),
                                    onPressed: () {
                                      Get.offNamed(Routes.LOGIN);
                                      clearData();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : ListTile(
                        leading: const Icon(
                          Icons.login,
                          size: 24,
                        ),
                        title: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                      ),
              ],
            ),
          )
        ],
      ));
}
