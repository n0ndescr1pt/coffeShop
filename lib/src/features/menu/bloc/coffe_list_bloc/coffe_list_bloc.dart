import 'package:coffe_shop/src/features/menu/data/coffe_services.dart';
import 'package:coffe_shop/src/features/menu/models/coffee_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'coffe_list_event.dart';
part 'coffe_list_state.dart';

class CoffeListBloc extends Bloc<CoffeListEvent, CoffeListState> {
  CoffeListBloc({required this.coffeServices}) : super(CoffeListInitial()) {
    on<LoadCoffeListEvent>((event, emit) async {
      final coffeList = await coffeServices.getData();
      emit(CoffeListLoaded(coffeList: coffeList));
    });
  }
  final CoffeServices coffeServices;
}
