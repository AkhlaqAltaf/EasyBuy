import 'package:easy_buy_app/ar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../components/product_item.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    // Carousel for product images
                    SizedBox(
                      height: 300.h,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CarouselSlider.builder(
                              itemCount: controller.product.images.length,
                              itemBuilder: (context, index, _) {
                                return Image.network(
                                  controller.product.images[index].image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                              options: CarouselOptions(
                                height: 300.h,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.h,
                            left: 0,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: theme.iconTheme.color),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Product name
                    Text(
                      controller.product.name,
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ).animate().fade().scale(),
                    SizedBox(height: 8.h),

                    // Product price
                    Text(
                      '\$${controller.product.price}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fade().scale(),
                    SizedBox(height: 8.h),

                    // Product description
                    Text(
                      controller.product.description,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ).animate().fade(),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArView(),
                          ),
                        );
                      },
                      child: Text("View in AR",
                          style: theme.textTheme.labelLarge
                              ?.copyWith(color: theme.primaryColor)),
                    ),
                    SizedBox(height: 20.h),

                    // Add to Cart Button
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: 'Add to Cart',
                        onPressed: controller.onAddToCartPressed,
                        fontSize: 16.sp,
                        verticalPadding: 14.h,
                      ).animate().fade().slideY(
                            duration: 300.ms,
                            begin: 1,
                            curve: Curves.easeInSine,
                          ),
                    ),
                    SizedBox(height: 20.h),

                    // AR View Button
                    Text(
                      "More Products",
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(height: 30.h),
                    SizedBox(
                      height: 180.h, // Adjust to fit your layout
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            controller.products.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: SizedBox(
                                width: 150.w,
                                child: ProductItem(
                                  product: controller.products[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    SizedBox(height: 30.h),
                  ],
                );
        }),
      ),
    );
  }
}
