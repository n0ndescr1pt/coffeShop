part of 'coffe_list_bloc.dart';

@immutable
sealed class CoffeListState {}

final class CoffeListInitial extends CoffeListState {}

class CoffeListLoading extends CoffeListState {}

class CoffeListLoaded extends CoffeListState {
  final List<CoffeModel> coffeList;

  CoffeListLoaded({required this.coffeList});
}


