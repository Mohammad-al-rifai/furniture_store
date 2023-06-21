import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/cubit/test_cubit/test_cubit.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/banners_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/categories_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/hotselling_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/licence_privacy_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/merchants_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/recommended_pro_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/site_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MainScaffold(
          bodyWidget: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const BannerWidget(),
                  const CategoriesWidget(),
                  Constants.token.isNotEmpty
                      ? const RecommendedProWidget()
                      : const SizedBox(),
                  const HotSellingWidget(),
                  const AllMerchantsWidget(),
                  Constants.token.isNotEmpty
                      ? const SiteFeatures()
                      : const SizedBox(),
                  const LicencePrivacyWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget testWidget() {
    return BlocProvider(
      create: (context) => TestCubit(),
      child: BlocConsumer<TestCubit, TestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                DefaultButton(
                  function: () {
                    TestCubit.get(context).add2Cart();
                  },
                  text: AppStrings.add2Cart.tr(),
                  isLoading: state is AddCartLoadingState,
                ),
                DefaultButton(
                  function: () {
                    TestCubit.get(context).operationsOnCart();
                  },
                  text: 'Operations On Cart',
                  isLoading: state is AddCartLoadingState,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
