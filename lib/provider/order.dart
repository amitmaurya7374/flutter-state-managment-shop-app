//this file  is to manage the order

import 'dart:convert';

import 'package:flutter/material.dart';
import '../provider/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  //this is how my Orders look like
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  //here i create an empty list;
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://shopping-app-45175.firebaseio.com/orders.json';
    final dateTimeStamp = DateTime.now();
 final response= await  http.patch(
      url,
      body: json.encode(
        {
          'amount':total,
          'dateTime':dateTimeStamp.toIso8601String(),
          'product':cartProducts.map((cp)=>{
            'id':cp.id,
            'title':cp.title,
            'quantity':cp.quantity,
            'price':cp.price,
          } ).toList(),
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: dateTimeStamp,
      ),
    );
    notifyListeners();
  }
}
