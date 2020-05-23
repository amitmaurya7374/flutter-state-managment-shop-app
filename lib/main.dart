import 'package:flutter/material.dart';
import 'package:shop_state/provider/cart.dart';
import 'package:shop_state/provider/order.dart';
import 'package:shop_state/screens/cart_screen.dart';
import 'package:shop_state/screens/oder_screen.dart';
import 'package:shop_state/screens/product_detail_screen.dart';
import 'package:shop_state/screens/products_overview_screen.dart';
import './provider/products_provider.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(//register the providers
            providers: [
              ChangeNotifierProvider(
                create: (context)=>Products(),
              ),
              ChangeNotifierProvider(
                create: (context)=>Cart(),
              ),
              ChangeNotifierProvider(
                create: (context)=>Orders(),
              ),
            ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName:(ctx)=>CartScreen(),
            OrderScreen.routeName:(ctx)=>OrderScreen(),
          }),
    );
  }
}

