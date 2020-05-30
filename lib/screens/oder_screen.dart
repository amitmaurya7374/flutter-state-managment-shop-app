//this will display the order

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' ;
import 'package:shop_state/widget/app_drawer.dart';
import 'package:shop_state/widget/order_item.dart';
import '../provider/order.dart' show Orders;

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-page';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
 @override
  void initState() {
    Future.delayed(Duration.zero).then((_)async{
      setState(() {
        _isLoading = true;
      });
    await  Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
    setState(() {
      _isLoading = false;
      });
    } );
    super.initState();
  }
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
