import 'package:ecommerce/domain/models/product_models/products_list_model.dart';
import 'package:ecommerce/presentation/components/my_listview.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RecommendedProScreen extends StatelessWidget {
  const RecommendedProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.recommendedProducts,
        ),
      ),
      body: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return MyListView<Product>(
            fetchData: () {},
            list: cubit.recommendedProducts,
            noMoreData: true,
            itemBuilder: (context, Product data) => ProductItem(
              product: data,
            ),
          );
        },
      ),
    );
  }
}
