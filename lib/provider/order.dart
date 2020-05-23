//this file  is to manage the order

import 'package:flutter/material.dart';
import '../provider/cart.dart';

class OrderItems {
  //this is how my Orders look like
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItems({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  //here i create an empty list;
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [...orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItems(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
