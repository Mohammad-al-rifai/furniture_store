import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/featuers_models/featuers_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../components/default_element.dart';
import '../../../resources/string_manager.dart';

class SiteFeaturesWidget extends StatelessWidget {
  const SiteFeaturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.featuresModel.data != null,
          widgetBuilder: (context) {
            return Column(
              children: [
                const DefaultLabel(text: AppStrings.siteFeatures),
                SizedBox(height: AppSize.s8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildFeatureItem(cubit.featuresModel.data?[index]);
                  },
                  itemCount: cubit.featuresModel.data?.length,
                ),
              ],
            );
          },
          fallbackBuilder: (context) {
            return const DefaultLoading();
          },
        );
      },
    );
  }

  Widget buildFeatureItem(FeatureData? data) {
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
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: AppSize.s18,
                ),
              ),
              MText(
                text: data?.description ?? '',
                style: getMediumStyle(
                  color: Colors.white,
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
