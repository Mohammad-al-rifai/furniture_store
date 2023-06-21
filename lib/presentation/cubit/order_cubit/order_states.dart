part of 'order_cubit.dart';

@immutable
abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

// Add Order States:

class AddOrderLoadingState extends OrderStates {}

class AddOrderDoneState extends OrderStates {
  final String? orderId;

  AddOrderDoneState({required this.orderId});
}

class AddOrderErrorState extends OrderStates {}

// Get User Orders States:

class GetUserOrdersLoadingState extends OrderStates {}

class GetUserOrdersDoneState extends OrderStates {}

class GetUserOrdersErrorState extends OrderStates {}

// Get Single Order By ID States:

class GetSingleOrderByIdLoadingState extends OrderStates {}

class GetSingleOrderByIdDoneState extends OrderStates {}

class GetSingleOrderByIdErrorState extends OrderStates {}

// Get Order History States:

class GetOrderHistoryLoadingState extends OrderStates {}

class GetOrderHistoryDoneState extends OrderStates {}

class GetOrderHistoryErrorState extends OrderStates {}

// Get Users Points History States:

class GetUsersPointsLoadingState extends OrderStates {}

class GetUsersPointsDoneState extends OrderStates {}

class GetUsersPointsErrorState extends OrderStates {}

// Get My Balance States:

class GetMyBalanceLoadingState extends OrderStates {}

class GetMyBalanceDoneState extends OrderStates {}

class GetMyBalanceErrorState extends OrderStates {}

// Cancel States:

class CancelOrderLoadingState extends OrderStates {}

class CancelOrderDoneState extends OrderStates {}

class CancelOrderErrorState extends OrderStates {}
