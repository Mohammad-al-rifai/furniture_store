import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/cart_models/user_cart_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final UserCartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          height: AppSize.s150,
          decoration: getDeco(withShadow: true, borderSize: AppSize.s8),
          child: Row(
            children: [
              DefaultImage(
                imageUrl: cartItem.product?.mainImage,
                width: AppSize.s150,
                fit: BoxFit.fill,
                clickable: true,
                height: double.infinity,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MText(
                        text: cartItem.product?.name ?? 'Product Name',
                        color: ColorManager.white,
                      ),
                      const Spacer(),
                      buildOperationsOnCartWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        buildDeleteItem(),
      ],
    );
  }

  Widget buildDeleteItem() {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is DeleteProFromCartDoneState) {
          CartCubit.get(context).getUserCart();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: MText(
                      text: AppStrings.confirmationDeleting,
                      style: getBoldStyle(
                        color: ColorManager.primary,
                      ),
                    ),
                    content: MText(
                      text: AppStrings.areYouSureYouWant2DeleteThisProduct,
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                    ),
                    actions: [
                      DTextButton(
                        text: AppStrings.yes,
                        function: () {
                          CartCubit.get(context).deleteProFromCart(
                            groupId: cartItem.group?.id.toString(),
                            itemID: cartItem.itemID,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                      DTextButton(
                        text: AppStrings.no,
                        function: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              CupertinoIcons.delete,
              color: ColorManager.error,
              size: AppSize.s30,
            ),
          ),
        );
      },
    );
  }

  Widget buildOperationsOnCartWidget() {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is DoOperationOnCartDoneState) {
          CartCubit.get(context).getUserCart();
        }
      },
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Container(
          height: AppSize.s40,
          width: AppSize.s100,
          decoration: getDeco(
            withShadow: true,
            borderSize: AppSize.s8,
            color: ColorManager.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    cubit.operationsOnCart(
                      productId: cartItem.product?.id ?? '',
                      classId: cartItem.itemClass?.id ?? '',
                      groupId: cartItem.group?.id ?? '',
                      itemID: cartItem.itemID ?? '',
                      increment: false,
                    );
                  },
                  child: Icon(
                    CupertinoIcons.minus,
                    size: AppSize.s25,
                  ),
                ),
              ),
              MText(
                text: cartItem.quantity.toString(),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    cubit.operationsOnCart(
                      productId: cartItem.product?.id ?? '',
                      classId: cartItem.itemClass?.id ?? '',
                      groupId: cartItem.group?.id ?? '',
                      itemID: cartItem.itemID ?? '',
                      increment: true,
                    );
                  },
                  child: Icon(
                    CupertinoIcons.plus,
                    size: AppSize.s25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
