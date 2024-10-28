import 'package:easy_buy_app/presentation_layer/common/common_widgets/categories_section/category_icon_widget.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories
          .map((category) =>
              CategoryIcon(name: category['name'], icon: category['icon']))
          .toList(),
    );
  }
}
