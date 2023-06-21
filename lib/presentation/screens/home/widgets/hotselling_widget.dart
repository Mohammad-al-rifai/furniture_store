import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/default_label.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/product_item.dart';
import 'package:ecommerce/presentation/screens/hot_selling/hot_selling_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';


class HotSellingWidget extends StatelessWidget {
  const HotSellingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.products.isNotEmpty,
          widgetBuilder: (context) {
            return Column(
              children: [
                DefaultLabel(
                  text: AppStrings.hotSelling,
                  showAllFunction: () {
                    navigateTo(
                      context,
                      const HotSellingScreen(),
                    );
                  },
                ),
                SizedBox(height: AppSize.s8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 6 / 8,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                  ),
                  itemCount:
                      cubit.products.length > 2 ? 2 : cubit.products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: cubit.products[index]);
                  },
                ),
              ],
            );
          },
          fallbackBuilder: (context) => const DefaultLoading(),
        );
      },
    );
  }
}
