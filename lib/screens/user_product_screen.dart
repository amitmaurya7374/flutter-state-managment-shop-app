///this file is users file
///In this file user can add ,edit,and delete the products

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/screens/edit_product.dart';
import 'package:shop_state/widget/app_drawer.dart';
import 'package:shop_state/widget/user_product.dart';
import '../provider/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  Future<void> _refreshProducts(BuildContext context) async{
   await Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(//this will help in refreshing the page  
        onRefresh: ()=>_refreshProducts(context),//this take a function which return the empty future
              child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemBuilder: (_, index) => UserProductItem(
              id: productData.items[index].id,
              title: productData.items[index].title,
              imageUrl: productData.items[index].imageUrl,
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
