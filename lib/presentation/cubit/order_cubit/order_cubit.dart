import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/domain/models/blockchain/pro_history_model.dart';
import 'package:ecommerce/domain/models/blockchain/users_point_history.dart';
import 'package:ecommerce/domain/models/order_models/single_order_model.dart';
import 'package:ecommerce/domain/models/order_models/user_orders_model.dart';
import 'package:ecommerce/domain/requests/order_requests/add_order_request_model.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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

  // 4. Get Order History:

  ProHistoryModel proHistoryModel = ProHistoryModel();

  getOrderHistory({
    required String proId,
    required String orderId,
  }) {
    emit(GetOrderHistoryLoadingState());
    DioHelper.getData(
      url: Urls.getOrderHistory + proId,
      token: Constants.bearer + Constants.token,
      query: {"order": orderId},
    ).then((value) {
      if (value.data['status']) {
        proHistoryModel = ProHistoryModel.fromJson(value.data);
        emit(GetOrderHistoryDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetOrderHistoryErrorState());
    });
  }

// 5. Get User's Points History:
  UsersPointsModel usersPointsModel = UsersPointsModel();

  getUsersPointsHistory() {
    emit(GetUsersPointsLoadingState());
    DioHelper.getData(
      url: Urls.getUserPointsHistory,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        usersPointsModel = UsersPointsModel.fromJson(value.data);
        emit(GetUsersPointsDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetUsersPointsErrorState());
    });
  }

  // 6. Get My Balance:

  String myBalance = '';

  getMyBalance() {
    emit(GetMyBalanceLoadingState());
    DioHelper.getData(
      url: Urls.getMyBalance,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        myBalance = value.data['data'];
        emit(GetMyBalanceDoneState());
      }
    }).catchError((err) {
      emit(GetMyBalanceErrorState());
    });
  }

  // 7. Cancel Order:
  cancelOrder({
    required String orderId,
  }) {
    emit(CancelOrderLoadingState());

    DioHelper.putData(
      url: Urls.cancelOrder,
      token: Constants.bearer + Constants.token,
      data: {
        "id": orderID,
        "status": "cancelled",
      },
    ).then((value) {
      if (value.data['status']) {
        emit(CancelOrderDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(CancelOrderErrorState());
    });
  }
}
