import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/cart_models/user_cart_model.dart';

part 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  // Add To Cart:

  add2Cart({
    required String productId,
    required String classId,
    required String groupId,
    required int quantity,
  }) {
    emit(Add2CartLoadingState());
    DioHelper.postData(
      url: Urls.add2Cart,
      token: Constants.bearer + Constants.token,
      data: {
        "productId": productId,
        "classId": classId,
        "groupId": groupId,
        "quantity": quantity,
      },
    ).then((value) {
      emit(Add2CartDoneState());
    }).catchError((err) {
      print(err.toString());
      emit(Add2CartErrorState());
    });
  }

  // Get User Cart:

  UserCartModel userCartModel = UserCartModel();

  List<UserCartItem> items = [];

  getUserCart() {
    emit(GetUserCartLoadingState());

    DioHelper.getData(
      url: Urls.getUserCart,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      userCartModel = UserCartModel.fromJson(value.data);
      if (userCartModel.data?.items != null) {
        items = userCartModel.data!.items;
        emit(GetUserCartDoneState());
      } else {
        emit(GetUserCartEmptyState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetUserCartErrorState());
    });
  }

  // Delete Product From Cart:
  deleteProFromCart({
    required String? groupId,
    required String? itemID,
  }) {
    emit(DeleteProFromCartLoadingState());
    DioHelper.postData(
      url: Urls.deleteProFromCart,
      token: Constants.bearer + Constants.token,
      data: {
        "groupId": groupId,
        "itemID": itemID,
      },
    ).then((value) {
      if (value.data['status']) {
        emit(DeleteProFromCartDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(DeleteProFromCartErrorState());
    });
  }

  // Operations On Cart
  operationsOnCart({
    required String productId,
    required String classId,
    required String groupId,
    required String itemID,
    required bool increment,
  }) {
    emit(DoOperationOnCartLoadingState());
    DioHelper.postData(
      url: Urls.operationsOnCart,
      token: Constants.bearer + Constants.token,
      data: {
        "itemID": itemID,
        "productId": productId,
        "classId": classId,
        "groupId": groupId,
        "increment": increment,
      },
    ).then((value) {
      if (value.data['status']) {
        emit(DoOperationOnCartDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(DoOperationOnCartErrorState());
    });
  }
}
