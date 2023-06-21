import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';


import 'my_text.dart';

class DefaultLabel extends StatelessWidget {
  const DefaultLabel({
    Key? key,
    required this.text,
    this.showAllFunction,
  }) : super(key: key);

  final String text;
  final Function? showAllFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 20.0,
              height: 16.0,
              margin: const EdgeInsetsDirectional.only(start: AppMargin.m8),
              decoration: getDeco(withShadow: true),
            ),
            SizedBox(
              width: AppSize.s8,
            ),
            Transform.translate(
              offset: const Offset(0.0, 2),
              child: MText(
                text: text,
                style: getBoldStyle(color: ColorManager.primary),
              ),
            ),
            const Spacer(),
            showAllFunction != null
                ? Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: AppPadding.p8),
                    child: Transform.translate(
                      offset: const Offset(0.0, 20),
                      child: DTextButton(
                        text: AppStrings.showAll.tr(),
                        function: () {
                          if (showAllFunction != null) {
                            showAllFunction!();
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
