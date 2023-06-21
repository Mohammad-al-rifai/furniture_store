import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class Login2AccountWidget extends StatelessWidget {
  const Login2AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MText(
            text: AppStrings.loginNow2YourAccount,
          ),
          DefaultButton(
            function: () {
              navigateTo(context, const LoginScreen());
            },
            text: AppStrings.login.tr(),
            width: 90.0,
          ),
        ],
      ),
    );
  }
}
