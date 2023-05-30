import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';

class DefaultDismissible extends StatelessWidget {
  const DefaultDismissible({
    Key? key,
    required this.widget,
    required this.function,
  }) : super(key: key);

  final Widget widget;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return DismissibleTile(
      key: UniqueKey(),
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.s14)),
      delayBeforeResize: const Duration(milliseconds: 500),
      ltrDismissedColor: ColorManager.error,
      rtlDismissedColor: ColorManager.error,
      onDismissed: (DismissibleTileDirection direction) => function(),
      ltrOverlay: MText(
        text: AppStrings.delete,
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      ltrOverlayDismissed: MText(
        text: AppStrings.deletedSuccessfully,
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      rtlOverlay: MText(
        text: AppStrings.delete,
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      rtlOverlayDismissed: MText(
        text: AppStrings.deletedSuccessfully,
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      child: widget,
    );
  }
}
