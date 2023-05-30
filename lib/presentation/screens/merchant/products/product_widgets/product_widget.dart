import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/functions.dart';
import '../../../../../domain/models/product_models/products_list_model.dart';
import '../../../../components/default_image.dart';
import '../../../../cubit/wishlist_cubit/wishlist_cubit.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../shared/add_remove_wishlist_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: widget.product?.id,
            mainImageUrl: widget.product?.mainImage,
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
              tag: widget.product?.mainImage ?? 'Details',
              child: DefaultImage(imageUrl: widget.product?.mainImage),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: AppPadding.p4,
              end: AppPadding.p8,
            ),
            child: AddRemoveWishlistItem(proId: widget.product?.id ?? ''),
          )
        ],
      ),
    );
  }
}
