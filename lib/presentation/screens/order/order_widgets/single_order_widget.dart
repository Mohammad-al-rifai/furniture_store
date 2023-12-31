import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/order_models/single_order_model.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/price_widget.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:ecommerce/presentation/screens/order/product_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleOrderWidget extends StatelessWidget {
  const SingleOrderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SingleOrderData? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildMainDetailsAboutOrder(),
          buildItemsOfOrder(),
        ],
      ),
    );
  }

  Widget buildMainDetailsAboutOrder() {
    return Container(
      margin: const EdgeInsetsDirectional.all(AppMargin.m8),
      padding: const EdgeInsetsDirectional.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PairWidget(
            label: AppStrings.totalPrice,
            value: data!.totalPrice.toString() + AppStrings.sp,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.orderStatus,
            value: data?.status,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.paymentMethod,
            value: data?.paymentMethod,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.paymentStatus,
            value: data?.paymentStatus,
            notTR: true,
          ),
        ],
      ),
    );
  }

  Widget buildItemsOfOrder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItemWidget(item: data?.items[index], context: context);
      },
      itemCount: data?.items.length,
    );
  }

  Widget buildItemWidget({
    required SingleOrderItem? item,
    required BuildContext context,
  }) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
            boxShadow: const [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultImage(
                imageUrl: item?.singleProduct?.product?.mainImage ?? '',
                height: AppSize.s200,
                clickable: true,
              ),
              SizedBox(height: AppSize.s8),
              MText(
                text: item?.singleProduct?.product?.name ?? '',
                color: ColorManager.black,
                notTR: true,
              ),
              SizedBox(height: AppSize.s4),
              priceWidget(
                price: item?.price.toString() ?? '',
              ),
              PairWidget(
                label: AppStrings.fromMerchant,
                value: item?.singleProduct?.ownerProduct?.fullName ?? '',
              ),
              PairWidget(
                label: AppStrings.color,
                value: item?.singleProduct?.group?.color ?? '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classSize,
                value: item?.singleProduct?.singleProductClass?.size ?? '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classLength,
                value: item?.singleProduct?.singleProductClass?.length
                        .toString() ??
                    '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classWidth,
                value:
                    item?.singleProduct?.singleProductClass?.width.toString() ??
                        '',
                notTR: true,
              ),
              productHistory(proId: item?.singleProduct?.product?.id ?? ''),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            end: AppPadding.p8,
            bottom: AppPadding.p8,
          ),
          child: IconButton(
            onPressed: () {
              navigateTo(
                context,
                DetailsScreen(
                  proId: item?.singleProduct?.product?.id ?? '',
                  mainImageUrl: item?.singleProduct?.product?.mainImage ?? '',
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.info_circle,
              color: ColorManager.darkPrimary,
              size: AppSize.s30,
            ),
          ),
        ),
      ],
    );
  }

  Widget productHistory({required String proId}) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is GetOrderHistoryDoneState &&
            OrderCubit.get(context).usersPointsModel.data != null) {
          navigateTo(context, const ProductHistoryScreen());
        }
      },
      builder: (context, state) {
        OrderCubit cubit = OrderCubit.get(context);
        return DefaultButton(
          function: () {
            cubit.getOrderHistory(
              proId: proId,
              orderId: data?.id ?? '',
            );
            cubit.getUsersPointsHistory();

            if (cubit.proHistoryModel.status != null &&
                cubit.proHistoryModel.status!) {
              if (cubit.proHistoryModel.data == null) {
                print('Here');
              }
            }
          },
          text: AppStrings.productHistory.tr(),
          isUpperCase: false,
          isLoading: state is GetOrderHistoryLoadingState ||
              state is GetUsersPointsLoadingState,
        );
      },
    );
  }
}
