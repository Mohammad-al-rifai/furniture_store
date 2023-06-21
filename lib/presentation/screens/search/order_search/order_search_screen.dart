import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/order_models/order_advanced_search_model.dart';
import 'package:ecommerce/presentation/components/error.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:ecommerce/presentation/screens/order/order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'order_search_widgets/filter_item_widget.dart';

class OrderSearchScreen extends StatefulWidget {
  const OrderSearchScreen({Key? key}) : super(key: key);

  @override
  State<OrderSearchScreen> createState() => _OrderSearchScreenState();
}

class _OrderSearchScreenState extends State<OrderSearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TFF(
                controller: searchController,
                label: 'search'.tr(),
                prefixIcon: Icons.search,
                validator: (String value) {},
                onFieldSubmitted: (String value) {
                  SearchCubit.get(context).orderParams?.firstName = value;
                  SearchCubit.get(context).orderAdvancedSearch(
                      params: SearchCubit.get(context).orderParams);
                },
              ),
            ),
            body: Column(
              children: [
                getFilters(SearchCubit.get(context)),
                getBody(state: state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getBody({required SearchStates state}) {
    if (state is OrderAdvancedSearchLoadingState) {
      return const DefaultLoading();
    }
    if (state is OrderAdvancedSearchErrorState) {
      return const DefaultError();
    }
    if (state is OrderAdvancedSearchDoneState) {
      return Conditional.single(
        context: context,
        conditionBuilder: (context) =>
            (state.data!.isNotEmpty) && Constants.token.isNotEmpty,
        widgetBuilder: (context) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildOrderSearchItem(datum: state.data![index]);
              },
              itemCount: state.data!.length,
            ),
          );
        },
        fallbackBuilder: (context) {
          if (state.data!.isEmpty) {
            return Expanded(child: Lottie.asset(JsonAssets.empty));
          } else {
            return MText(
              text: AppStrings.somethingsErrorPleaseCheckYourInternet,
            );
          }
        },
      );
    }
    return Container();
  }

  Widget getFilters(SearchCubit cubit) {
    return Container(
      height: AppSize.s50,
      decoration: const BoxDecoration(color: ColorManager.white),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return FilterItemWidget(
            filterData: cubit.getFiltersList[index],
            cubit: cubit,
          );
        },
        itemCount: cubit.getFiltersList.length,
        separatorBuilder: (BuildContext context, int index) {
          return  SizedBox(width: AppSize.s4);
        },
      ),
    );
  }

  Widget buildOrderSearchItem({required Datum datum}) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          OrderDetailsScreen(
            orderId: datum.id ?? '',
          ),
        );
      },
      child: Card(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppMargin.m8, vertical: AppMargin.m8),
              decoration: getDeco(color: ColorManager.white, withShadow: true),
              child: Column(
                children: [
                  PairWidget(
                    label: AppStrings.orderOwner,
                    value: datum.fullName,
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.orderLocation,
                    value:
                        '${datum.shippingAddress?.country} - ${datum.shippingAddress?.city} - ${datum.shippingAddress?.region}',
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.streetNumber,
                    value: datum.shippingAddress?.streetNumber.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.houseNumber,
                    value: datum.shippingAddress?.houseNumber.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.orderStatus,
                    value: datum.status,
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.totalPrice,
                    value: datum.totalPrice.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.description,
                    value: datum.shippingAddress?.description,
                    notTR: true,
                  ),
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
                    OrderDetailsScreen(
                      orderId: datum.id ?? '',
                    ),
                  );
                },
                icon:  Icon(
                  CupertinoIcons.info_circle,
                  color: ColorManager.darkPrimary,
                  size: AppSize.s30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
