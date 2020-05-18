//this is the first page of the app which shows overall product we have
import 'package:flutter/material.dart';
import 'package:shop_state/widget/product_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Myshopex'),
      ),
      body: ProductGrid(),
    );
  }
}

