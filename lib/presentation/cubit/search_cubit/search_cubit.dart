import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/urls.dart';
import '../../../data/network/remote/dio_helper.dart';
import '../../../domain/models/order_models/order_advanced_search_model.dart';
import '../../../domain/params/order_params/order_advanced_search_params.dart';
import '../../resources/constants_manager.dart';
import '../../resources/string_manager.dart';
import '../../screens/search/order_search/order_search_widgets/filter_data_class.dart';

part 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  // CreateBillBloc.get(context).fitch();

  // 1. Order Advanced Search:

  OrderAdvancedSearchModel orderAdvancedSearchModel =
      OrderAdvancedSearchModel();

  OrderAdvancedSearchParams? orderParams = OrderAdvancedSearchParams();

  List<FiltersData> getFiltersList = [
    FiltersData(
        filterName: AppStrings.fName, paramKey: 'firstName', isActive: true),
    FiltersData(filterName: AppStrings.lName, paramKey: 'lastName'),
    FiltersData(filterName: AppStrings.email, paramKey: 'email'),
    FiltersData(filterName: AppStrings.phone, paramKey: 'phone'),
    FiltersData(filterName: AppStrings.orderStatus, paramKey: 'status'),
    FiltersData(filterName: AppStrings.totalPrice, paramKey: 'totalPrice'),
    FiltersData(filterName: AppStrings.country, paramKey: 'country'),
    FiltersData(filterName: AppStrings.city, paramKey: 'city'),
    FiltersData(filterName: AppStrings.region, paramKey: 'region'),
    FiltersData(filterName: AppStrings.streetNumber, paramKey: 'streetNumber'),
    FiltersData(filterName: AppStrings.houseNumber, paramKey: 'houseNumber'),
    FiltersData(
        filterName: AppStrings.paymentMethod, paramKey: 'paymentMethod'),
    FiltersData(
        filterName: AppStrings.paymentStatus, paramKey: 'paymentStatus'),
  ];

  orderAdvancedSearch({
    OrderAdvancedSearchParams? params,
  }) {
    emit(OrderAdvancedSearchLoadingState());
    DioHelper.instance.getData(
      url: Urls.orderAdvancedSearch,
      token: Constants.bearer + Constants.token,
      query: params?.toJson(),
    ).then((value) {
      if (value.data['status']) {
        orderAdvancedSearchModel =
            OrderAdvancedSearchModel.fromJson(value.data);
        emit(OrderAdvancedSearchDoneState(data: orderAdvancedSearchModel.data));
      }
    }).catchError((err) {
      print(err.toString());
      emit(OrderAdvancedSearchErrorState());
    });
  }
}
