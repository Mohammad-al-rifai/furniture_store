import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/local/keys.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';
import 'data/network/local/cache_helper.dart';
import 'data/network/remote/dio_helper.dart';

void main() async {
  print("Start Main");
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();

  Langs.isEN = CacheHelper.getData(key: CacheHelperKeys.isEN) ?? true;
  Constants.token = CacheHelper.getData(key: CacheHelperKeys.token) ?? "";
  Constants.serverIP = CacheHelper.getData(key: CacheHelperKeys.serverIP) ?? "";
  DioHelper.init();
  print(Constants.serverIP);
  print(Urls.baseUrl);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      startLocale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
  print("End Main");
}
