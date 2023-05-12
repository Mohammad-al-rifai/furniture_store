import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/categories/all_categories_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/shared_widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      bodyWidget: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                cubit.categories.isNotEmpty ||
                state is GetMerchantCategoriesDoneState,
            widgetBuilder: (context) {
              return Padding(
                padding: const EdgeInsetsDirectional.all(AppPadding.p8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 6 / 8,
                    crossAxisSpacing: AppSize.s8,
                    mainAxisSpacing: AppSize.s8,
                  ),
                  itemCount: cubit.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                      catData: cubit.categories[index],
                    );
                  },
                ),
              );
            },
            fallbackBuilder: (context) {
              return const DefaultLoading();
            },
          );
        },
      ),
    );
  }
}
