import 'package:flutter/material.dart';
import 'package:shop_state/screens/product_detail_screen.dart';
import 'package:shop_state/screens/products_overview_screen.dart';
import './provider/products_provider.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(//here i register the Provider
          create: (context)=>Products(), //create Take a function which should return a instacne of your provided class
          child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName:(context)=>ProductOverViewScreen(),
        },
      ),
    );
  }
}

