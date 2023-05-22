import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../../../domain/models/categories/all_categories_model.dart';
import '../../../components/default_element.dart';
import '../../../components/default_image.dart';
import '../../../components/my_text.dart';
import '../../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.categories.isNotEmpty,
          widgetBuilder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DefaultLabel(text: AppStrings.categories),
                SizedBox(
                  height: AppSize.s110,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildCatItem(
                              catData: cubit.categories[index],
                            );
                          },
                          itemCount: cubit.categories.length,
                        ),
                      ),
                      ViewAllWidget(
                        onTap: () {
                          cubit.changeBottom(1);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          fallbackBuilder: (context) {
            return MText(
              text: AppStrings.somethingsErrorPleaseCheckYourInternet,
            );
          },
        );
      },
    );
  }

  Widget buildCatItem({
    required CategoryData catData,
  }) {
    return SizedBox(
      width: 90.0,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin:
                const EdgeInsetsDirectional.symmetric(vertical: AppMargin.m8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s30),
              color: ColorManager.primary,
            ),
            child: CircleAvatar(
              radius: AppSize.s30,
              child: DefaultImage(
                imageUrl: catData.imageOfCate,
                fit: BoxFit.contain,
                clickable: true,
              ),
            ),
          ),
          MText(
            text: getNameTr(arName: catData.arName, enName: catData.enName),
            color: ColorManager.black,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
