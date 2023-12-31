import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/categories/all_categories_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../merchant/categories/products_4_cat_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    required this.catData,
    this.merchantId,
  }) : super(key: key);
  final CategoryData catData;
  final String? merchantId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          Products4Screen(
            catName: catData.enName ?? '',
            merchantId: merchantId ?? '',
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.lightPrimary.withOpacity(.4),
          borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: AppSize.s25,
              child: DefaultImage(imageUrl: catData.imageOfCate),
            ),
             SizedBox(
              height: AppSize.s8,
            ),
            Text(
              getNameTr(
                arName: catData.arName,
                enName: catData.enName,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: getBoldStyle(color: ColorManager.darkPrimary),
            )
          ],
        ),
      ),
    );
  }
}
