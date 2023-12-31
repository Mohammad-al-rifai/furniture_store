import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/presentation/components/default_image.dart';
import 'package:ecommerce/presentation/components/my_page_view.dart';
import 'package:ecommerce/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryWidget extends StatelessWidget {
  GalleryWidget({
    Key? key,
    required this.mainImageUrl,
  }) : super(key: key);

  final String? mainImageUrl;

  final PageController galleryController = PageController();

  final double galleryHeight = AppSize.s260;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductCubit cubit = ProductCubit.get(context);
        if (state is GetProductGalleryDoneState || cubit.gallery.isNotEmpty) {
          return MyPageView(
            controller: galleryController,
            height: galleryHeight,
            pageWidget: (context, index) {
              if (index == 0) {
                return buildMainImage(context);
              } else if (index == cubit.gallery.length + 1 &&
                  cubit.videoUrl.isNotEmpty) {
                return VideoWidget(
                  videoUrl: cubit.videoUrl,
                );
              } else {
                return Hero(
                  tag: Urls.filesUrl + (cubit.gallery[index - 1] ?? ''),
                  child: DefaultImage(
                    imageUrl: cubit.gallery[index - 1],
                    clickable: true,
                    height: galleryHeight,
                  ),
                );
              }
            },
            itemCount: (cubit.videoUrl.isNotEmpty ? 1 : 0) +
                (1 + cubit.gallery.length),
          );
        } else {
          return buildMainImage(context);
        }
      },
    );
  }

  Widget buildMainImage(context) {
    return Hero(
      tag: mainImageUrl ?? '',
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          DefaultImage(
            imageUrl: mainImageUrl,
            clickable: true,
            fit: BoxFit.cover,
            height: galleryHeight,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsetsDirectional.all(AppMargin.m8),
              height: 40.0,
              width: 40.0,
              decoration: getDeco(withShadow: true, borderSize: AppSize.s8),
              child:  Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorManager.white,
                  size: AppSize.s25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
