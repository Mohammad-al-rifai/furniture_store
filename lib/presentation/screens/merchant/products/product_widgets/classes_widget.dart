// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/presentation/components/my_page_view.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../../../app/functions.dart';
import '../../../../../domain/models/product_models/single_pro_model.dart';
import '../../../../components/default_element.dart';
import '../../../../components/my_text.dart';
import '../../../../cubit/product_cubit/product_cubit.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/fonts_manager.dart';
import '../../../../resources/string_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import 'add_2_cart_widget.dart';

class ClassesWidget extends StatefulWidget {
  const ClassesWidget({
    Key? key,
    this.proClasses,
    this.proId,
  }) : super(key: key);

  final List<SingleProClass>? proClasses;
  final String? proId;

  @override
  State<ClassesWidget> createState() => _ClassesWidgetState();
}

class _ClassesWidgetState extends State<ClassesWidget> {
  double classesHeight = AppSize.s150;

  var classPageController = PageController();

  int groupSelectedIndex = 0;
  String? groupId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DefaultLabel(text: AppStrings.classes),
            MyPageView(
              height: 280.0,
              controller: classPageController,
              pageWidget: (context, index) => buildClassItem(index),
              itemCount: widget.proClasses?.length ?? 0,
            ),
          ],
        );
      },
    );
  }

  Widget buildClassItem(index) {
    return Card(
      margin: const EdgeInsetsDirectional.all(AppMargin.m8),
      child: Container(
        decoration: getDeco(withShadow: true, color: ColorManager.white),
        margin: const EdgeInsetsDirectional.all(AppMargin.m8),
        padding: const EdgeInsetsDirectional.all(AppPadding.p12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.proClasses?[index].priceAfterDiscount != null
                    ? offerWidget(
                        price1: widget.proClasses?[index].price.toString(),
                        price2: widget.proClasses?[index].priceAfterDiscount
                            .toString(),
                      )
                    : PairWidget(
                        label: AppStrings.classPrice,
                        value: widget.proClasses?[index].price.toString(),
                        notTR: true,
                      ),
                PairWidget(
                  label: AppStrings.classSize,
                  value: widget.proClasses?[index].size,
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.classLength,
                  value: widget.proClasses?[index].length.toString(),
                  notTR: true,
                ),
                PairWidget(
                  label: AppStrings.classWidth,
                  value: widget.proClasses?[index].width.toString(),
                  notTR: true,
                ),
                colorsWidget(widget.proClasses?[index].group, index),
                Add2CartWidget(
                  productId: widget.proId,
                  classId: widget.proClasses?[index].id,
                  groupId: groupId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorsWidget(List<SingleProGroup>? groups, classIndex) {
    groupId = groups?[groupSelectedIndex].id;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p8),
      child: SizedBox(
        height: 40.0,
        child: Row(
          children: [
            MText(
              text: AppStrings.existColors,
              color: ColorManager.black,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Conditional.single(
                  context: context,
                  conditionBuilder: (context) => index == groupSelectedIndex,
                  widgetBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppPadding.p4),
                      child: DottedBorder(
                        color: ColorManager.darkPrimary,
                        borderPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(AppSize.s4),
                        child: buildColorItem(index, groups),
                      ),
                    );
                  },
                  fallbackBuilder: (context) {
                    return buildColorItem(index, groups);
                  },
                ),
                itemCount: widget.proClasses?[classIndex].group.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorItem(int index, List<SingleProGroup>? groups) {
    return GestureDetector(
      onTap: () {
        setState(() {
          groupSelectedIndex = index;
          groupId = groups?[index].id;
        });
      },
      child: Container(
        height: 30.0,
        width: 30.0,
        margin: const EdgeInsetsDirectional.all(AppMargin.m4),
        decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
        ),
      ),
    );
  }

  Widget offerWidget({
    required String? price1,
    required String? price2,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: MText(
              text: AppStrings.offers,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: ColorManager.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: AppMargin.m4,
              end: AppMargin.m8,
            ),
            width: 2.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  price1 ?? '',
                  style: TextStyle(
                    fontSize: AppSize.s12,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.85,
                    color: ColorManager.error,
                    fontWeight: FontWeightManager.light,
                  ),
                ),
                SizedBox(width: AppSize.s8),
                Text(
                  price2 ?? '',
                  style: TextStyle(
                    fontSize: AppSize.s18,
                    color: ColorManager.success,
                    fontWeight: FontWeightManager.extraBold,
                  ),
                ),
                SizedBox(width: AppSize.s4),
                Expanded(
                  child: MText(
                    text: AppStrings.sp,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.darkPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
