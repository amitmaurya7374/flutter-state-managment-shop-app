import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  //I need some data for the widget to show some information
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    ///here now i want the swipe to delete functionality
    ///so i am goig to use dismissible widget
    ///it take a key for identify which card to delete

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.delete, color: Colors.white, size: 40.0),
          ),
        ),
      ), //it show behindthat element once you start swipping
      //we use OnDismissed to permanetly delete the itemsfrom the cart
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      //creating a dialog box
      confirmDismiss: (direction) {
        //confirmDismiss return future
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('By Confirm this action you can delete that item'),
                  actions: <Widget>[
                    RaisedButton(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      color: Colors.deepPurple,
                      child: Text('Confirm',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        Navigator.of(context).pop(true);
                      },
                    ),
                    RaisedButton(
                      elevation: 10.0,
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Text('Cancel',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 22.0,
              child: FittedBox(
                  child: Padding(
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
      ),
    );
  }
}
