part of 'test_cubit.dart';

@immutable
abstract class TestStates {}

class TestInitial extends TestStates {}

class AddCartLoadingState extends TestStates {}

class AddCartDoneState extends TestStates {}

class AddCartErrorState extends TestStates {}

//Operations On Cart:
class OperationsOnCartLoadingState extends TestStates {}

class OperationsOnCartDoneState extends TestStates {}

class OperationsOnCartErrorState extends TestStates {}
