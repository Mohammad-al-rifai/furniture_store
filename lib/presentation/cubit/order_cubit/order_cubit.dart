import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/domain/requests/order_requests/add_order_request_model.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);

  // Add Order Method:

  addOrder({
    required AddOrderRequestModel orderRequestModel,
  }) {
    emit(AddOrderLoadingState());

    DioHelper.postData(
      url: Urls.addOrder,
      token: Constants.bearer + Constants.token,
      data: orderRequestModel.toJson(),
    ).then((value) {
      if (value.data['status']) {
        emit(AddOrderDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(AddOrderErrorState());
    });
  }
}
