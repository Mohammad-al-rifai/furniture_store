part of 'cart_cubit.dart';

@immutable
abstract class CartStates {}

class CartInitialState extends CartStates {}

// Add 2 Cart States:

class Add2CartLoadingState extends CartStates {}

class Add2CartDoneState extends CartStates {}

class Add2CartErrorState extends CartStates {}

// Get User Cart States:

class GetUserCartLoadingState extends CartStates {}

class GetUserCartDoneState extends CartStates {}

class GetUserCartEmptyState extends CartStates {}

class GetUserCartErrorState extends CartStates {}

// Delete Product From Cart States:

class DeleteProFromCartLoadingState extends CartStates {}

class DeleteProFromCartDoneState extends CartStates {}

class DeleteProFromCartErrorState extends CartStates {}

// Operations On Cart States:

class DoOperationOnCartLoadingState extends CartStates {}

class DoOperationOnCartDoneState extends CartStates {}

class DoOperationOnCartErrorState extends CartStates {}
