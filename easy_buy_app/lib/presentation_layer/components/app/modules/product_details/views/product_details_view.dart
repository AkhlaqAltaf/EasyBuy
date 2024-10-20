import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_card.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/product_count_item.dart';
import '../controllers/decor_details_controller.dart';  // Update to reflect a decor controller

class DecorDetailsView extends GetView<DecorDetailsController> {  // Renamed to DecorDetailsView
  const DecorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 330.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(
                      Constants.container,
                      fit: BoxFit.fill,
                      color: theme.cardColor,
                    ),
                  ),
                  Positioned(
                    top: 24.h,
                    left: 24.w,
                    right: 24.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          onPressed: () => Get.back(),
                          icon: SvgPicture.asset(
                            Constants.backArrowIcon,
                            fit: BoxFit.none,
                            color: theme.appBarTheme.iconTheme?.color,
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            Constants.searchIcon,
                            fit: BoxFit.none,
                            color: theme.appBarTheme.iconTheme?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      controller.decor.image,  // Changed from product to decor
                      width: 250.w,
                      height: 225.h,
                    ).animate().fade().scale(
                      duration: 800.ms,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    controller.decor.name,  // Changed from product to decor
                    style: theme.textTheme.displayMedium,
                  ).animate().fade().slideX(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                  const Spacer(),
                  ProductCountItem(product: controller.decor)  // Adjust based on decor
                      .animate()
                      .fade(duration: 200.ms),
                ],
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Dimensions: ${controller.decor.dimensions}, Price: ${controller.decor.price}\$',  // Changed for decor
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                controller.decor.description,  // Changed to decor description
                style: theme.textTheme.bodyLarge,
              ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GridView(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 80.h,
                ),
                children: DummyHelper.cards
                    .map((card) => CustomCard(
                  title: card['title']!,  // Change card info to match decor (e.g. 'Material', 'Style')
                  subtitle: card['subtitle']!,
                  icon: card['icon']!,
                ))
                    .toList()
                    .animate()
                    .fade()
                    .slideY(
                  duration: 300.ms,
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                text: 'Add to Room',  // Changed action button text
                onPressed: () => controller.onAddToRoomPressed(),  // Function to handle adding decor to AR room or cart
                fontSize: 16.sp,
                radius: 50.r,
                verticalPadding: 16.h,
                hasShadow: false,
              ).animate().fade().slideY(
                duration: 300.ms,
                begin: 1,
                curve: Curves.easeInSine,
              ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
