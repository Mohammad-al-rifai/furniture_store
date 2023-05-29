part of 'order_cubit.dart';

@immutable
abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

// Add Order States:

class AddOrderLoadingState extends OrderStates {}

class AddOrderDoneState extends OrderStates {}

class AddOrderErrorState extends OrderStates {}

// Get User Orders States:

class GetUserOrdersLoadingState extends OrderStates {}

class GetUserOrdersDoneState extends OrderStates {}

class GetUserOrdersErrorState extends OrderStates {}

// Get Single Order By ID States:

class GetSingleOrderByIdLoadingState extends OrderStates {}

class GetSingleOrderByIdDoneState extends OrderStates {}

class GetSingleOrderByIdErrorState extends OrderStates {}

