// Hot Selling Widget:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../../../app/functions.dart';
import '../../../../domain/models/product_models/hot_selling_model.dart';
import '../../../components/default_element.dart';
import '../../../components/default_image.dart';
import '../../../components/error.dart';
import '../../../components/loading.dart';
import '../../../components/price_widget.dart';
import '../../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

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
                const DefaultLabel(text: AppStrings.hotSelling),
                const SizedBox(height: AppSize.s8),
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
                    return buildProItem(cubit.products[index], context);
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

  Widget buildProItem(HotSellingProduct product, context) {
    return InkWell(
      onTap: () {},
      focusColor: ColorManager.primary,
      autofocus: true,
      highlightColor: ColorManager.lightPrimary,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            SizedBox(
              height: 140.0,
              child: DefaultImage(imageUrl: product.product!.mainImage),
            ),
            const SizedBox(height: AppSize.s8),
            MText(
              text: product.product?.name ?? 'Pro Name',
              color: ColorManager.black,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    CupertinoIcons.cart_badge_plus,
                    color: ColorManager.white,
                  ),
                ),
                priceWidget(
                  price: product.product?.productClass[0].price.toString() ??
                      'Pro Price',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
