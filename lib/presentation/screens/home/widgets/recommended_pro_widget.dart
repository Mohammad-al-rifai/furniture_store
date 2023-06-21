import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/product_models/products_list_model.dart';
import 'package:ecommerce/presentation/components/default_label.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/product_item.dart';
import 'package:ecommerce/presentation/screens/recommendation/recommended_pro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class RecommendedProWidget extends StatelessWidget {
  const RecommendedProWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.recommendedProducts.isNotEmpty,
          widgetBuilder: (context) {
            return Column(
              children: [
                DefaultLabel(
                  text: AppStrings.recommendedProducts,
                  showAllFunction: () {
                    navigateTo(
                      context,
                      const RecommendedProScreen(),
                    );
                  },
                ),
                SizedBox(height: AppSize.s8),
                buildListView(products: cubit.recommendedProducts),
              ],
            );
          },
          fallbackBuilder: (context) => const DefaultLoading(),
        );
      },
    );
  }

  Widget buildListView({required List<Product> products}) {
    return SizedBox(
      height: AppSize.s260,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(product: products[index]);
        },
        itemCount: products.length > 4 ? 4 : products.length,
      ),
    );
  }
}
