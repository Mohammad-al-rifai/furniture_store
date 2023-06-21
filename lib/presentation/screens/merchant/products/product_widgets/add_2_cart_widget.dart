import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Add2CartWidget extends StatefulWidget {
  const Add2CartWidget({
    Key? key,
    required this.productId,
    required this.classId,
    required this.groupId,
  }) : super(key: key);

  final String? productId;
  final String? classId;
  final String? groupId;

  @override
  State<Add2CartWidget> createState() => _Add2CartWidgetState();
}

class _Add2CartWidgetState extends State<Add2CartWidget> {
  num quantity = 1;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is Add2CartDoneState) {
          showToast(
            text: 'Product Added Done✔️',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is Add2CartErrorState) {
          showToast(
            text: 'Please Check Your Account',
            state: ToastStates.WARNING,
          );
        }
      },
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            DefaultButton(
              text: AppStrings.add2Cart.tr(),
              function: () {
                cubit.add2Cart(
                  productId: widget.productId ?? '',
                  classId: widget.classId ?? '',
                  groupId: widget.groupId ?? '',
                  quantity: quantity,
                );
              },
              isLoading: state is Add2CartLoadingState,
            ),
            Container(
              height: AppSize.s40,
              width: 80.0,
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
                        setState(() {
                          if (quantity <= 1) {
                            quantity = 1;
                          } else {
                            quantity -= 1;
                          }
                        });
                      },
                      child:  Icon(
                        CupertinoIcons.minus,
                        size: AppSize.s20,
                      ),
                    ),
                  ),
                  MText(
                    text: quantity.toString(),
                    notTR: true,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      },
                      child:  Icon(
                        CupertinoIcons.plus,
                        size: AppSize.s20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
