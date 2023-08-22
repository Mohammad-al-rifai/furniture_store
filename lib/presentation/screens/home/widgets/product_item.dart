import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/product_models/products_list_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/price_widget.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:ecommerce/presentation/screens/shared_widgets/add_remove_wishlist_widget.dart';
import 'package:flutter/material.dart';



class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: product.id,
            mainImageUrl: product.mainImage,
          ),
        );
      },
      highlightColor: ColorManager.lightPrimary,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: getScreenWidth(context) / 2.0,
          height: AppSize.s260,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  child: DefaultImage(imageUrl: product.mainImage),
                ),
              ),
              SizedBox(height: AppSize.s8),
              MText(
                text: product.name ?? 'Pro Name',
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
                  AddRemoveWishlistItem(proId: product.id ?? ''),
                  Expanded(
                    child: priceWidget(
                      price: product.productClass[0].price.toString(),
                      fontSize: AppSize.s16,
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
