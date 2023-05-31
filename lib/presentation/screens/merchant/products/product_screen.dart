import 'package:ecommerce/domain/models/product_models/products_list_model.dart';
import 'package:ecommerce/presentation/components/error.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_divider.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/functions.dart';
import '../../../components/default_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../shared/add_remove_wishlist_widget.dart';
import 'details_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.merchantId,
  }) : super(key: key);

  final String merchantId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantLayoutCubit, MerchantLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MerchantLayoutCubit cubit = MerchantLayoutCubit.get(context);

        if (state is GetMerchantProLoadingState) {
          return const DefaultLoading();
        }
        if (state is GetMerchantProErrorState) {
          return const DefaultError();
        }

        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.products.isNotEmpty || state is GetMerchantProDoneState,
          widgetBuilder: (context) {
            return Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: AppPadding.p8,
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildProductItem(
                    cubit.products[index],
                  );
                },
                itemCount: cubit.products.length,
                separatorBuilder: (BuildContext context, int index) {
                  return MyDivider(
                    margin: 4,
                    color: ColorManager.white,
                  );
                },
              ),
            );
          },
          fallbackBuilder: (context) => Lottie.asset(JsonAssets.empty),
        );
      },
    );
  }

  Widget buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: product.id,
            mainImageUrl: product.mainImage,
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            margin:
                const EdgeInsetsDirectional.symmetric(horizontal: AppMargin.m8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: AppSize.s200,
            width: double.infinity,
            decoration: getDeco(borderSize: AppSize.s8),
            child: Hero(
              tag: product.mainImage ?? 'Details',
              child: DefaultImage(imageUrl: product.mainImage),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: AppPadding.p4,
              end: AppPadding.p8,
            ),
            child: AddRemoveWishlistItem(proId: product.id ?? ''),
          )
        ],
      ),
    );
  }
}
