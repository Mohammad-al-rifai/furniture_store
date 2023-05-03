part of 'merchant_layout_cubit.dart';

@immutable
abstract class MerchantLayoutStates {}

class MerchantLayoutInitialState extends MerchantLayoutStates {}

// Get Merchant Products States:
class GetMerchantProLoadingState extends MerchantLayoutStates {}

class GetMerchantProDoneState extends MerchantLayoutStates {
  final List<MerchantProduct>? products;

  GetMerchantProDoneState({this.products});
}

class GetMerchantProErrorState extends MerchantLayoutStates {}
