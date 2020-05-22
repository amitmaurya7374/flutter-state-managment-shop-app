import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 30),
                  Chip(
                    label: Text(
                      '\₹ ${cart.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 6.0,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  RaisedButton(
                    elevation: 10.0,
                    onPressed: () {
                      print('hello world');
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
