import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';

import '../../components/my_text.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../login/login_screen.dart';
import '../order/add_order_screen.dart';
import 'cart_widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    CartCubit.get(context).getUserCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      bodyWidget: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                cubit.items.isNotEmpty || state is GetUserCartDoneState,
            widgetBuilder: (context) {
              return Column(
                children: [
                  buildCartControlWidget(),
                  SizedBox(height: AppSize.s8),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem: cubit.items[index],
                        );
                      },
                      itemCount: cubit.items.length,
                    ),
                  ),
                ],
              );
            },
            fallbackBuilder: (context) {
              return handleFallBackWidget(list: cubit.items, context: context);
            },
          );
        },
      ),
    );
  }

  Widget buildCartControlWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppPadding.p8),
      child: SizedBox(
        height: AppSize.s50,
        child: Container(
          width: getScreenWidth(context),
          padding: const EdgeInsetsDirectional.only(end: AppPadding.p8),
          decoration: getDeco(
            color: ColorManager.white,
            borderSize: AppSize.s8,
            withShadow: true,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PairWidget(
                  label: AppStrings.totalPrice,
                  value: CartCubit.get(context)
                          .userCartModel
                          .data
                          ?.totalPrice
                          .toString() ??
                      "0.0",
                ),
              ),
              DefaultButton(
                function: () {
                  navigateTo(
                    context,
                    AddOrderScreen(),
                  );
                },
                text: AppStrings.buyNow.tr(),
                width: AppSize.s40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
