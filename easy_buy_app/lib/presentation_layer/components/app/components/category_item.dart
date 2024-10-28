import 'package:easy_buy_app/data_layer/product/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/models/category_model.dart';
import '../routes/app_pages.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.PRODUCTS),
        child: Column(
          children: [
            CircleAvatar(
              radius: 37.r,
              backgroundColor: theme.cardColor,
              child: Image.network(category.image),
            ).animate().fade(duration: 200.ms),
            10.verticalSpace,
            Text(category.name, style: theme.textTheme.headlineSmall)
                .animate()
                .fade()
                .slideY(
                  duration: 200.ms,
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
