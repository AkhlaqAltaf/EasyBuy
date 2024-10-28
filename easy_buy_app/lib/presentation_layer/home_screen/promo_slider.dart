import 'package:easy_buy_app/presentation_layer/common/common_widgets/customshapes/circular_container.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/home_carousel/carosule_images.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/shop/controller/home_controller.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePromoSlider extends StatelessWidget {
  const HomePromoSlider({
    super.key,
    required this.banners,
  });
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        SizedBox(
          height: 200, // Adjust the height of the carousel
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) => controller.updatePageIndicator(index),
            itemBuilder: (context, index) {
              final url = banners[index];
              return HomeCarosuleImages(imageUrl: url);
            },
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                CirclularContainer(
                  width: 20,
                  height: 4,
                  backgroundColor: controller.carousalCurrentIndex.value == i
                      ? AppConstantColors.primaryColor
                      : AppConstantColors.grey,
                  margin: const EdgeInsets.only(right: 10),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
