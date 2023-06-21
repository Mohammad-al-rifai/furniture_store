import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/domain/models/auth_models/merchants_model.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/categories/merchant_categories_screen.dart';
import 'package:ecommerce/presentation/screens/merchant/offers/offers_screen.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MerchantLayout extends StatelessWidget {
  const MerchantLayout({
    Key? key,
    required this.merchantUser,
  }) : super(key: key);

  final MerchantUser? merchantUser;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => MerchantLayoutCubit()
          ..getMerchantProducts(merchantId: merchantUser?.sId ?? '')
          ..getMerchantCategories(merchantId: merchantUser?.sId ?? ''),
        child: BlocConsumer<MerchantLayoutCubit, MerchantLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            MerchantLayoutCubit cubit = MerchantLayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: CachedNetworkImage(
                  imageUrl:
                      Urls.filesUrl + (merchantUser?.marketLogo ?? ''),
                ),
                bottom: TabBar(
                  labelStyle: getMediumStyle(color: ColorManager.primary),
                  tabs: [
                    Tab(text: AppStrings.products.tr()),
                    Tab(text: AppStrings.categories.tr()),
                    Tab(text: AppStrings.offers.tr()),
                  ],
                  physics: const BouncingScrollPhysics(),
                ),
                title: MText(
                  text:
                      merchantUser?.marketName ?? AppStrings.welcomeHere,
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: AppSize.s20,
                  ),
                ),
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProductScreen(merchantId: merchantUser?.sId ?? ''),
                  MerchantCategoriesScreen(
                      merchantId: merchantUser?.sId ?? ''),
                  const OffersScreen(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
