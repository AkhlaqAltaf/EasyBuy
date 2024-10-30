import 'package:easy_buy_app/data_layer/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Product Image
            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: primaryImage != null
                    ? Image.network(
                        primaryImage.image,
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 80);
                        },
                      ).animate().fade(duration: 300.ms).scale()
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            // "In Stock" Badge
            if (product.stock != Null)
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "In Stock",
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
              ),
            // Product Details
            Positioned(
              left: 16.w,
              bottom: 16.h,
              right: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fade(duration: 300.ms),
                  SizedBox(height: 4.h),
                  Text(
                    '${product.price}\$',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fade(duration: 300.ms),
                ],
              ),
            ),
            // Add to Cart Button
            Positioned(
              right: 16.w,
              bottom: 16.h,
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
          ],
        ),
      ),
    );
  }
}
