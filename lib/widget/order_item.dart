import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_state/provider/order.dart' as ord;
import 'package:intl/intl.dart';

//making this stateFull because we need the expanded functionality which is
///only used by this widget
class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(
                widget.order.products.length * 20.0 + 10,
                180,
              ),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(prod.title),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${prod.quantity} x \$${prod.price}'),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
