import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/functions.dart';
import '../../../../data/network/local/cache_helper.dart';
import '../../../../data/network/local/keys.dart';
import '../../../../domain/models/auth_models/user_profile.dart';
import '../../../components/button.dart';
import '../../../components/loading.dart';
import '../../../components/my_text.dart';
import '../../../components/text_button.dart';
import '../../../components/toast_notifications.dart';
import '../../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../login/login_screen.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {
        if (state is LogoutDoneState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);

          // Remove Token;
          CacheHelper.removeData(key: CacheHelperKeys.token).then((value) {
            Constants.token = "";
          });

          // Remove Full Name;
          CacheHelper.removeData(key: CacheHelperKeys.fullName).then((value) {
            Constants.fullName = "";
          });

          // Remove email;
          CacheHelper.removeData(key: CacheHelperKeys.email).then((value) {
            Constants.email = "";
          });
          // Remove uId;
          CacheHelper.removeData(key: CacheHelperKeys.uId).then(
            (value) {
              Constants.uId = "";
            },
          );
          setState(() {
            login2AccountWidget();
          });
        }
      },
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              padding: const EdgeInsetsDirectional.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: ColorManager.lightPrimary.withOpacity(.5),
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(JsonAssets.login),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (Constants.token.isEmpty || state is LogoutDoneState)
                    login2AccountWidget()
                  else
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! GetProfileLoadingState,
                      widgetBuilder: (BuildContext context) {
                        return userData(
                          userInfo: cubit.userProfileModel.data?.user,
                        );
                      },
                      fallbackBuilder: (BuildContext context) {
                        return const DefaultLoading();
                      },
                    ),
                ],
              ),
            ),
            if (Constants.token.isNotEmpty && state is! LogoutDoneState)
              logoutWidget()
            else
              const SizedBox(),
          ],
        );
      },
    );
  }

  Widget login2AccountWidget() {
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

  Widget logoutWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
                listener: (context, state) {
                  if (state is LogoutDoneState) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
                  return AlertDialog(
                    title: MText(
                      text: AppStrings.confirmationLogout,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MText(
                          text: AppStrings.areYouSureYouWantToLogout,
                        ),
                        state is LogoutLoadingState
                            ? const DefaultLoading()
                            : Container(),
                        state is LogoutErrorState
                            ? MText(
                                text: AppStrings
                                    .somethingsErrorPleaseCheckYourInternet,
                                maxLines: 2,
                              )
                            : Container()
                      ],
                    ),
                    actions: [
                      DTextButton(
                        text: AppStrings.yes.tr(),
                        function: () {
                          cubit.logout();
                          setState(() {});
                        },
                      ),
                      DTextButton(
                        text: AppStrings.no.tr(),
                        function: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MText(
              text: AppStrings.logout,
              style: getRegularStyle(
                  color: ColorManager.white, fontSize: AppSize.s8),
            ),
            const SizedBox(
              width: AppSize.s4,
            ),
            const Icon(
              Icons.logout,
              color: ColorManager.white,
              size: AppSize.s16,
            ),
          ],
        ),
      ),
    );
  }

  Widget userData({
    UserInfo? userInfo,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            text: userInfo?.fullName ??
                CacheHelper.getData(key: CacheHelperKeys.fullName),
            color: ColorManager.darkPrimary,
          ),
          MText(
            text: userInfo?.email ??
                CacheHelper.getData(key: CacheHelperKeys.email),
            color: ColorManager.darkPrimary,
          ),
        ],
      ),
    );
  }
}
