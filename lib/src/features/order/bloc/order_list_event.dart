part of 'order_list_bloc.dart';

@immutable
sealed class OrderListEvent {}

class AddToOrderEvent extends OrderListEvent{
  final DrinkModel drink;

  AddToOrderEvent({required this.drink});
}

class RemoveFromOrderEvent  extends OrderListEvent {
    final DrinkModel drink;

  RemoveFromOrderEvent({required this.drink});
}

class ClearOrderEvent  extends OrderListEvent{}
