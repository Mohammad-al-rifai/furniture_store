import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/app/languages.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/gallery_widget.dart';
import 'package:ecommerce/presentation/screens/merchant/products/vr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../../domain/models/product_models/merchant_products_model.dart';
import '../../../cubit/product_cubit/product_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final MerchantProduct? product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GalleryWidget(product: widget.product),
                    const SizedBox(
                      height: AppSize.s4,
                    ),
                    MText(
                      text: widget.product?.mainCategorie ??
                          'mainCategorie empty!',
                    ),
                    cubit.vrUrl.isNotEmpty
                        ? DefaultButton(
                            function: () {
                              navigateTo(
                                context,
                                VRScreen(
                                  name: 'GLP',
                                  modelUrl: cubit.vrUrl,
                                ),
                              );
                            },
                            text: 'VR mode')
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
