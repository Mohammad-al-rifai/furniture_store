import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'my_text.dart';

Widget priceWidget({
  required String price,
  double fontSize = AppSize.s20,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      MText(
        text: price,
        style: getExtraBoldStyle(
          color: ColorManager.black,
          fontSize: fontSize,
        ),
      ),
      const SizedBox(width: AppSize.s4),
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
