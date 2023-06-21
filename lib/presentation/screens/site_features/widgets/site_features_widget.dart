import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/featuers_models/featuers_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';


class SiteFeaturesWidget extends StatelessWidget {
  const SiteFeaturesWidget({
    super.key,
    required this.data,
  });

  final FeatureData? data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: AppSize.s200,
          margin: EdgeInsetsDirectional.all(AppSize.s8),
          decoration: getDeco(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DefaultImage(
            imageUrl: data?.icon,
            clickable: true,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          padding: const EdgeInsetsDirectional.all(AppPadding.p4),
          decoration: getDeco(
            color: ColorManager.warning.withOpacity(.4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MText(
                text: data?.title ?? '',
                notTR: true,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: AppSize.s18,
                ),
              ),
              MText(
                text: data?.description ?? '',
                notTR: true,
                style: getMediumStyle(
                  color: ColorManager.black,
                ),
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
