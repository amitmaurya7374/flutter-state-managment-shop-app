import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/cart.dart' show Cart;
import 'package:shop_state/provider/order.dart';
import '../widget/cartItem.dart';

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
                      '\₹ ${cart.totalAmount.toStringAsFixed(2)}',
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
                      Provider.of<Orders>(context,listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();  
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
          SizedBox(
            height: 10.0,
          ),

          ///as we Know ListView does work inside the column widget
          ///so warp inside the Expanded
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                price: cart.items.values.toList()[index].price,
                title: cart.items.values.toList()[index].title,
                quantity: cart.items.values.toList()[index].quantity,
              ), //widget CartItem,
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
