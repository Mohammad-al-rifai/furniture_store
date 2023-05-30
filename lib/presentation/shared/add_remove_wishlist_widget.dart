import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/wishlist_cubit/wishlist_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

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
            if (WishlistCubit.get(context)
                .isProInMyWishlist(proId: widget.proId)) {
              WishlistCubit.get(context).removeProFromWishlist(
                proId: widget.proId,
              );
            } else {
              WishlistCubit.get(context).addPro2Wishlist(proId: widget.proId);
            }
            setState(() {});
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
