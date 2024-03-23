import 'package:coffe_shop/src/features/menu/models/drink_model.dart';

class CoffeModel {
  final String title;
  final List<DrinkModel> drinks;

  CoffeModel({
    required this.title,
    required this.drinks,
  });
}
