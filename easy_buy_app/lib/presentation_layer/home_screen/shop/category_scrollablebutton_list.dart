import 'package:easy_buy_app/presentation_layer/common/common_widgets/categories_section/category_text_button_widget.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<String> categories = [
    'All',
    'Lamp',
    'Vase',
    'Chair',
    'table',
    'Clock',
    'plant',
    'pictures',
    'curtains'
  ];

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CategoryButton(
              label: category,
              isSelected: category == selectedCategory,
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
