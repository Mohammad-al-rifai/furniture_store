import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/button.dart';
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

import '../../../../domain/models/cart_models/user_cart_model.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final UserCartItem cartItem;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
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
                imageUrl: widget.cartItem.product?.mainImage,
                width: AppSize.s150,
                fit: BoxFit.fill,
                clickable: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MText(
                        text: widget.cartItem.product?.name ?? 'Product Name',
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
                            groupId: widget.cartItem.group?.id.toString(),
                            itemID: widget.cartItem.itemID,
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
            icon: const Icon(
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
          decoration: getDeco(
            color: ColorManager.white,
            withShadow: true,
            borderSize: AppSize.s8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.operationsOnCart(
                        productId: widget.cartItem.product?.id ?? '',
                        classId: widget.cartItem.itemClass?.id ?? '',
                        groupId: widget.cartItem.group?.id ?? '',
                        itemID: widget.cartItem.itemID ?? '',
                        increment: false,
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.minus_rectangle,
                      color: ColorManager.white,
                      size: AppSize.s25,
                    ),
                  ),
                ),
              ),
              MText(
                text: widget.cartItem.quantity.toString() ?? '0',
                style: getExtraBoldStyle(color: ColorManager.darkPrimary),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.operationsOnCart(
                        productId: widget.cartItem.product?.id ?? '',
                        classId: widget.cartItem.itemClass?.id ?? '',
                        groupId: widget.cartItem.group?.id ?? '',
                        itemID: widget.cartItem.itemID ?? '',
                        increment: true,
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.plus_app,
                      color: ColorManager.white,
                      size: AppSize.s25,
                    ),
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
