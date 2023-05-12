part of 'order_cubit.dart';

@immutable
abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

// Add Order States:

class AddOrderLoadingState extends OrderStates {}

class AddOrderDoneState extends OrderStates {}

class AddOrderErrorState extends OrderStates {}
