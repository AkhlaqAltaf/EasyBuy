import 'package:easy_buy_app/presentation_layer/home_screen/product_categories.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<Icon> icons;
  final List<String> texts;

  const CategoriesList({
    super.key,
    required this.icons,
    required this.texts,
  }) : assert(icons.length == texts.length);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
      child: SizedBox(
        height: 120, // Adjusted height for better layout
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: icons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Categories(
                  icon: icons[index], // Use icon from the list
                ),
                Text(
                  texts[index], // Use text from the list
                  style: TextStyle(color: Colors.black),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
