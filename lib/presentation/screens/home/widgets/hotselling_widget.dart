import 'package:ecommerce/presentation/screens/home/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../../components/default_element.dart';
import '../../../components/loading.dart';
import '../../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class HotSellingWidget extends StatefulWidget {
  const HotSellingWidget({Key? key}) : super(key: key);

  @override
  State<HotSellingWidget> createState() => _HotSellingWidgetState();
}

class _HotSellingWidgetState extends State<HotSellingWidget> {
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
                const DefaultLabel(text: AppStrings.hotSelling),
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
                  itemCount: cubit.products.length,
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
