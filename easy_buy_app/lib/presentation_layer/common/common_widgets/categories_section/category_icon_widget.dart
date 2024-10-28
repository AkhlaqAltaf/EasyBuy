import 'package:easy_buy_app/presentation_layer/common/common_widgets/customshapes/circular_container.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryIcon({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CirclularContainer(
          height: 50.0,
          width: 50.0,
          backgroundColor: AppConstantColors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon),
            color: AppConstantColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
