import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/components/my_divider.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/order/user_orders_screen.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/old_language_widget.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/settings_item_widget.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/assets_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    if (Constants.token.isNotEmpty) {
      HomeLayoutCubit.get(context).getProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      isAppBar: false,
      bodyWidget: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(AppPadding.p8),
              child: Column(
                children: [
                  const UserWidget(),
                  const SizedBox(height: AppSize.s8),
                  Container(
                    margin: const EdgeInsetsDirectional.all(AppMargin.m8),
                    padding: const EdgeInsetsDirectional.all(AppPadding.p12),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius:
                          BorderRadiusDirectional.circular(AppSize.s8),
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
                        SettingsItemWidget(
                          onTap: () {},
                          iconPath: IconsAssets.payment,
                          titleTR: AppStrings.paymentMethod,
                        ),
                        SettingsItemWidget(
                          onTap: () => handleOrderHistoryPress(),
                          iconPath: IconsAssets.order,
                          titleTR: AppStrings.orderHistory,
                        ),
                        SettingsItemWidget(
                          onTap: () => handleLangPress(),
                          iconPath: IconsAssets.language,
                          titleTR: AppStrings.appLanguage,
                          isLang: true,
                          withDivider: false,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.all(AppMargin.m8),
                    padding: const EdgeInsetsDirectional.all(AppPadding.p12),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius:
                          BorderRadiusDirectional.circular(AppSize.s8),
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
                        SettingsItemWidget(
                          onTap: () {},
                          iconPath: IconsAssets.notifications,
                          titleTR: AppStrings.notificationsSettings,
                        ),
                        SettingsItemWidget(
                          onTap: () {},
                          iconPath: IconsAssets.privacy,
                          titleTR: AppStrings.privacyPolicy,
                        ),
                        SettingsItemWidget(
                          onTap: () {},
                          iconPath: IconsAssets.star,
                          titleTR: AppStrings.rateOurApp,
                          withDivider: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Functions:

// 1. handle Language Press:
  handleLangPress() {
    Langs.changeLang(context);
    setState(() {
      Phoenix.rebirth(context);
    });
  }

// 2. handle Order History Press:
  handleOrderHistoryPress() {
    navigateTo(context, const UserOrderScreen());
  }
}
