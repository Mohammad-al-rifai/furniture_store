import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/domain/models/order_models/user_orders_model.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);

  // Add Order Method:

  addOrder({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String country,
    required String city,
    required String region,
    required String streetNumber,
    required String houseNumber,
    required String description,
  }) {
    emit(AddOrderLoadingState());

    DioHelper.postData(
      url: Urls.addOrder,
      token: Constants.bearer + Constants.token,
      data: {
        "userInfo": {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phone": phone
        },
        "shippingAddress": {
          "country": country,
          "city": city,
          "region": region,
          "streetNumber": streetNumber,
          "houseNumber": houseNumber,
          "description": description
        },
        "paymentMethod": "paypal"
      },
    ).then((value) {
      if (value.data['status']) {
        emit(AddOrderDoneState());
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
}
