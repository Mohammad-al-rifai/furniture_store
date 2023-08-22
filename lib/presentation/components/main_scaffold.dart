import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/default_icon.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/search/advanced_search/advanced_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MainScaffold extends StatelessWidget {
  MainScaffold({
    Key? key,
    this.appBar,
    required this.bodyWidget,
    this.bottomNavigationBarWidget,
    this.isAppBar = true,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget bodyWidget;
  final Widget? bottomNavigationBarWidget;
  bool isAppBar;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: isAppBar ? appBar ?? getAppBar(context) : null,
      body: appBar != null ? bodyWidget : SafeArea(child: bodyWidget),
      bottomNavigationBar:
          bottomNavigationBarWidget ?? getBottomNavigationBarWidget(context),
    );
  }

  PreferredSizeWidget getAppBar(context) {
    return AppBar(
      leading: MText(
        text: AppStrings.alBakriFurniture,
        style: getBoldStyle(
          color: ColorManager.primary,
          fontSize: AppSize.s20,
        ),
      ),
      leadingWidth: AppSize.s180,
      actions: [
        ElevatedButton(
          onPressed: () {
            navigateTo(context, const AdvancedSearchScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
          ),
          child: Icon(
            Icons.search,
            color: ColorManager.darkPrimary,
            size: AppSize.s25,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
          ),
          child: Icon(
            Icons.notifications_active_rounded,
            color: ColorManager.darkPrimary,
            size: AppSize.s25,
          ),
        ),
      ],
    );
  }

  getBottomNavigationBarWidget(context) {
    return BottomNavigationBar(
      currentIndex: HomeLayoutCubit.get(context).currentIndex,
      onTap: (index) {
        HomeLayoutCubit.get(context).changeBottom(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: const DefaultIcon(path: IconsAssets.home),
          label: AppStrings.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: const DefaultIcon(path: IconsAssets.category),
          label: AppStrings.categories.tr(),
        ),
        BottomNavigationBarItem(
          icon: const DefaultIcon(path: IconsAssets.cart),
          label: AppStrings.cart.tr(),
        ),
        BottomNavigationBarItem(
          icon: const DefaultIcon(path: IconsAssets.profile),
          label: AppStrings.profile.tr(),
        ),
      ],
    );
  }
}
