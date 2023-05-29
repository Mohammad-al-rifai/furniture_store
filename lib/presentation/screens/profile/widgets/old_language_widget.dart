import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../../app/languages.dart';
import '../../../components/my_text.dart';
import '../../../components/toast_notifications.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class OldLanguageWidget extends StatefulWidget {
  const OldLanguageWidget({Key? key}) : super(key: key);

  @override
  State<OldLanguageWidget> createState() => _OldLanguageWidgetState();
}

class _OldLanguageWidgetState extends State<OldLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return languageSettings();
  }

  Decoration getDeco({Color? color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: color,
    );
  }

  Widget languageSettings() {
    return Row(
      children: [
        const SizedBox(
          width: 4.0,
        ),
        MText(text: AppStrings.appLanguage),
        const SizedBox(
          width: AppSize.s12,
        ),
        DottedBorder(
          radius: const Radius.circular(AppSize.s8),
          color: ColorManager.darkPrimary,
          borderType: BorderType.RRect,
          child: Container(
            decoration: getDeco(),
            width: 140.0,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: getDeco(
                    color:
                        Langs.isEN ? ColorManager.white : ColorManager.primary,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (Langs.isEN) {
                        Langs.changeLang(context);
                        setState(() {
                          Phoenix.rebirth(context);
                        });
                      } else {
                        showToast(
                          text: 'الوضع الحالي هو العربية!',
                          state: ToastStates.WARNING,
                        );
                      }
                    },
                    child: MText(
                      text: AppStrings.arabic,
                      style: getBoldStyle(
                        color: Langs.isEN
                            ? ColorManager.primary
                            : ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: getDeco(
                    color:
                        Langs.isEN ? ColorManager.primary : ColorManager.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (!Langs.isEN) {
                        Langs.changeLang(context);
                        setState(() {
                          Phoenix.rebirth(context);
                        });
                      } else {
                        showToast(
                          text: 'You are already in English Mode',
                          state: ToastStates.WARNING,
                        );
                      }
                    },
                    child: MText(
                      text: AppStrings.english,
                      style: getBoldStyle(
                        color: Langs.isEN
                            ? ColorManager.white
                            : ColorManager.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
