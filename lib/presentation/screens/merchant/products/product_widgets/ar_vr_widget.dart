import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/vr_screen.dart';
import 'package:flutter/material.dart';


class ArVRWidget extends StatelessWidget {
  const ArVRWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          cubit.vrUrl.isNotEmpty
              ? Expanded(
                  child: DTextButton(
                    function: () {
                      navigateTo(
                        context,
                        VRScreen(
                          name: 'GLP',
                          modelUrl: cubit.vrUrl,
                        ),
                      );
                    },
                    text: AppStrings.vrMode.tr(),
                  ),
                )
              : Container(),
          cubit.arUrl.isNotEmpty
              ? Expanded(
                  child: DTextButton(
                    function: () {
                      navigateTo(
                        context,
                        VRScreen(
                          name: 'GLP',
                          modelUrl: cubit.arUrl,
                        ),
                      );
                    },
                    text: AppStrings.arMode.tr(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
