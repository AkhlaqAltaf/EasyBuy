import 'package:easy_buy_app/ar_screen.dart';
import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/models/product_model.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Find primary image, or fall back to the first image if no primary exists
    final primaryImage = product.images.isNotEmpty
        ? product.images.firstWhere((img) => img.is_primary,
            orElse: () => product.images.first)
        : null;

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 12.w,
              bottom: 12.h,
              child: GestureDetector(
                onTap: () =>
                    Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: theme.primaryColor,
                  child: const Icon(Icons.add_rounded, color: Colors.white),
                ).animate().fade(duration: 200.ms),
              ),
            ),
            Positioned(
              top: 22.h,
              left: 26.w,
              right: 25.w,
              // Use Image.network to load from URL dynamically
              child: primaryImage != null
                  ? Image.network(
                      primaryImage.image,
                      height: 100.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Optional error widget
                        return const Icon(Icons.broken_image);
                      },
                    ).animate().slideX(
                        duration: 200.ms,
                        begin: 1,
                        curve: Curves.easeInSine,
                      )
                  : const Icon(
                      Icons.image_not_supported), // Fallback if no image
            ),
            Positioned(
              left: 16.w,
              bottom: 24.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: theme.textTheme.headlineSmall)
                      .animate()
                      .fade()
                      .slideY(
                        duration: 200.ms,
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                  5.verticalSpace,
                  Text(
                    '${product.price}\$',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ).animate().fade().slideY(
                        duration: 200.ms,
                        begin: 2,
                        curve: Curves.easeInSine,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
