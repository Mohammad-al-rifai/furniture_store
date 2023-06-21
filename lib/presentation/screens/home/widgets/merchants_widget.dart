import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/auth_models/merchants_model.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/default_label.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class AllMerchantsWidget extends StatelessWidget {
  const AllMerchantsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.merchants.isNotEmpty,
          widgetBuilder: (context) {
            return Column(
              children: [
                SizedBox(height: AppSize.s8),
                const DefaultLabel(text: AppStrings.merchants),
                SizedBox(
                  height: AppSize.s60,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildMerchantItem(
                              context,
                              user: cubit.merchants[index],
                            );
                          },
                          itemCount: cubit.merchants.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          fallbackBuilder: (context) {
            return const DefaultLoading();
          },
        );
      },
    );
  }

  Widget buildMerchantItem(context, {MerchantUser? user}) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 4.0,
      ),
      child: GestureDetector(
        onTap: () {
          navigateTo(
            context,
            MerchantLayout(
              merchantUser: user,
            ),
          );
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s30),
            color: ColorManager.white,
            boxShadow: const [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 3.0,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: AppSize.s30,
            backgroundColor: ColorManager.white,
            child: DefaultImage(
              imageUrl: user?.marketLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
