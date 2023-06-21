import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRemoveWishlistItem extends StatefulWidget {
  const AddRemoveWishlistItem({
    Key? key,
    required this.proId,
  }) : super(key: key);
  final String proId;

  @override
  State<AddRemoveWishlistItem> createState() => _AddRemoveWishlistItemState();
}

class _AddRemoveWishlistItemState extends State<AddRemoveWishlistItem> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistStates>(
      listener: (context, state) {
        if (state is AddPro2WishlistDoneState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (Constants.token.isNotEmpty) {
              if (WishlistCubit.get(context)
                  .isProInMyWishlist(proId: widget.proId)) {
                WishlistCubit.get(context).removeProFromWishlist(
                  proId: widget.proId,
                );
              } else {
                WishlistCubit.get(context).addPro2Wishlist(proId: widget.proId);
              }
            } else {
              showToast(
                text: AppStrings.pleaseLogin2YourAccount,
                state: ToastStates.WARNING,
              );
            }
          },
          icon: Icon(
            WishlistCubit.get(context).isProInMyWishlist(proId: widget.proId)
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
            color: ColorManager.primary,
            size: AppSize.s30,
          ),
        );
      },
    );
  }
}
