import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/order/user_orders_screen.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/settings_item_widget.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/user_widget.dart';
import 'package:ecommerce/presentation/screens/splash/server_ip_screen.dart';
import 'package:ecommerce/presentation/screens/wallet/user_wallet_points_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/assets_manager.dart';
import '../wishlist/wishlist_screen.dart';

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
      OrderCubit.get(context).getMyBalance();
    }
    super.initState();
  }

  String myBalance = '';

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
                  SizedBox(height: AppSize.s8),
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
                          onTap: () => handleMyWalletPress(),
                          iconPath: IconsAssets.wallet,
                          titleTR: AppStrings.myEWallet,
                          widget: Row(
                            children: [
                              BlocConsumer<OrderCubit, OrderStates>(
                                listener: (context, state) {
                                  if (state is GetMyBalanceDoneState) {
                                    setState(() {});
                                  }
                                },
                                builder: (context, state) {
                                  return MText(
                                    text: OrderCubit.get(context).myBalance,
                                    style:
                                        getBoldStyle(color: ColorManager.black),
                                  );
                                },
                              ),
                              SizedBox(width: AppSize.s4),
                              MText(
                                text: AppStrings.points,
                              ),
                            ],
                          ),
                        ),
                        SettingsItemWidget(
                          onTap: () => handleOrderHistoryPress(),
                          iconPath: IconsAssets.order,
                          titleTR: AppStrings.orderHistory,
                        ),
                        SettingsItemWidget(
                          onTap: () => handleWishlistPress(),
                          iconPath: IconsAssets.wishlist,
                          titleTR: AppStrings.wishlist,
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
                          onTap: () {
                            handleIPConfig();
                          },
                          iconPath: IconsAssets.ip,
                          titleTR: AppStrings.serverIp,
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
      // Phoenix.rebirth(context);
    });
  }

// 2. handle Order History Press:
  handleOrderHistoryPress() {
    navigateTo(context, const UserOrderScreen());
  }

  // 3. handle Wishlist Press
  handleWishlistPress() {
    navigateTo(context, const WishlistScreen());
  }

  // 4. handle IPConfig
  handleIPConfig() {
    navigateTo(context, const ServerIPScreen());
  }

  // 5. handle myWallet Press
  handleMyWalletPress() {
    navigateTo(context, const UserWalletPointsScreen());
  }
}
