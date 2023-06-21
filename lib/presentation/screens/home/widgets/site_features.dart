import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/default_label.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/site_features/site_features_screen.dart';
import 'package:ecommerce/presentation/screens/site_features/widgets/site_features_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SiteFeatures extends StatelessWidget {
  const SiteFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Column(
          children: [
            DefaultLabel(
              text: AppStrings.siteFeatures,
              showAllFunction: () {
                navigateTo(
                  context,
                  const SiteFeaturesScreen(),
                );
              },
            ),
            SizedBox(height: AppSize.s8),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return SiteFeaturesWidget(
                  data: cubit.featureList[index],
                );
              },
              itemCount:
                  cubit.featureList.length > 2 ? 2 : cubit.featureList.length,
            ),
          ],
        );
      },
    );
  }
}
