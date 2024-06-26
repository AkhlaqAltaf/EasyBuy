import 'package:easy_buy_app/presentation_layer/utils/constant/image_strings.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
class SocialIconFooter extends StatelessWidget {
  const SocialIconFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
     
        Container(
          decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(100.0),
          ),
          child: IconButton(
    onPressed: () {},
    icon: Image(
      image: AssetImage(ImagesStrings.fb),
      width: AppSizes.iconMd,
      height: AppSizes.iconMd,
    ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(100.0),
          ),
          child: IconButton(
    onPressed: () {},
    icon: Image(
      image: AssetImage(ImagesStrings.google),
      width: AppSizes.iconMd,
      height: AppSizes.iconMd,
    ),
          ),
        ),
    
      ],
    );
  }
}
