import 'package:ecommerce/presentation/screens/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../../domain/models/product_models/products_list_model.dart';
import '../../../components/default_element.dart';
import '../../../components/loading.dart';
import '../../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class RecommendedProWidget extends StatefulWidget {
  const RecommendedProWidget({
    Key? key,
    this.isListView = false,
  }) : super(key: key);

  final bool isListView;

  @override
  State<RecommendedProWidget> createState() => _RecommendedProWidgetState();
}

class _RecommendedProWidgetState extends State<RecommendedProWidget> {
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
            if (widget.isListView) {
              return Column(
                children: [
                  const DefaultLabel(text: AppStrings.recommendedProducts),
                  SizedBox(height: AppSize.s8),
                  buildListView(products: cubit.recommendedProducts),
                ],
              );
            } else {
              return Column(
                children: [
                  const DefaultLabel(text: AppStrings.recommendedProducts),
                  SizedBox(height: AppSize.s8),
                  buildGridView(products: cubit.recommendedProducts),
                ],
              );
            }
          },
          fallbackBuilder: (context) => const DefaultLoading(),
        );
      },
    );
  }

  Widget buildGridView({required List<Product> products}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6 / 8,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(product: products[index]);
      },
    );
  }

  Widget buildListView({required List<Product> products}) {
    return SizedBox(
      height: AppSize.s220,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(product: products[index]);
        },
        itemCount: products.length,
      ),
    );
  }
}
