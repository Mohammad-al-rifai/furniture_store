import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/domain/models/product_models/product_galery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/categories/all_categories_model.dart';
import '../../../../domain/models/product_models/products_list_model.dart';

part 'merchant_layout_states.dart';

class MerchantLayoutCubit extends Cubit<MerchantLayoutStates> {
  MerchantLayoutCubit() : super(MerchantLayoutInitialState());

  static MerchantLayoutCubit get(context) => BlocProvider.of(context);

  // 1- Get Merchant Products:
  ProductsListModel? merchantProductsModel = ProductsListModel();
  List<Product> products = [];

  getMerchantProducts({
    required String merchantId,
  }) {
    emit(GetMerchantProLoadingState());
    if (products.isNotEmpty) {
      emit(GetMerchantProDoneState(products: products));
    } else {
      DioHelper.instance.getData(
        url: Urls.getMerchantProducts + merchantId,
      ).then((value) {
        merchantProductsModel = ProductsListModel.fromJson(value.data);
        if (merchantProductsModel?.data?.products != null) {
          if (merchantProductsModel!.data!.products.isNotEmpty) {
            products = merchantProductsModel!.data!.products;
            emit(GetMerchantProDoneState(products: products));
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantProErrorState());
      });
    }
  }

  // Get Merchant Categories
  CategoriesModel? categoriesModel = CategoriesModel();
  List<CategoryData> categories = [];

  getMerchantCategories({
    required String merchantId,
  }) {
    emit(GetMerchantCategoriesLoadingState());
    if (categories.isNotEmpty) {
      emit(GetMerchantCategoriesDoneState());
    } else {
      DioHelper.instance.getData(
        url: Urls.getCategories,
        query: {'owner': merchantId},
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        if (value.data['status']) {
          if (categoriesModel?.data != null &&
              categoriesModel!.data!.isNotEmpty) {
            categories = categoriesModel!.data!;
            emit(GetMerchantCategoriesDoneState());
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantCategoriesLoadingState());
      });
    }
  }

  // 3. Get Merchant Products By Category:

  ProductsListModel? merchantProductsByCatModel = ProductsListModel();
  List<Product> productsOfCat = [];

  getProductsByCategory({
    required String catName,
    required String? merchantId,
  }) {
    emit(GetMerchantProsByCatLoadingState());

    if (productsOfCat.isNotEmpty) {
      emit(GetMerchantProsByCatDoneState());
    } else {
      DioHelper.instance.getData(
        url: Urls.getMerchantProsByCat + catName,
        query: {
          "owner": merchantId,
        },
      ).then((value) {
        merchantProductsByCatModel = ProductsListModel.fromJson(value.data);
        if (value.data['status'] &&
            merchantProductsByCatModel?.data?.products != null) {
          if (merchantProductsByCatModel!.data!.products.isNotEmpty) {
            productsOfCat = merchantProductsByCatModel!.data!.products;
            emit(GetMerchantProsByCatDoneState());
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantProsByCatErrorState());
      });
    }
  }
}
