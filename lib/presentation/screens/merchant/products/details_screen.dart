import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/default_element.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_divider.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/gallery_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/vr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../../domain/models/product_models/merchant_products_model.dart';
import '../../../../domain/models/product_models/single_pro_model.dart';
import '../../../cubit/product_cubit/product_cubit.dart';
import '../../../resources/string_manager.dart';
import 'my_container.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    this.proId,
  }) : super(key: key);

  final MerchantProduct? product;
  final String? proId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    productId = widget.product?.id;
  }

  int classSelectedIndex = 0;
  int groupSelectedIndex = 0;
  bool isContainerExpanded = false;

  double width = 320.0;
  double height = 210.0;
  Color color = ColorManager.primary;

  // For Add Product 2 Cart:

  String? productId;
  String? classId;
  String? groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..getSinglePro(proId: widget.product?.id ?? '')
        ..getProductGallery(proId: widget.product?.id ?? '')
        ..getVideoOfProduct(proId: widget.product?.id ?? '')
        ..getVR(proId: widget.product?.id ?? '')
        ..getAR(proId: widget.product?.id ?? ''),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductCubit cubit = ProductCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(bottom: AppSize.s25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GalleryWidget(product: widget.product),
                      const SizedBox(height: AppSize.s4),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) => cubit.product.id != null,
                        widgetBuilder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildArVr(context, cubit),
                              const SizedBox(height: AppSize.s8),
                              PairWidget(
                                label: AppStrings.productId,
                                value: cubit.product.id,
                              ),
                              PairWidget(
                                label: AppStrings.productName,
                                value: cubit.product.name,
                              ),
                              PairWidget(
                                label: AppStrings.description,
                                value: cubit.product.descreption,
                              ),
                              PairWidget(
                                label: AppStrings.mainCategory,
                                value: cubit.product.mainCategorie,
                              ),
                              PairWidget(
                                label: AppStrings.productName,
                                value: cubit.product.name,
                              ),
                              PairWidget(
                                label: AppStrings.ownerName,
                                value: cubit.product.ownerId?.fullName,
                              ),
                              PairWidget(
                                label: AppStrings.guarantee,
                                value: cubit.product.guarantee.toString(),
                              ),
                              PairWidget(
                                label: AppStrings.manufacturingMaterial,
                                value: cubit.product.manufacturingMaterial,
                              ),
                              const DefaultLabel(text: AppStrings.classes),
                              buildClasses(
                                proClasses: cubit.product.productClass,
                              ),
                              buildDeliveryAreas(
                                areas: cubit.product.deliveryAreas,
                              ),
                            ],
                          );
                        },
                        fallbackBuilder: (context) {
                          return const DefaultLoading();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: buildNavBar(
                productId: productId, classId: classId, groupId: groupId),
          );
        },
      ),
    );
  }

  Widget buildArVr(context, ProductCubit cubit) {
    return SizedBox(
      height: AppSize.s40,
      child: Row(
        children: [
          cubit.vrUrl.isNotEmpty
              ? Expanded(
                  child: DefaultButton(
                    function: () {
                      navigateTo(
                        context,
                        VRScreen(
                          name: 'GLP',
                          modelUrl: cubit.vrUrl,
                        ),
                      );
                    },
                    text: AppStrings.vrMode.tr(),
                  ),
                )
              : Container(),
          cubit.arUrl.isNotEmpty
              ? Expanded(
                  child: DefaultButton(
                    function: () {
                      navigateTo(
                        context,
                        VRScreen(
                          name: 'GLP',
                          modelUrl: cubit.arUrl,
                        ),
                      );
                    },
                    text: AppStrings.arMode.tr(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildClasses({required List<SingleProClass>? proClasses}) {
    classId = proClasses?[classSelectedIndex].id;
    groupId = proClasses?[classSelectedIndex].group[groupSelectedIndex].id;

    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (isContainerExpanded) {
                width = getScreenWidth(context) * 1.1;
                isContainerExpanded = false;
              } else {
                width = 320.0;
                isContainerExpanded = true;
              }
              setState(() {});
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                AnimatedContainer(
                  width: width,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    decoration:
                        getDeco(withShadow: true, color: ColorManager.white),
                    margin: const EdgeInsetsDirectional.all(AppMargin.m8),
                    padding: const EdgeInsetsDirectional.all(AppPadding.p4),
                    height: height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PairWidget(
                            label: AppStrings.classId,
                            value: proClasses?[index].id,
                          ),
                          PairWidget(
                            label: AppStrings.classSize,
                            value: proClasses?[index].size,
                          ),
                          PairWidget(
                            label: AppStrings.classPrice,
                            value: proClasses?[index].price.toString(),
                          ),
                          PairWidget(
                            label: AppStrings.classLength,
                            value: proClasses?[index].length.toString(),
                          ),
                          PairWidget(
                            label: AppStrings.priceAfterDiscount,
                            value: proClasses?[index]
                                .priceAfterDiscount
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      classSelectedIndex = index;
                    });
                  },
                  icon: Icon(
                    index == classSelectedIndex
                        ? Icons.check_circle_outlined
                        : Icons.circle_outlined,
                    color: ColorManager.darkPrimary,
                    size: AppSize.s30,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: IconButton(
                    onPressed: () {
                      handleColorsPress(context, proClasses?[index].group);
                    },
                    icon: const Icon(
                      Icons.color_lens_outlined,
                      color: ColorManager.primary,
                      size: AppSize.s30,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: proClasses?.length ?? 0,
      ),
    );
  }

  Widget buildDeliveryAreas({required List<SingleProDeliveryArea>? areas}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DefaultLabel(text: AppStrings.deliveryAreas),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.delivery_dining_rounded,
                  color: ColorManager.primary,
                ),
                title: MText(text: areas?[index].location ?? ''),
                trailing:
                    MText(text: areas?[index].deliveryPrice.toString() ?? ''),
              ),
            );
          },
          itemCount: areas?.length,
        )
      ],
    );
  }

  handleColorsPress(context, List<SingleProGroup>? groups) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsetsDirectional.all(AppPadding.p8),
        icon: const Icon(
          Icons.color_lens_outlined,
          color: ColorManager.darkPrimary,
          size: AppSize.s40,
        ),
        alignment: AlignmentDirectional.center,
        title: MText(
          text: AppStrings.existColors,
          textAlign: TextAlign.center,
          style: getBoldStyle(
            color: ColorManager.primary,
          ),
        ),
        content: SizedBox(
          height: height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  groupSelectedIndex = index;
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.all(AppMargin.m8),
                      decoration: getDeco(
                        color: ColorManager.white,
                        withShadow: true,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PairWidget(
                            label: AppStrings.color,
                            value: groups?[index].color,
                          ),
                          PairWidget(
                            label: AppStrings.quantity,
                            value: groups?[index].quantity.toString(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      child: Icon(
                        index == groupSelectedIndex
                            ? Icons.check_circle_outlined
                            : Icons.circle_outlined,
                        size: AppSize.s30,
                        color: ColorManager.darkPrimary,
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: groups?.length,
          ),
        ),
      ),
    );
  }

  Widget buildNavBar({
    required String? productId,
    required String? classId,
    required String? groupId,
  }) {
    return Container(
      decoration: getDeco(
        borderSize: AppSize.s8,
        withShadow: true,
        color: ColorManager.white,
      ),
      height: AppSize.s50,
      margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppMargin.m8, vertical: AppMargin.m8),
      child: Row(
        children: [
          Expanded(
            child: BlocConsumer<CartCubit, CartStates>(
              listener: (context, state) {
                if (state is Add2CartDoneState) {
                  showToast(
                    text: 'Product Added Done✔️',
                    state: ToastStates.SUCCESS,
                  );
                }
                if (state is Add2CartErrorState) {
                  showToast(
                    text: 'Please Check Your Account',
                    state: ToastStates.WARNING,
                  );
                }
              },
              builder: (context, state) {
                CartCubit cubit = CartCubit.get(context);
                return DefaultButton(
                  text: AppStrings.add2Cart.tr(),
                  function: () {
                    print('ProducyId: $productId');
                    print('ClassId: $classId');
                    print('GroupId: $groupId');
                    cubit.add2Cart(
                      productId: productId ?? '',
                      classId: classId ?? '',
                      groupId: groupId ?? '',
                      quantity: 1,
                    );
                  },
                  isLoading: state is Add2CartLoadingState,
                );
              },
            ),
          ),
          const SizedBox(width: AppSize.s4),
          Expanded(
            child: DefaultButton(
              text: AppStrings.buyNow.tr(),
              function: () {},
            ),
          ),
        ],
      ),
    );
  }
}
