import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/functions.dart';
import '../../../../../domain/models/product_models/products_list_model.dart';
import '../../../../components/default_image.dart';
import '../../../../components/my_text.dart';
import '../../../../components/price_widget.dart';
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
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: widget.product?.id,
            mainImageUrl: widget.product?.mainImage,
          ),
        );
      },
      highlightColor: ColorManager.lightPrimary,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            SizedBox(
              height: 140.0,
              child: DefaultImage(imageUrl: widget.product?.mainImage),
            ),
            SizedBox(height: AppSize.s8),
            MText(
              text: widget.product?.name ?? 'Pro Name',
              color: ColorManager.black,
              maxLines: 2,
              textAlign: TextAlign.center,
              notTR: true,
            ),
            SizedBox(height: AppSize.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddRemoveWishlistItem(proId: widget.product?.id ?? ''),
                Expanded(
                  child: priceWidget(
                    price: widget.product?.productClass[0].price.toString() ??
                        'Pro Price',
                    fontSize: AppSize.s18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
