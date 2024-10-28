import 'package:easy_buy_app/presentation_layer/common/common_widgets/customshapes/circular_container.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icon,
    this.onPressed,
  });
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted padding
      child: Column(
        children: [
          CirclularContainer(
            height: 60.0,
            width: 60.0,
            backgroundColor: AppConstantColors.black,
            child: IconButton(onPressed: onPressed, icon: icon),
          ),
          const SizedBox(height: 8.0), // Adjusted spacing
          const Text('Chair'),
        ],
      ),
    );
  }
}
