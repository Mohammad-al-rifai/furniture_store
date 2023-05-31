import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../presentation/components/button.dart';
import '../presentation/components/my_text.dart';
import '../presentation/resources/assets_manager.dart';
import '../presentation/resources/color_manager.dart';
import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/string_manager.dart';
import '../presentation/resources/values_manager.dart';
import '../presentation/screens/login/login_screen.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void popScreen(context) => Navigator.of(context).pop();

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

getNameTr({
  required String? arName,
  required String? enName,
}) {
  if (Langs.isEN && enName != null) {
    return enName.isNotEmpty ? enName : arName;
  }
  if (!Langs.isEN && arName != null) {
    return arName.isNotEmpty ? arName : enName;
  }
}

getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

getDeco({
  bool withShadow = false,
  Color? color = ColorManager.primary,
  double borderSize = 0.0,
  DecorationImage? image,
}) {
  return BoxDecoration(
    color: color ?? ColorManager.primary,
    borderRadius: BorderRadiusDirectional.only(
      bottomEnd: Radius.circular(AppSize.s8),
      topEnd: Radius.circular(AppSize.s8),
      bottomStart: Radius.circular(borderSize),
      topStart: Radius.circular(borderSize),
    ),
    boxShadow: withShadow
        ? [
            const BoxShadow(
              color: ColorManager.darkPrimary,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.outer,
            ),
            const BoxShadow(
              color: ColorManager.darkPrimary,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.outer,
            ),
            const BoxShadow(
              color: ColorManager.error,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.outer,
            ),
          ]
        : [],
    image: image,
  );
}

String getRandomString(int length) {
  const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => ch.codeUnitAt(
        r.nextInt(ch.length),
      ),
    ),
  );
}

Color getRandomColor() {
  Random random = Random();
  int red = random.nextInt(256);
  int green = random.nextInt(256);
  int blue = random.nextInt(256);

  // Check for invalid values
  if (red.isNaN || red.isInfinite) red = 0;
  if (green.isNaN || green.isInfinite) green = 0;
  if (blue.isNaN || blue.isInfinite) blue = 0;

  return Color.fromARGB(
    255,
    red,
    green,
    blue,
  );
}

Widget handleFallBackWidget({
  List<dynamic>? list,
  required BuildContext context,
}) {
  if (Constants.token.isEmpty) {
    return Column(
      children: [
        Lottie.asset(JsonAssets.login),
        DefaultButton(
          function: () {
            navigateTo(
              context,
              const LoginScreen(),
            );
          },
          text: AppStrings.login,
        ),
      ],
    );
  } else {
    if (list != null && list.isEmpty) {
      return Lottie.asset(JsonAssets.empty);
    } else {
      return MText(
        text: AppStrings.somethingsErrorPleaseCheckYourInternet,
      );
    }
  }
}
