// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'loading.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    super.key,
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.background = ColorManager.primary,
    this.isUpperCase = true,
    this.isLoading = false,
  });

  Function function;
  String text;
  double? width;
  Color? background;
  bool? isUpperCase;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Conditional.single(
        context: context,
        conditionBuilder: (BuildContext context) => !isLoading,
        widgetBuilder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () => function(),
            style: ElevatedButton.styleFrom(
              backgroundColor: background,
            ),
            child: Text(
              isUpperCase! ? text.toUpperCase() : text,
              style: getRegularStyle(
                color: ColorManager.white,
                fontSize: AppSize.s16,
              ),
            ),
          );
        },
        fallbackBuilder: (BuildContext context) {
          return const DefaultLoading(
            xT: 0.0,
            yT: 0.0,
          );
        },
      ),
    );
  }
}
