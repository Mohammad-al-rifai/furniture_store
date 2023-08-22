// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/local/cache_helper.dart';
import 'package:ecommerce/data/network/local/keys.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ServerIPScreen extends StatefulWidget {
  const ServerIPScreen({super.key});

  @override
  State<ServerIPScreen> createState() => _ServerIPScreenState();
}

class _ServerIPScreenState extends State<ServerIPScreen> {
  TextEditingController serverIPController = TextEditingController();

  var ipKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppPadding.p8),
          child: Constants.serverIP.isEmpty ? setNewIP() : changeIP(),
        ),
      ),
    );
  }

  Widget setNewIP() {
    return Form(
      key: ipKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TFF(
            controller: serverIPController,
            label: 'E.g. 192.168.0.1',
            prefixIcon: Icons.wifi_sharp,
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (isValidIPAddress(value)) {
                print('True');
              } else {
                return 'Not valid';
              }
            },
          ),
          SizedBox(height: AppSize.s12),
          DefaultButton(
            function: () {
              if (ipKey.currentState!.validate()) {
                print('Valid');
                CacheHelper.saveData(
                  key: CacheHelperKeys.serverIP,
                  value: serverIPController.text,
                ).then((value) {
                  Constants.serverIP = serverIPController.text;
                  Urls.baseUrl = 'http://${serverIPController.text}:3000';
                  DioHelper.init();
                  print('Your Server IP is : ${Constants.serverIP}');
                  print('Your Base URL : ${Urls.baseUrl}');
                  navigateAndFinish(context, const SplashScreen());
                });
              }
            },
            text: AppStrings.submit.tr(),
          ),
        ],
      ),
    );
  }

  Widget changeIP() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Server Ip Is: ${Constants.serverIP}'),
        SizedBox(height: AppSize.s8),
        DefaultButton(
          function: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: MText(
                  text: AppStrings.confirmationDeleting,
                ),
                content:
                    MText(text: AppStrings.areYouSureYouWant2DeleteServerIP),
                actions: [
                  DTextButton(
                    text: AppStrings.no.tr(),
                    function: () {
                      popScreen(context);
                    },
                  ),
                  DTextButton(
                    text: AppStrings.yes.tr(),
                    function: () async {
                      await CacheHelper.removeData(
                              key: CacheHelperKeys.serverIP)
                          .then((value) {
                        print('Removed Success');
                        Constants.serverIP = '';
                        Phoenix.rebirth(context);
                      });
                    },
                  ),
                ],
              ),
            );
          },
          text: AppStrings.delete,
        ),
      ],
    );
  }
}
