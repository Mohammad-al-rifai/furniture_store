import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/ar_vr_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/classes_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/delivery_area_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/gallery_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/pair_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/default_element.dart';
import '../../../cubit/product_cubit/product_cubit.dart';
import '../../../resources/string_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.proId,
    required this.mainImageUrl,
  }) : super(key: key);

  final String? proId;
  final String? mainImageUrl;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    productId = widget.proId;
  }

  String? productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..getSinglePro(proId: widget.proId ?? '')
        ..getProductGallery(proId: widget.proId ?? '')
        ..getVideoOfProduct(proId: widget.proId ?? '')
        ..getVR(proId: widget.proId ?? '')
        ..getAR(proId: widget.proId ?? ''),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductCubit cubit = ProductCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:  EdgeInsetsDirectional.only(
                    bottom: AppSize.s25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GalleryWidget(
                        mainImageUrl: widget.mainImageUrl,
                      ),
                       SizedBox(height: AppSize.s8),
                      buildTitleWidget(cubit),
                      ClassesWidget(
                        proClasses: cubit.product.productClass,
                        proId: cubit.product.id,
                      ),
                       SizedBox(height: AppSize.s8),
                      buildMainDescription(cubit),
                      DeliveryAreaWidget(
                        areas: cubit.product.deliveryAreas,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTitleWidget(ProductCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
      ),
      child: Row(
        children: [
          Expanded(
            child: MText(
              text: cubit.product.name ?? '',
              notTR: true,
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: AppSize.s18,
              ),
            ),
          ),
          Expanded(child: ArVRWidget(cubit: cubit)),
        ],
      ),
    );
  }

  Widget buildMainDescription(ProductCubit cubit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DefaultLabel(text: AppStrings.mainDescriptions),
         SizedBox(height: AppSize.s8),
        PairWidget(
          label: AppStrings.productName,
          value: cubit.product.name,
          notTR: true,
        ),
        PairWidget(
          label: AppStrings.mainCategory,
          value: cubit.product.mainCategorie,
          notTR: true,
        ),
        PairWidget(
          label: AppStrings.ownerName,
          value: cubit.product.ownerId?.fullName,
          notTR: true,
        ),
        PairWidget(
          label: AppStrings.guarantee,
          value: cubit.product.guarantee.toString(),
          notTR: true,
        ),
        PairWidget(
          label: AppStrings.manufacturingMaterial,
          value: cubit.product.manufacturingMaterial,
          notTR: true,
        ),
        PairWidget(
          label: AppStrings.description,
          value: cubit.product.descreption,
          notTR: true,
        ),
      ],
    );
  }
}
