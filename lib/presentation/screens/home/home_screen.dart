import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/cubit/test_cubit/test_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/home/widgets/categories_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/merchants_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/recommended_pro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/banners_widget.dart';
import 'widgets/hotselling_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      bodyWidget: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // BannerWidget(),
            // CategoriesWidget(),
            // RecommendedProWidget(isListView: true),
            HotSellingWidget(),
            AllMerchantsWidget(),
            // testWidget(),
          ],
        ),
      ),
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
