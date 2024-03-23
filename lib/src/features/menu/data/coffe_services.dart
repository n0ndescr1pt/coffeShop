import 'dart:convert';
import 'package:coffe_shop/src/features/menu/models/coffee_model.dart';
import 'package:coffe_shop/src/features/menu/models/drink_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CoffeServices {
  Future<List<DrinkModel>> getDrinks() async {
    final response = await http.get(
        Uri.parse('https://coffeeshop.academy.effective.band/api/v1/products'));

    final List<DrinkModel> drinkList = [];
    if (response.statusCode == 200) {
      for (var element in jsonDecode(utf8.decode(response.bodyBytes))['data']) {
        drinkList.add(DrinkModel.fromJson(element));
      }
      return drinkList;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<List<CoffeModel>> getData() async {
    final List<CoffeModel> map = [];
    final listCategory = await getCategoryId();
    print(listCategory);
    final List<DrinkModel> listDrinks = await getDrinks();

    listCategory.forEach((key, value) {
      final List<DrinkModel> drinks = [];
      for (int i = 0; i < listDrinks.length; i++) {
        if (listDrinks[i].id == key) {
          drinks.add(
            DrinkModel(
                id: listDrinks[i].id,
                name: listDrinks[i].name,
                image: listDrinks[i].image,
                price: listDrinks[i].price,
                category: listDrinks[i].category,
                productID: listDrinks[i].productID),
          );
        }
      }
      map.add(CoffeModel(title: value, drinks: drinks));
    });

    return map;
  }

  Future<Map<int, String>> getCategoryId() async {
    final response = await http.get(Uri.parse(
        'https://coffeeshop.academy.effective.band/api/v1/products/categories'));

    final Map<int, String> categoryMap = {};
    if (response.statusCode == 200) {
      for (var element in jsonDecode(utf8.decode(response.bodyBytes))['data']) {
        categoryMap[element['id']] = element['slug'];
      }
      return categoryMap;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<void> sendOrder(BuildContext context) async {
    final Map<String, dynamic> userData = {
      "positions": {"1": 12},
      "token": ""
    };
    final response = await http.post(
      Uri.parse('https://coffeeshop.academy.effective.band/api/v1/orders'),
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      if (context.mounted) {
        print(" sadsd");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Заказ создан"),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Возникла ошибка при заказе"),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
}
