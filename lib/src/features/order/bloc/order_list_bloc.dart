import 'package:coffe_shop/src/features/menu/models/drink_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final Map<int, DrinkModel> drinks;
  OrderListBloc(this.drinks) : super(OrderListInitial()) {
    on<AddToOrderEvent>((event, emit) {
      drinks[event.drink.productID] = DrinkModel(
          id: event.drink.id,
          name: event.drink.name,
          image: event.drink.image,
          price: event.drink.price,
          category: event.drink.category,
          counter: event.drink.counter,
          productID: event.drink.productID);

      double price = 0;
      drinks.forEach((key, value) {
        price += double.parse(value.price) * value.counter!;
      });

      emit(DoOrderState(drinks: drinks.values.toList(), summ: price));
    });

    on<RemoveFromOrderEvent>((event, emit) {
      drinks[event.drink.productID] = DrinkModel(
          id: event.drink.id,
          name: event.drink.name,
          image: event.drink.image,
          price: event.drink.price,
          category: event.drink.category,
          counter: event.drink.counter,
          productID: event.drink.productID);

      if (drinks[event.drink.productID]!.counter == 0) {
        drinks.remove(event.drink.productID);
      }
      double price = 0;
      drinks.forEach((key, value) {
        price += double.parse(value.price) * value.counter!;
      });

      emit(DoOrderState(drinks: drinks.values.toList(), summ: price));
    });

    on<ClearOrderEvent>((event, emit){
      drinks.clear();
      emit(DoOrderState(drinks: drinks.values.toList(), summ: 0));
    });
  }
}
