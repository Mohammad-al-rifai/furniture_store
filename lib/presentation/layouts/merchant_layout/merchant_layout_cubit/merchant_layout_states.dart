part of 'merchant_layout_cubit.dart';

@immutable
abstract class MerchantLayoutStates {}

class MerchantLayoutInitialState extends MerchantLayoutStates {}

// Get Merchant Products States:
class GetMerchantProLoadingState extends MerchantLayoutStates {}

class GetMerchantProDoneState extends MerchantLayoutStates {
  final List<Product>? products;

  GetMerchantProDoneState({this.products});
}

class GetMerchantProErrorState extends MerchantLayoutStates {}

// Get Merchant Categories

class GetMerchantCategoriesLoadingState extends MerchantLayoutStates {}

class GetMerchantCategoriesDoneState extends MerchantLayoutStates {}

class GetMerchantCategoriesErrorState extends MerchantLayoutStates {}

// Get Merchant Offers

class GetMerchantOffersLoadingState extends MerchantLayoutStates {}

class GetMerchantOffersDoneState extends MerchantLayoutStates {}

class GetMerchantOffersErrorState extends MerchantLayoutStates {}

// Get Merchant Offers

class GetMerchantProsByCatLoadingState extends MerchantLayoutStates {}

class GetMerchantProsByCatDoneState extends MerchantLayoutStates {}

class GetMerchantProsByCatErrorState extends MerchantLayoutStates {}
