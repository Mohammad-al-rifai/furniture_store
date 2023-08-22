import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/screens/register/register_cubit/register_cubit.dart';
import 'package:ecommerce/presentation/screens/splash/server_ip_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/cubit/order_cubit/order_cubit.dart';
import '../presentation/cubit/wishlist_cubit/wishlist_cubit.dart';
import '../presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../presentation/resources/theme_manager.dart';
import '../presentation/screens/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  // named Constructor

  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // Singleton or Single Instance.

  factory MyApp() => _instance; //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(
          create: (BuildContext context) => HomeLayoutCubit()..fetchData(),
        ),
        BlocProvider(create: (BuildContext context) => MerchantLayoutCubit()),
        BlocProvider(create: (BuildContext context) => CartCubit()),
        BlocProvider(
            create: (BuildContext context) => OrderCubit()..getMyBalance()),
        BlocProvider(
          create: (BuildContext context) => WishlistCubit()..getMyWishlist(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(getScreenWidth(context), getScreenHeight(context)),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          ScreenUtil.init(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Constants.serverIP.isEmpty
                ? ServerIPScreen()
                : const SplashScreen(),
          );
        },
      ),
    );
  }
}
