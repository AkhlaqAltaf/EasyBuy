import 'package:easy_buy_app/data_layer/local_storage/auth_store.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/categories_section/category_row_widgets.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/drawer/drawer.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/text_widgets/section_heading.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/header_section_container.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/promo_slider.dart';
import 'package:easy_buy_app/presentation_layer/home_screen/shop/category_scrollablebutton_list.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/colors.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> isUserAuthenticated() async {
    String? token = await getToken();

    if (token == null) {
      print("IT IS FALSE$token");
      return false;
    } else {
      print("IT IS TRUE$token");
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Lamp', 'icon': Icons.lightbulb},
      {'name': 'Vase', 'icon': Icons.tab},
      {'name': 'Chair', 'icon': Icons.chair},
      {'name': 'Table', 'icon': Icons.table_chart},
      {'name': 'Clock', 'icon': Icons.access_time},
      {'name': 'Plant', 'icon': Icons.grass},
      {'name': 'Picture', 'icon': Icons.image},
      {'name': 'Curtains', 'icon': Icons.blinds},
    ];

    return FutureBuilder<bool>(
      future: isUserAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final bool isLogin = snapshot.data ?? false;
          return Scaffold(
            drawer: drawer(context, isLogin: isLogin),
            body: Column(
              children: [
                HeaderContainer(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: AppSizes.spaceBtwItems - 15.0),
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.defaultSpace),
                          child: HomePromoSlider(
                            banners: [
                              ImagesStrings.sliderbanner1,
                              ImagesStrings.sliderbanner2,
                              ImagesStrings.sliderbanner3,
                              ImagesStrings.sliderbanner4,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CategoryRow(categories: categories.sublist(0, 4)),
                              SizedBox(height: 16),
                              CategoryRow(categories: categories.sublist(4, 8)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.defaultSpace),
                          child: HeaderSectionHeadings(
                            title: 'Most Popular',
                            showActionButton: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CategoryList(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
