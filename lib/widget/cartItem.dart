import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  //I need some data for the widget to show some information
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    this.id,
    this.title,
    this.price,
    this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: 22.0,
            child: FittedBox(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$price'),
            )),
          ),
          title: Text(title),
          subtitle: Text(
            'Total:\₹${(price * quantity)}',
          ),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
