import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/data/network/remote/dio_helper.dart';
import 'package:ecommerce/presentation/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'test_states.dart';

class TestCubit extends Cubit<TestStates> {
  TestCubit() : super(TestInitial());

  static TestCubit get(context) => BlocProvider.of(context);

  // Add 2 Cart Function:
  add2Cart() {
    emit(AddCartLoadingState());
    DioHelper.instance.postData(
      url: Urls.add2Cart,
      token: Constants.bearer + Constants.token,
      data: {
        "productId": "6461dd2e23920a30c28904f3",
        "classId": "6461dd2e23920a30c28904f4",
        "groupId": "6461dd2e23920a30c28904f5",
        "quantity": 1
      },
    ).then((value) {
      emit(AddCartDoneState());
    }).catchError((err) {
      print(err.toString());
      emit(AddCartErrorState());
    });
  }

  // Operations On Cart:

  operationsOnCart() {
    emit(OperationsOnCartLoadingState());
    DioHelper.instance.postData(
      url: Urls.operationsOnCart,
      token: Constants.bearer + Constants.token,
      data: {
        "itemID": "648ee11d9f5a5496cb71c650",
        "productId": "646f633eda6f8d0be08429f7",
        "classId": "646f633eda6f8d0be08429f8",
        "groupId": "646f633eda6f8d0be08429f9",
        "increment": true
      },
    ).then((value) {
      emit(OperationsOnCartDoneState());
    }).catchError((err) {
      print(err.toString());
      emit(OperationsOnCartErrorState());
    });
  }
}
