import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../cubit/order_cubit/order_cubit.dart';
import '../../resources/string_manager.dart';
import 'order_widgets/single_order_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    OrderCubit.get(context).getOrderById(
      orderId: widget.orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.orderDetails,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OrderCubit cubit = OrderCubit.get(context);
            if (state is GetSingleOrderByIdLoadingState) {
              return const DefaultLoading();
            } else {
              return Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    cubit.singleOrderModel.data?.items != null,
                widgetBuilder: (context) {
                  return SingleOrderWidget(
                    data: cubit.singleOrderModel.data,
                  );
                },
                fallbackBuilder: (context) {
                  return Center(
                    child: MText(
                      text: 'No Details Yet!...',
                      notTR: true,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
