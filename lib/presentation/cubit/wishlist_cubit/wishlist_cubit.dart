import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/presentation/components/toast_notifications.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/urls.dart';
import '../../../domain/models/wishlist_models/wishlist_model.dart';

part 'wishlist_states.dart';

class WishlistCubit extends Cubit<WishlistStates> {
  WishlistCubit() : super(WishlistInitialState());

  static WishlistCubit get(context) => BlocProvider.of(context);

  // Add product 2 Wishlist:

  addPro2Wishlist({required String proId}) {
    emit(AddPro2WishlistLoadingState());

    DioHelper.postData(
      url: Urls.add2WishList,
      token: Constants.bearer + Constants.token,
      data: {"product_id": proId},
    ).then((value) {
      if (value.data['status']) {
        emit(AddPro2WishlistDoneState());
        getMyWishlist();
      }
    }).catchError((err) {
      print(err.toString());
      emit(AddPro2WishlistErrorState());
    });
  }

  // Remove product from Wishlist:

  removeProFromWishlist({
    required String proId,
  }) {
    emit(RemoveProFromWishlistLoadingState());

    DioHelper.postData(
      url: Urls.removeProFromWishlist,
      token: Constants.bearer + Constants.token,
      data: {"product_id": proId},
    ).then((value) {
      if (value.data['status']) {
        emit(RemoveProFromWishlistDoneState());
        getMyWishlist();
      }
    }).catchError((err) {
      emit(RemoveProFromWishlistErrorState());
    });
  }

  // Get My Wishlist:
  WishlistModel wishlistModel = WishlistModel();
  List<WishlistProduct> myProducts = [];

  getMyWishlist() {
    if (Constants.token.isNotEmpty) {
      emit(GetMyWishlistLoadingState());
      DioHelper.getData(
        url: Urls.getMyWishlist,
        token: Constants.bearer + Constants.token,
      ).then((value) {
        wishlistModel = WishlistModel.fromJson(value.data);
        if (wishlistModel.data?.products != null) {
          myProducts = wishlistModel.data!.products;
          emit(GetMyWishlistDoneState());
        } else {
          emit(YouHaveNotWishlistState());
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMyWishlistErrorState());
      });
    } else {
      showToast(
          text: AppStrings.login2ShowYourWishlist, state: ToastStates.WARNING);
    }
  }

  // Delete My Wishlist:

  deleteMyWishlist() {
    emit(DeleteMyWishlistLoadingState());
    DioHelper.deleteData(
      url: Urls.deleteMyWishlist,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        emit(DeleteMyWishlistDoneState());
        getMyWishlist();
      }
    }).catchError((err) {
      print(err.toString());
      emit(DeleteMyWishlistErrorState());
    });
  }

  // Check If Pro Is In My Wishlist:

  bool isProInMyWishlist({
    required String proId,
  }) {
    for (WishlistProduct product in myProducts) {
      if (product.productId?.id == proId) {
        return true;
      }
    }
    return false;
  }
}
