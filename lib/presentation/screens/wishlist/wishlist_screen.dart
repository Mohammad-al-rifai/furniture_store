import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/wishlist_models/wishlist_model.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/default_dismissable.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/error.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/login/login_screen.dart';
import 'package:ecommerce/presentation/screens/merchant/products/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    if (Constants.token.isNotEmpty) {
      WishlistCubit.get(context).getMyWishlist();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.wishlist),
        actions: [
          Constants.token.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: MText(text: AppStrings.deleteYourWishlist),
                        content: MText(
                            text: AppStrings
                                .areYouSureYouWant2DeleteYourWishlist),
                        actions: [
                          DTextButton(
                            text: AppStrings.no.tr(),
                            function: () {
                              popScreen(context);
                            },
                          ),
                          BlocConsumer<WishlistCubit, WishlistStates>(
                            listener: (context, state) {
                              if (state is DeleteMyWishlistDoneState) {
                                popScreen(context);
                              }
                            },
                            builder: (context, state) {
                              return DTextButton(
                                text: AppStrings.yes.tr(),
                                function: () {
                                  WishlistCubit.get(context).deleteMyWishlist();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                    color: ColorManager.error,
                  ),
                )
              : Container(),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => Constants.token.isNotEmpty,
      widgetBuilder: (context) => myWishlistContent(),
      fallbackBuilder: (context) => handleFallBackWidget(context: context),
    );
  }

  Widget myWishlistContent() {
    return BlocConsumer<WishlistCubit, WishlistStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WishlistCubit cubit = WishlistCubit.get(context);
        if (state is GetMyWishlistLoadingState) {
          return const DefaultLoading();
        }
        if (state is YouHaveNotWishlistState) {
          return Center(
            child: Column(
              children: [
                Lottie.asset(JsonAssets.emptyWishlist),
                MText(
                  text: AppStrings.youHaveNotWishlistNow,
                ),
              ],
            ),
          );
        }
        if (state is GetMyWishlistErrorState) {
          return const DefaultError();
        }
        if (state is GetMyWishlistDoneState) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                cubit.wishlistModel.data!.products.isNotEmpty,
            widgetBuilder: (context) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildWishlistProduct(product: cubit.myProducts[index]);
              },
              itemCount: cubit.myProducts.length,
            ),
            fallbackBuilder: (context) => Lottie.asset(JsonAssets.empty),
          );
        }
        return Container();
      },
    );
  }

  Widget userNotLoggedIn() {
    return Column(
      children: [
        Lottie.asset(JsonAssets.login),
        DefaultButton(
          function: () {
            navigateTo(context, const LoginScreen());
          },
          text: AppStrings.login.tr(),
        ),
      ],
    );
  }

  Widget buildWishlistProduct({required WishlistProduct product}) {
    return DefaultDismissible(
      function: () {
        WishlistCubit.get(context)
            .removeProFromWishlist(proId: product.productId?.id ?? '');
      },
      widget: InkWell(
        onTap: () {
          navigateTo(
            context,
            DetailsScreen(
              proId: product.productId?.id,
              mainImageUrl: product.productId?.mainImage,
            ),
          );
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: AppSize.s200,
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
            boxShadow: [
              BoxShadow(
                color: ColorManager.lightGrey,
                blurRadius: AppSize.s12,
              ),
            ],
          ),
          child: DefaultImage(
            imageUrl: product.productId?.mainImage,
          ),
        ),
      ),
    );
  }
}
