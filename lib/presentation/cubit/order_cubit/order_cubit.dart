import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/domain/models/order_models/user_orders_model.dart';
import 'package:ecommerce/domain/params/order_params/order_advanced_search_params.dart';
import 'package:ecommerce/domain/requests/order_requests/add_order_request_model.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/order_models/order_advanced_search_model.dart';
import '../../../domain/models/order_models/single_order_model.dart';

part 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);

  String orderID = '';

  // Add Order Method:
  addOrder({
    required AddOrderRequest addOrderRequest,
  }) {
    emit(AddOrderLoadingState());

    DioHelper.postData(
      url: Urls.addOrder,
      token: Constants.bearer + Constants.token,
      data: addOrderRequest.toJson(),
    ).then((value) {
      if (value.data['status']) {
        orderID = value.data["data"]["_id"];
        emit(AddOrderDoneState(orderId: orderID));
      }
    }).catchError((err) {
      print(err.toString());
      emit(AddOrderErrorState());
    });
  }

// 2. Get User Orders:

  UserOrdersModel ordersModel = UserOrdersModel();
  List<OrderData> orders = [];

  getUserOrders() {
    emit(GetUserOrdersLoadingState());

    DioHelper.getData(
      url: Urls.getUserOrders,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        ordersModel = UserOrdersModel.fromJson(value.data);
        if (ordersModel.data != null) {
          orders = ordersModel.data!;
        }
        emit(GetUserOrdersDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetUserOrdersErrorState());
    });
  }

// 3. Get Single Order By ID:
  SingleOrderModel singleOrderModel = SingleOrderModel();

  getOrderById({
    required String orderId,
  }) {
    emit(GetSingleOrderByIdLoadingState());
    DioHelper.getData(
      url: Urls.getOrderById + orderId,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        singleOrderModel = SingleOrderModel.fromJson(value.data);
        emit(GetSingleOrderByIdDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetSingleOrderByIdErrorState());
    });
  }
}
