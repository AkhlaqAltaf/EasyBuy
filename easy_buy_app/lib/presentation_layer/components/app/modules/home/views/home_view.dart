import 'package:easy_buy_app/apis/products/categories.dart';
import 'package:easy_buy_app/data_layer/product/category.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/drawer/drawer.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/category_item.dart';
import '../../../components/custom_form_field.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/dark_transition.dart';
import '../../../components/product_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
        drawer: drawer(context, isLogin: true),
        body: DarkTransition(
          offset: Offset(context.width, -1),
          isDark: !controller.isLightTheme,
          builder: (context, _) => Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: -100.h,
                  child: SvgPicture.asset(
                    Constants.container,
                    fit: BoxFit.fill,
                    color: theme.canvasColor,
                  ),
                ),
                ListView(
                  children: [
                    Column(
                      children: [
                        // drawer(context),
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24.w),
                          title: Text(
                            'Good morning',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 12.sp),
                          ),
                          subtitle: Text(
                            'Amelia Barlow',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 22.r,
                            backgroundColor: theme.primaryColorDark,
                            child: ClipOval(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(Constants.avatar),
                              ),
                            ),
                          ),
                          trailing: CustomIconButton(
                            onPressed: () => controller.onChangeThemePressed(),
                            backgroundColor: theme.primaryColorDark,
                            icon: GetBuilder<HomeController>(
                              id: 'Theme',
                              builder: (_) => Icon(
                                controller.isLightTheme
                                    ? Icons.dark_mode_outlined
                                    : Icons.light_mode_outlined,
                                color: theme.appBarTheme.iconTheme?.color,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: CustomFormField(
                            backgroundColor: theme.primaryColorDark,
                            textSize: 14.sp,
                            hint: 'Search category',
                            hintFontSize: 14.sp,
                            hintColor: theme.hintColor,
                            maxLines: 1,
                            borderRound: 60.r,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            focusedBorderColor: Colors.transparent,
                            isSearchField: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            prefixIcon: SvgPicture.asset(Constants.searchIcon,
                                fit: BoxFit.none),
                          ),
                        ),
                        20.verticalSpace,
                        SizedBox(
                          width: double.infinity,
                          height: 158.h,
                          child: PageView.builder(
                            controller: PageController(
                              initialPage: 1,
                              viewportFraction: 0.9,
                            ),
                            itemCount: controller.cards.length,
                            onPageChanged: (int index) {
                              // Handle page change if necessary
                            },
                            itemBuilder: (context, itemIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(controller.cards[itemIndex]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories 😋',
                                style: theme.textTheme.headlineLarge,
                              ),
                              Text(
                                'all',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          16.verticalSpace,
                          FutureBuilder<List<Category>>(
                            future: getCategories(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                      'Error loading categories: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No categories available.'));
                              } else {
                                final categories = snapshot.data!;

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: categories
                                        .map((category) =>
                                            CategoryItem(category: category))
                                        .toList(),
                                  ),
                                );
                              }
                            },
                          ),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Best selling 🔥',
                                style: theme.textTheme.headlineLarge,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offNamed(Routes.PRODUCTS);
                                },
                                child: Text(
                                  'See all',
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                          16.verticalSpace,
                          Obx(() {
                            if (controller.products.isEmpty) {
                              return const Center(
                                child: Text('No products available.'),
                              );
                            } else {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h,
                                  mainAxisExtent: 214.h,
                                ),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) => ProductItem(
                                  product: controller.products[index],
                                ),
                              );
                            }
                          }),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
