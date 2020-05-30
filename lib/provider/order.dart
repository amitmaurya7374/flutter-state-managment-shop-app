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

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shopping-app-45175.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
   if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'] as double,//here is get the error
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      price: item['price'] as double,
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://shopping-app-45175.firebaseio.com/orders.json';
    final dateTimeStamp = DateTime.now();
    final response = await http.patch(
      url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': dateTimeStamp.toIso8601String(),
          'product': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
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
