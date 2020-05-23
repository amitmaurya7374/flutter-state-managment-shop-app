//this is a side Drawer widget help to build drawer

import 'package:flutter/material.dart';
import 'package:shop_state/screens/oder_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //using the drawer widget to built the draweer
      elevation: 20.0, 
      child: Column(
        //this is the thing i want into my Drawer
        children: <Widget>[
          AppBar(
            title: Text('Hello Freinds'),
            automaticallyImplyLeading:
                false, //this will never add the back button into the app bar
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
