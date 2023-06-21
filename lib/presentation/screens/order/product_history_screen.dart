import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/blockchain/pro_history_model.dart';
import 'package:ecommerce/domain/models/blockchain/users_point_history.dart';
import 'package:ecommerce/presentation/components/my_listview.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:lottie/lottie.dart';

import 'order_widgets/users_points_widget.dart';

class ProductHistoryScreen extends StatelessWidget {
  const ProductHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.productHistory),
      ),
      body: BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OrderCubit cubit = OrderCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.proHistoryModel.data != null,
            widgetBuilder: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: AppPadding.p12,
                      ),
                      child: MText(
                        text: AppStrings.yourProductHistoryAt,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: AppSize.s18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: AppPadding.p12,
                      ),
                      child: MText(
                        text: AppStrings.ethereumNetwork,
                        style: getBlackStyle(
                          color: ColorManager.black,
                          fontSize: AppSize.s20,
                        ),
                      ),
                    ),
                    MyListView<ProHistoryData>(
                      physics: const NeverScrollableScrollPhysics(),
                      fetchData: () {},
                      list: cubit.proHistoryModel.data!,
                      noMoreData: true,
                      itemBuilder: (context, ProHistoryData data) {
                        return proHistoryWidget(data: data);
                      },
                    ),
                    SizedBox(height: AppSize.s18),
                    MyListView<UsersPointsData>(
                      physics: const NeverScrollableScrollPhysics(),
                      fetchData: () {},
                      list: cubit.usersPointsModel.data!,
                      noMoreData: true,
                      itemBuilder: (context, UsersPointsData data) {
                        return UserPointWidget(data: data);
                      },
                    ),
                  ],
                ),
              );
            },
            fallbackBuilder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MText(
                  text: AppStrings.pleaseRunYourGanacheSoftware,
                  color: ColorManager.black,
                ),
                Lottie.asset(JsonAssets.opps),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget proHistoryWidget({required ProHistoryData data}) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppPadding.p12),
      margin: const EdgeInsetsDirectional.all(AppMargin.m12),
      decoration: getDeco(
        withShadow: true,
        color: ColorManager.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                PairWidget(
                    label: AppStrings.blockNumber, value: data.blockNumber),
                PairWidget(label: AppStrings.productPrice, value: data.price),
                PairWidget(label: AppStrings.quantity, value: data.quantity),
                PairWidget(label: AppStrings.guarantee, value: data.Guarantee),
                PairWidget(label: AppStrings.orderStatus, value: data.state),
                PairWidget(label: AppStrings.seller, value: data.seller),
                PairWidget(label: AppStrings.classSize, value: data.size),
                PairWidget(
                  label: AppStrings.manufacturingMaterial,
                  value: data.manufacturingMaterial,
                ),
              ],
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(90 * 3.1415927 / 90),
            child: RotatedBox(
              quarterTurns: 1,
              child: MText(
                text: dateTimeFormatter(timestamp: data.timestamp.toString()),
                style: getBoldStyle(color: ColorManager.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
