import 'package:easy_buy_app/presentation_layer/components/app/components/custom_form_field.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/product_item.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                onPressed: () => Get.offNamed(Routes.BASE),
                backgroundColor: theme.scaffoldBackgroundColor,
                borderColor: theme.dividerColor,
                icon: SvgPicture.asset(
                  Constants.backArrowIcon,
                  fit: BoxFit.none,
                  color: theme.appBarTheme.iconTheme?.color,
                ),
              ),
              Text(
                'Home Decor Products',
                style: theme.textTheme.displaySmall,
              ),
              // Search Icon Button
              CustomIconButton(
                onPressed: () {},
                backgroundColor: theme.scaffoldBackgroundColor,
                borderColor: theme.dividerColor,
                icon: SvgPicture.asset(
                  Constants.basketIcon,
                  fit: BoxFit.none,
                  color: theme.appBarTheme.iconTheme?.color,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomFormField(
                onChanged: (value) {
                  controller.filterProducts(value!); // Call to filter method
                },
                backgroundColor: theme.primaryColorDark,
                textSize: 14.sp,
                hint: 'Search Products',
                hintFontSize: 14.sp,
                hintColor: theme.hintColor,
                maxLines: 1,
                borderRound: 60.r,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                focusedBorderColor: Colors.transparent,
                isSearchField: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                prefixIcon:
                    SvgPicture.asset(Constants.searchIcon, fit: BoxFit.none),
              ),
            ),
            // Search TextField
            // TextField(
            //   onChanged: (value) {
            //     controller.filterProducts(value); // Call to filter method
            //   },
            //   decoration: InputDecoration(
            //     labelText: 'Search Products',
            //     border: OutlineInputBorder(),
            //     suffixIcon: Icon(Icons.search),
            //   ),
            // ),
            SizedBox(height: 16.h), // Spacing
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    "No products available",
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    mainAxisExtent: 260.h, // Adjusted for better spacing
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) => ProductItem(
                    product: controller.filteredProducts[index],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
