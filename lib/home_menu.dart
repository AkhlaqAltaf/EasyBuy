import 'package:easy_buy_ar/features/shop/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value=index,
          destinations: [
            
           const NavigationDestination(icon: Icon(CupertinoIcons.home), label: 'home'),
            const NavigationDestination(icon: Icon(CupertinoIcons.cart), label: 'home'),
             const NavigationDestination(icon: Icon(CupertinoIcons.shopping_cart), label: 'home'),
              const NavigationDestination(icon: Icon(CupertinoIcons.person), label: 'home'),
              
          ],
        
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex=0.obs;
  final screens = [
    const HomeScreen(),
     Container(color: Colors.blue),
      Container(color: Colors.pink),
       Container(color: Colors.purple),
  ];
}