part of 'search_cubit.dart';

@immutable
abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

// Advanced Search States:

class OrderAdvancedSearchLoadingState extends SearchStates {}

class OrderAdvancedSearchDoneState extends SearchStates {
  final List<Datum>? data;

  OrderAdvancedSearchDoneState({this.data});
}

class OrderAdvancedSearchErrorState extends SearchStates {}
