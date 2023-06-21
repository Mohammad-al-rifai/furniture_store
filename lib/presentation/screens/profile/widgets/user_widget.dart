import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/data/network/local/cache_helper.dart';
import 'package:ecommerce/data/network/local/keys.dart';
import 'package:ecommerce/domain/models/auth_models/user_profile.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/login/login_screen.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/login_2_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';

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
            const Login2AccountWidget();
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
                gradient: LinearGradient(
                  colors: [
                    ColorManager.lightPrimary.withOpacity(.2),
                    ColorManager.lightPrimary.withOpacity(.2),
                    ColorManager.lightPrimary.withOpacity(.2),
                    ColorManager.lightPrimary.withOpacity(.5),
                    ColorManager.lightPrimary.withOpacity(.5),
                    ColorManager.lightPrimary.withOpacity(.5),
                    ColorManager.lightPrimary.withOpacity(.7),
                    ColorManager.lightPrimary.withOpacity(.8),
                    ColorManager.lightPrimary.withOpacity(.9),
                    ColorManager.lightPrimary.withOpacity(.9),
                    ColorManager.lightPrimary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.lightPrimary.withOpacity(.3),
                    blurRadius: 3.0,
                  ),
                ],
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
                    const Login2AccountWidget()
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
            SizedBox(
              width: AppSize.s4,
            ),
            Icon(
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
