import 'package:easy_buy_app/presentation_layer/common/common_widgets/appbar/home_appbar_Widget.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/custom_search-bar/search_container.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/text_widgets/section_heading.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.4,
      child: Column(
        children: [
          CustomHomeAppBar(),
          SizedBox(height: AppSizes.spaceBtwItems + 5.0),
          HomeSearchContainer(text: 'Search'),
          SizedBox(height: AppSizes.spaceBtwItems + 5.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: HeaderSectionHeadings(
              title: 'Special Offers',
              showActionButton: true,
            ),
          ),
        ],
      ),
    );
  }
}
