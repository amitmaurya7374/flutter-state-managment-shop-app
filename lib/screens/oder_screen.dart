//this will display the order

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' ;
import 'package:shop_state/widget/app_drawer.dart';
import 'package:shop_state/widget/order_item.dart';
import '../provider/order.dart' show Orders;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-page';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      //here i used my AppDrawer which i built
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, i) => OrderItem(order: orderData.orders[i],),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
