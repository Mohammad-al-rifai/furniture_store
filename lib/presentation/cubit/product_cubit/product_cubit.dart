import 'package:ecommerce/domain/models/product_models/ar_model.dart';
import 'package:ecommerce/domain/models/product_models/single_pro_model.dart';
import 'package:ecommerce/domain/models/product_models/video_model.dart';
import 'package:ecommerce/domain/models/product_models/vr_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/urls.dart';
import '../../../data/network/remote/dio_helper.dart';
import '../../../domain/models/product_models/product_galery_model.dart';

part 'product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  // Start Variable Here:
  int classSelectedIndex = 0;
  int groupSelectedIndex = 0;

  // For Add Product 2 Cart:
  String? classId;
  String? groupId;

  // End Variable Here.

  // get Single Product:
  SingleProModel singleProModel = SingleProModel();
  SingleProduct product = SingleProduct();

  getSinglePro({
    required String proId,
  }) {
    emit(GetSingleProLoadingState());
    DioHelper.instance.getData(
      url: Urls.getSinglePro + proId,
    ).then((value) {
      if (value.data['status']) {
        singleProModel = SingleProModel.fromJson(value.data);
        if (singleProModel.data?.product != null) {
          product = singleProModel.data!.product!;
        }
        emit(GetSingleProDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetSingleProErrorState());
    });
  }

  // get product Gallery:
  ProductGalleryModel productGalleryModel = ProductGalleryModel();
  List<String> gallery = [];

  getProductGallery({
    required String proId,
  }) {
    emit(GetProductGalleryLoadingState());

    if (gallery.isNotEmpty) {
      emit(GetProductGalleryDoneState());
    } else {
      DioHelper.instance.getData(
        url: Urls.getGalleryProduct + proId,
      ).then((value) {
        productGalleryModel = ProductGalleryModel.fromJson(value.data);
        if (value.data['status']) {
          if (productGalleryModel.data?.gallery?.gallery != null) {
            if (productGalleryModel.data!.gallery!.gallery!.isNotEmpty) {
              gallery = productGalleryModel.data!.gallery!.gallery!;
              emit(GetProductGalleryDoneState());
            }
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetProductGalleryErrorState());
      });
    }
  }

  // Get Video of Product:
  VideoModel? videoModel = VideoModel();
  String videoUrl = '';

  getVideoOfProduct({
    required String proId,
  }) {
    emit(GetProductVideoLoadingState());

    DioHelper.instance.getData(
      url: Urls.getVideo4Product + proId,
      query: {"mainVideo": "1"},
    ).then((value) {
      if (value.data['status']) {
        videoModel = VideoModel.fromJson(value.data);
        if (videoModel?.data?.video?.mainVideo != null) {
          if (videoModel!.data!.video!.mainVideo!.isNotEmpty) {
            videoUrl = videoModel!.data!.video!.mainVideo!;
            emit(GetProductVideoDoneState());
          }
        } else {
          emit(GetProductVideo404State());
        }
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetProductVideoErrorState());
    });
  }

  // Get VR 3D Model :
  VRModel vrModel = VRModel();
  String vrUrl = '';

  getVR({
    required String proId,
  }) {
    emit(GetProductVRImageLoadingState());
    DioHelper.instance.getData(
      url: Urls.getVRModel4Product + proId,
      query: {"vrImage": "1"},
    ).then((value) {
      vrModel = VRModel.fromJson(value.data);
      if (vrModel.data?.vrImage?.vrImage != null) {
        if (vrModel.data!.vrImage!.vrImage!.isNotEmpty) {
          vrUrl = vrModel.data!.vrImage!.vrImage!;
          emit(GetProductVRImageDoneState());
        }
      } else {
        emit(GetProductVRImage404State());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetProductVRImageErrorState());
    });
  }

  // Get AR 3D Model :
  ARModel arModel = ARModel();
  String arUrl = '';

  getAR({
    required String proId,
  }) {
    emit(GetProductARImageLoadingState());
    DioHelper.instance.getData(
      url: Urls.getVRModel4Product + proId,
      query: {"arImage": "1"},
    ).then((value) {
      arModel = ARModel.fromJson(value.data);
      if (arModel.data?.arImage?.arImage != null) {
        if (arModel.data!.arImage!.arImage!.isNotEmpty) {
          arUrl = arModel.data!.arImage!.arImage!;
          emit(GetProductARImageDoneState());
        }
      } else {
        emit(GetProductARImage404State());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetProductARImageErrorState());
    });
  }
}
