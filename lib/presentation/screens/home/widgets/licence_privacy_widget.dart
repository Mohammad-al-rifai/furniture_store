import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/my_divider.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class LicencePrivacyWidget extends StatelessWidget {
  const LicencePrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDivider(
          width: getScreenWidth(context) / 1.5,
          margin: AppMargin.m16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              height: 30.0,
              width: 30.0,
              fit: BoxFit.cover,
              IconsAssets.copyRight,
              color: ColorManager.lightPrimary,
            ),
            SizedBox(width: AppSize.s8),
            MText(
              text: AppStrings.alBakriFurniture,
              style: getBoldStyle(color: ColorManager.darkPrimary),
            ),
          ],
        ),
        SizedBox(height: AppSize.s8),
        MText(
          text: AppStrings.allRightsReserved2023,
          style: getExtraLightStyle(color: ColorManager.black),
        ),
      ],
    );
  }
}
