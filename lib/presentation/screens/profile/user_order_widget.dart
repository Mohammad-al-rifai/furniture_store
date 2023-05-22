import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/default_element.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/models/order_models/user_orders_model.dart';
import '../../resources/color_manager.dart';

class UserOrderWidget extends StatelessWidget {
  const UserOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        OrderCubit cubit = OrderCubit.get(context);
        if (cubit.orders.isEmpty) {
          return Lottie.asset(JsonAssets.empty);
        }
        if (state is GetUserOrdersLoadingState) {
          return const DefaultLoading();
        } else {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                (cubit.orders.isNotEmpty || state is GetUserOrdersDoneState) &&
                Constants.token.isNotEmpty,
            widgetBuilder: (context) {
              return Column(
                children: [
                  const DefaultLabel(text: AppStrings.yourOwnOrders),
                  const SizedBox(height: AppSize.s4),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildOrderItem(orderData: cubit.orders[index]);
                    },
                    itemCount: cubit.orders.length,
                  ),
                ],
              );
            },
            fallbackBuilder: (context) => const SizedBox(),
          );
        }
      },
    );
  }

  Widget buildOrderItem({required OrderData orderData}) {
    return DismissibleTile(
      key: UniqueKey(),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      delayBeforeResize: const Duration(milliseconds: 500),
      ltrDismissedColor: Colors.lightBlueAccent,
      rtlDismissedColor: Colors.redAccent,
      ltrOverlay: const Text('Add'),
      ltrOverlayDismissed: const Text('Added'),
      rtlOverlay: const Text('Delete'),
      rtlOverlayDismissed: const Text('Deleted'),
      child: Card(
        child: Container(
          margin: const EdgeInsetsDirectional.symmetric(
              horizontal: AppMargin.m8, vertical: AppMargin.m8),
          decoration: getDeco(color: ColorManager.white, withShadow: true),
          child: Column(
            children: [
              PairWidget(
                label: AppStrings.orderOwner,
                value: orderData.fullName,
              ),
              PairWidget(
                label: AppStrings.orderLocation,
                value:
                    '${orderData.shippingAddress?.country} - ${orderData.shippingAddress?.city} - ${orderData.shippingAddress?.region}',
              ),
              PairWidget(
                label: AppStrings.streetNumber,
                value: orderData.shippingAddress?.streetNumber.toString(),
              ),
              PairWidget(
                label: AppStrings.houseNumber,
                value: orderData.shippingAddress?.houseNumber.toString(),
              ),
              PairWidget(
                label: AppStrings.orderStatus,
                value: orderData.status,
              ),
              PairWidget(
                label: AppStrings.totalPrice,
                value: orderData.totalPrice.toString(),
              ),
              PairWidget(
                label: AppStrings.description,
                value: orderData.shippingAddress?.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
