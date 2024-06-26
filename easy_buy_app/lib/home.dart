import 'package:easy_buy_app/presentation_layer/common/common_widgets/categories_section/category_row_widgets.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/header_section_container.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/promo_slider.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Lamp', 'icon': Icons.lightbulb},
      {'name': 'Vase', 'icon': Icons.tab},
      {'name': 'Chair', 'icon': Icons.chair},
      {'name': 'Table', 'icon': Icons.table_chart},
      {'name': 'Clock', 'icon': Icons.access_time},
      {'name': 'Plant', 'icon': Icons.grass},
      {'name': 'Picture', 'icon': Icons.image},
      {'name': 'Curtains', 'icon': Icons.blinds},
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(),
            SizedBox(height: AppSizes.spaceBtwItems - 15.0),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: HomePromoSlider(
                banners: [
                  ImagesStrings.sliderbanner1,
                  ImagesStrings.sliderbanner2,
                  ImagesStrings.sliderbanner3,
                  ImagesStrings.sliderbanner4,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CategoryRow(categories: categories.sublist(0, 4)),
                  SizedBox(height: 16),
                  CategoryRow(categories: categories.sublist(4, 8)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("rrr"),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: AppConstantColors.black, width: 2),
                      borderRadius: BorderRadius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }
}
