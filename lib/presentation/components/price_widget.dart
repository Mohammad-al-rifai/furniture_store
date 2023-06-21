import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';


import 'my_text.dart';

Widget priceWidget({
  required String price,
  double? fontSize,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      MText(
        text: price,
        style: getExtraBoldStyle(
          color: ColorManager.black,
          fontSize: fontSize ?? AppSize.s20,
        ),
      ),
      SizedBox(width: AppSize.s4),
      MText(
        text: AppStrings.sp,
        textAlign: TextAlign.start,
        style: getMediumStyle(
          color: ColorManager.darkPrimary,
        ),
      ),
    ],
  );
}
