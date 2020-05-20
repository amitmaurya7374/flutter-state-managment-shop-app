import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/products_provider.dart';
import 'products_item.dart';
 ///this file build a grid on productoverview screen
 

 class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavs;
  ProductsGrid(this.showOnlyFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context); //here i am providing the listener for any data change
    final products = showOnlyFavs?productsData.favoritesItems:productsData.items;
    return Card( //i added the card widget and every thing work properly
      elevation: 6.0,
        // shadowColor: Colors.pink,      
          child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // create:(context)=> products[i], //i did this because i already initiate the single Product into Products class
                 value: products[i], //i did this because the create give error cannot able to handle the list so use this approach when you using list
                  child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
              ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}