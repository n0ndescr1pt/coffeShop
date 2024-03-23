import 'package:coffe_shop/src/features/menu/bloc/coffe_list_bloc/coffe_list_bloc.dart';
import 'package:coffe_shop/src/features/menu/data/coffe_services.dart';
import 'package:coffe_shop/src/features/menu/models/drink_model.dart';
import 'package:coffe_shop/src/features/order/bloc/order_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyBottomSheet extends StatelessWidget {
  final List<DrinkModel> drinks;
  final BuildContext ctx;
  const MyBottomSheet({super.key, required this.drinks, required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Ваш заказ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    GetIt.I<OrderListBloc>().add(ClearOrderEvent());
                  },
                  icon: const Icon(Icons.restore_from_trash_outlined)),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Image.network(height: 55, width: 55, drinks[index].image),
                      const SizedBox(width: 8),
                      Text(drinks[index].name),
                      const SizedBox(width: 8),
                      Text("x${drinks[index].counter.toString()}"),
                      Expanded(child: Container()),
                      Text(
                        "${drinks[index].price} ₽",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 46),
                  backgroundColor: Colors.blue[200],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                onPressed: () async {
                  await GetIt.I<CoffeServices>().sendOrder(context);
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                  }
                  GetIt.I<OrderListBloc>().add(ClearOrderEvent());
                },
                child: const Text("Оформить заказ",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }
}
