import 'package:easy_buy_app/presentation_layer/common/common_widgets/appbar/appbar.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/productCart/cart_counter.dart';

import 'package:flutter/material.dart';
class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good Day For Shopping',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  ),
          Text('Hi',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  ),
        ],
      ),
      actions: [
        CartCounterIcon(
          onPressed: (){}, 
         
        ),
      ],
    );
  }
}

