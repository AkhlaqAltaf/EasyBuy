import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:easy_buy_app/presentation_layer/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeSearchContainer extends StatelessWidget {
  const HomeSearchContainer({
    this.icon = Iconsax.search_normal,
    required this.text,
    this.showBackground = true,
    this.showBorder = true,
    super.key,
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = AppDeviceUtils.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: AppDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? AppConstantColors.dark
                  : AppConstantColors.light
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: showBorder ? Border.all(color: AppConstantColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppConstantColors.darkGrey),
            Text(text, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
