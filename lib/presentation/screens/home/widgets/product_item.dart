import 'package:flutter/material.dart';

import '../../../../app/functions.dart';
import '../../../../domain/models/product_models/products_list_model.dart';
import '../../../components/default_image.dart';
import '../../../components/my_text.dart';
import '../../../components/price_widget.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../shared/add_remove_wishlist_widget.dart';
import '../../merchant/products/details_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: widget.product.id,
            mainImageUrl: widget.product.mainImage,
          ),
        );
      },
      highlightColor: ColorManager.lightPrimary,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: getScreenWidth(context) / 2.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 140.0,
                child: DefaultImage(imageUrl: widget.product.mainImage),
              ),
              SizedBox(height: AppSize.s8),
              MText(
                text: widget.product.name ?? 'Pro Name',
                color: ColorManager.black,
                maxLines: 2,
                textAlign: TextAlign.center,
                notTR: true,
              ),
              SizedBox(height: AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddRemoveWishlistItem(proId: widget.product.id ?? ''),
                  Expanded(
                    child: priceWidget(
                      price: widget.product.productClass[0].price.toString() ??
                          'Pro Price',
                      fontSize: AppSize.s18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
