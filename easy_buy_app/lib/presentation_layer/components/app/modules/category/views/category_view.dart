import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', style: context.theme.textTheme.headlineSmall),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle "View All Items"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Changed to green
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'VIEW ALL ITEMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Category',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Living Room Decor'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Living Room Decor");
                  },
                ),
                ListTile(
                  title: Text('Bedroom Essentials'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Bedroom Essentials");
                  },
                ),
                ListTile(
                  title: Text('Kitchen Accessories'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Kitchen Accessories");
                  },
                ),
                ListTile(
                  title: Text('Wall Art'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Wall Art");
                  },
                ),
                ListTile(
                  title: Text('Lighting'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Lighting");
                  },
                ),
                ListTile(
                  title: Text('Outdoor Furniture'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Outdoor Furniture");
                  },
                ),
                ListTile(
                  title: Text('Rugs & Carpets'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Rugs & Carpets");
                  },
                ),
                ListTile(
                  title: Text('Curtains & Blinds'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Curtains & Blinds");
                  },
                ),
                ListTile(
                  title: Text('Storage Solutions'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Storage Solutions");
                  },
                ),
                ListTile(
                  title: Text('Decorative Pillows'),
                  onTap: () {
                    Get.snackbar("Category", "You clicked on Decorative Pillows");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
