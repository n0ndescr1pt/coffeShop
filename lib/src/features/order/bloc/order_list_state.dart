part of 'order_list_bloc.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}

class DoOrderState extends OrderListState {
  final List<DrinkModel> drinks;
  final double summ;

  DoOrderState({required this.drinks,required this.summ});


}

class ClearState extends OrderListState {}
