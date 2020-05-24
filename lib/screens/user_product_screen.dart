///this file is users file
///In this file user can add ,edit,and delete the products

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/widget/app_drawer.dart';
import 'package:shop_state/widget/user_product.dart';
import '../provider/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (_, index) => UserProductItem(
            title: productData.items[index].title,
            imageUrl: productData.items[index].imageUrl,
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
