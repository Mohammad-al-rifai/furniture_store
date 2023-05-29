// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/languages.dart';
import '../../../components/my_divider.dart';
import '../../../components/my_text.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.titleTR,
    this.isLang = false,
    this.withDivider = true,
  });

  final Function onTap;
  final String iconPath;
  final String titleTR;
  final bool isLang;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                height: 30.0,
                width: 30.0,
                fit: BoxFit.cover,
                iconPath,
                color: ColorManager.darkPrimary,
              ),
              const SizedBox(width: AppSize.s18),
              Expanded(
                child: MText(
                  text: titleTR,
                  color: ColorManager.black,
                  textAlign: TextAlign.justify,
                ),
              ),
              isLang
                  ? MText(
                      text: Langs.isEN ? AppStrings.english : AppStrings.arabic,
                      style: getExtraLightStyle(
                        color: ColorManager.grey,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          withDivider
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSize.s40,
                  ),
                  child: MyDivider(
                    margin: AppMargin.m8,
                    color: ColorManager.grey1.withOpacity(.3),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
