import 'package:flutter/material.dart';

import '../../../../components/my_text.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';

class PairWidget extends StatelessWidget {
  const PairWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: MText(
              text: label ?? '',
              maxLines: 2,
              textAlign: TextAlign.justify,
              style: getMediumStyle(
                color: ColorManager.primary,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: AppMargin.m4,
              end: AppMargin.m8,
            ),
            width: 3.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
            ),
          ),
          Expanded(
            flex: 2,
            child: MText(
              text: value ?? '',
              maxLines: 5,
              textAlign: TextAlign.justify,
              style: getRegularStyle(color: ColorManager.primary),
            ),
          ),
        ],
      ),
    );
  }
}
