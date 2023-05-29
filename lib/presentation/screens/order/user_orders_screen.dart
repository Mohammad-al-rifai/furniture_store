import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:lottie/lottie.dart';

import '../../../app/functions.dart';
import '../../../domain/models/order_models/user_orders_model.dart';
import '../../components/loading.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import '../merchant/products/product_widgets/pair_widget.dart';
import '../search/order_search/order_search_screen.dart';
import 'order_details_screen.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  void initState() {
    super.initState();
    if (Constants.token.isNotEmpty) {
      OrderCubit.get(context).getUserOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.yourOwnOrders),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, const OrderSearchScreen());
            },
            icon: const Icon(
              CupertinoIcons.search,
            ),
          ),
        ],
      ),
      body: BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OrderCubit cubit = OrderCubit.get(context);
          if (state is GetUserOrdersLoadingState) {
            return const DefaultLoading();
          } else {
            return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  (cubit.orders.isNotEmpty ||
                      state is GetUserOrdersDoneState) &&
                  Constants.token.isNotEmpty,
              widgetBuilder: (context) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildOrderItem(orderData: cubit.orders[index]);
                  },
                  itemCount: cubit.orders.length,
                );
              },
              fallbackBuilder: (context) {
                if (Constants.token.isEmpty) {
                  return Column(
                    children: [
                      Lottie.asset(JsonAssets.login),
                      DefaultButton(
                        function: () {
                          navigateTo(
                            context,
                            const LoginScreen(),
                          );
                        },
                        text: AppStrings.login,
                      ),
                    ],
                  );
                } else {
                  if (cubit.orders.isEmpty) {
                    return Lottie.asset(JsonAssets.empty);
                  } else {
                    return MText(
                      text: AppStrings.somethingsErrorPleaseCheckYourInternet,
                    );
                  }
                }
              },
            );
          }
        },
      ),
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
      child: GestureDetector(
        onTap: () {
          navigateTo(
            context,
            OrderDetailsScreen(
              orderId: orderData.sId ?? '',
            ),
          );
        },
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
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.orderLocation,
                  value:
                      '${orderData.shippingAddress?.country} - ${orderData.shippingAddress?.city} - ${orderData.shippingAddress?.region}',
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.streetNumber,
                  value: orderData.shippingAddress?.streetNumber.toString(),
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.houseNumber,
                  value: orderData.shippingAddress?.houseNumber.toString(),
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.orderStatus,
                  value: orderData.status,
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.totalPrice,
                  value: orderData.totalPrice.toString(),
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.description,
                  value: orderData.shippingAddress?.description,
                  notTR: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
