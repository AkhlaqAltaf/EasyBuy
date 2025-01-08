import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../data/models/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import 'custom_icon_button.dart';

class ProductCountItem extends GetView<BaseController> {
  final Product product;
  const ProductCountItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        CustomIconButton(
          width: 36.w,
          height: 36.h,
          // controller.onDecreasePressed(product.id, context)
          onPressed: () => (),
          icon: SvgPicture.asset(
            Constants.removeIcon,
            fit: BoxFit.none,
          ),
          backgroundColor: theme.cardColor,
        ),
        16.horizontalSpace,
        GetBuilder<BaseController>(
          id: 'ProductQuantity',
          builder: (_) => Text(
            product.stock.toString(),
            style: theme.textTheme.headlineLarge,
          ),
        ),
        16.horizontalSpace,
        CustomIconButton(
          width: 36.w,
          height: 36.h,
// controller.onIncreasePressed(product.id)
          onPressed: () => (),
          icon: SvgPicture.asset(
            Constants.addIcon,
            fit: BoxFit.none,
          ),
          backgroundColor: theme.primaryColor,
        ),
      ],
    );
  }
}
